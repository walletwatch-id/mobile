import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/utils/transition_builder.dart';
import 'package:walletwatch_mobile/views/auth/login.dart';
import 'package:walletwatch_mobile/views/chat/chatbot.dart';
import 'package:walletwatch_mobile/views/home2/home_notification.dart';
import 'package:walletwatch_mobile/views/home2/home.dart';
import 'package:walletwatch_mobile/views/monitor/transaction_add.dart';
import 'package:walletwatch_mobile/views/monitor/self_discovery.dart';
import 'package:walletwatch_mobile/views/monitor/self_discovery_finish.dart';
import 'package:walletwatch_mobile/views/monitor/transaction_history.dart';
import 'package:walletwatch_mobile/views/profile/profile_edit.dart';
import 'package:walletwatch_mobile/views/profile/profile_pdf.dart';
import 'package:walletwatch_mobile/views/splash/splash.dart';
import 'package:walletwatch_mobile/views/splash/splash_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MainApp());
  _configLoading();
}

void _configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.custom
    ..radius = 22
    ..progressColor = Colors.white
    ..backgroundColor = secondaryColor
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..dismissOnTap = true
    ..maskColor = darkColor.withOpacity(.3);
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const Splash(),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: TransitionRouteBuilder.fade,
        ),
        routes: [
          GoRoute(
            path: 'splash',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const Splash(),
              transitionDuration: const Duration(milliseconds: 200),
              transitionsBuilder: TransitionRouteBuilder.fade,
            ),
            routes: [
              GoRoute(
                path: 'auth',
                pageBuilder: (context, state) => CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const SplashAuth(),
                  transitionDuration: const Duration(milliseconds: 200),
                  transitionsBuilder: TransitionRouteBuilder.fade,
                ),
              ),
            ],
          ),
          GoRoute(
            path: 'login',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const Login(),
              transitionDuration: const Duration(milliseconds: 200),
              transitionsBuilder: TransitionRouteBuilder.fade,
            ),
          ),
          GoRoute(
            path: 'home',
            onExit: (context, state) {
              return false;
            },
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const Home(initialPage: 0),
              transitionDuration: const Duration(milliseconds: 200),
              transitionsBuilder: TransitionRouteBuilder.fade,
            ),
            routes: [
              GoRoute(
                path: ':tab',
                pageBuilder: (context, state) => CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: Home(initialPage: state.pathParameters['tab'] as int),
                  transitionDuration: const Duration(milliseconds: 200),
                  transitionsBuilder: TransitionRouteBuilder.fade,
                ),
              ),
              GoRoute(
                path: 'monitor',
                pageBuilder: (context, state) => CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const Home(initialPage: 0),
                  transitionDuration: const Duration(milliseconds: 200),
                  transitionsBuilder: TransitionRouteBuilder.fade,
                ),
                routes: [
                  GoRoute(
                    path: 'transaction',
                    pageBuilder: (context, state) =>
                          CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const TransactionAdd(),
                            transitionDuration:
                                const Duration(milliseconds: 200),
                            transitionsBuilder: TransitionRouteBuilder.verticalBottom,
                          ),
                      routes: [
                      GoRoute(
                        path: 'history',
                        pageBuilder: (context, state) =>
                            CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: const TransactionHistory(),
                          transitionDuration: const Duration(milliseconds: 200),
                          transitionsBuilder: TransitionRouteBuilder.verticalBottom,
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'self-discovery',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: SelfDiscovery(onDismiss: state.extra as VoidCallback,),
                      transitionDuration: const Duration(milliseconds: 200),
                      transitionsBuilder: TransitionRouteBuilder.verticalBottom,
                    ),
                    routes: [
                      GoRoute(
                        path: 'finish',
                        pageBuilder: (context, state) =>
                            CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: SelfDiscoveryFinish(onPop: state.extra as VoidCallback,),
                          transitionDuration: const Duration(milliseconds: 200),
                          transitionsBuilder: TransitionRouteBuilder.fade,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              GoRoute(
                path: 'chat',
                pageBuilder: (context, state) => CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const Home(initialPage: 1),
                  transitionDuration: const Duration(milliseconds: 200),
                  transitionsBuilder: TransitionRouteBuilder.fade,
                ),
                routes: [
                  GoRoute(
                    path: 'chatbot',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const ChatBot(),
                      transitionDuration: const Duration(milliseconds: 200),
                      transitionsBuilder: TransitionRouteBuilder.fade,
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: 'hotline',
                pageBuilder: (context, state) => CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const Home(initialPage: 2),
                  transitionDuration: const Duration(milliseconds: 200),
                  transitionsBuilder: TransitionRouteBuilder.fade,
                ),
              ),
              GoRoute(
                path: 'profile',
                pageBuilder: (context, state) => CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const Home(initialPage: 3),
                  transitionDuration: const Duration(milliseconds: 200),
                  transitionsBuilder: TransitionRouteBuilder.fade,
                ),
                routes: [
                  GoRoute(
                    path: 'edit',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: ProfileEdit(
                        refresh: state.extra as VoidCallback,
                      ),
                      transitionDuration: const Duration(milliseconds: 200),
                      transitionsBuilder: TransitionRouteBuilder.fade,
                    ),
                  ),
                  GoRoute(
                    path: 'pdf',
                    pageBuilder: (context, state) {
                      final args = state.extra as Map<String, String>;
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: ProfilePdf(
                          title: args['title']!,
                          path: args['path']!,
                        ),
                        transitionDuration: const Duration(milliseconds: 200),
                        transitionsBuilder: TransitionRouteBuilder.fade,
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: 'notification',
                pageBuilder: (context, state) => CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const HomeNotification(),
                  transitionDuration: const Duration(milliseconds: 200),
                  transitionsBuilder: TransitionRouteBuilder.verticalTop,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
  }

  final Map<int, Color> colorSwatch = {
    50: const Color.fromRGBO(0, 0, 0, .1),
    100: const Color.fromRGBO(0, 0, 0, .2),
    200: const Color.fromRGBO(0, 0, 0, .3),
    300: const Color.fromRGBO(0, 0, 0, .4),
    400: const Color.fromRGBO(0, 0, 0, .5),
    500: const Color.fromRGBO(0, 0, 0, .6),
    600: const Color.fromRGBO(0, 0, 0, .7),
    700: const Color.fromRGBO(0, 0, 0, .8),
    800: const Color.fromRGBO(0, 0, 0, .9),
    900: const Color.fromRGBO(0, 0, 0, 1),
  };

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          title: 'WalletWatch',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFF000000),
            primaryColor: primaryColor,
            primarySwatch: MaterialColor(primaryColor.value, colorSwatch),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.black,
              selectionHandleColor: primaryColor,
              selectionColor: const Color.fromARGB(255, 233, 232, 232),
            ),
          ),
          // home: const Splash(),
          routerDelegate: _router.routerDelegate,
          routeInformationParser: _router.routeInformationParser,
          routeInformationProvider: _router.routeInformationProvider,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
