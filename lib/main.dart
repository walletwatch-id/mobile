import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/views/splash/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp(
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
    ..maskColor = darkColor.withOpacity(.3);
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
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
        return MaterialApp(
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
          home: const Splash(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
