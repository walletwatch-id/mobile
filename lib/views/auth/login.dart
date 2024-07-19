import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:walletwatch_mobile/common/http/auth.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/utils/transtition_fade.dart';
import 'package:walletwatch_mobile/views/home/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FlutterAppAuth appAuth = const FlutterAppAuth();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ));
    EasyLoading.init();

    super.initState();
  }

  Future<void> _authenticate(BuildContext context) async {
    try {
      EasyLoading.show(status: 'Loading...');

      final AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          '9c82578a-7bbb-4fb3-b5f1-e5bcae53c5c7',
          'https://www.walletwatch.id/auth/callback',
          serviceConfiguration: const AuthorizationServiceConfiguration(
            authorizationEndpoint: '${oauthUrl}authorize',
            tokenEndpoint: '${oauthUrl}token',
          ),
          promptValues: ['login'],
        ),
      );

      if (result != null) {
        await savePrefs(accessToken: result.accessToken);

        final fUser = await fetchUser();

        setState(() {
          user = fUser!;
        });

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          TransitionFade(child: const Home()),
        );
      }
    } catch (e) {
      // Handle any errors
      print('Error: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 110.h,
              ),
              Center(
                  child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Wallet",
                      style: AppFontStyle.authTitleText
                          .copyWith(color: primaryColor, fontSize: 38.sp)),
                  TextSpan(
                      text: "Watch",
                      style: AppFontStyle.authTitleText
                          .copyWith(color: secondaryColor, fontSize: 38.sp))
                ]),
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: 80.h,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 200.h,
                    padding: EdgeInsets.all(40.h),
                    decoration: BoxDecoration(
                      color: thirdColor,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Image.asset(
                      "assets/images/walletwatch.png",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Center(
                child: Text(
                  'Login',
                  style: AppFontStyle.authTitleText
                      .copyWith(color: darkColor, fontSize: 28.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Center(
                child: Text(
                  'Selamat datang kembali di WalletWatch!',
                  style: AppFontStyle.normalText
                      .copyWith(color: darkColor, fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 180.h),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () => _authenticate(context),
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                    ),
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Center(
                        child: Text(
                          "Masuk",
                          style: AppFontStyle.authLabelText
                              .copyWith(color: lightColor, fontSize: 20.sp),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 22.h,
              ),
              SizedBox(
                height: 50.h,
              )
            ],
          ),
          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.all(16),
          //   color: darkColor,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       SizedBox(
          //         width: MediaQuery.of(context).size.width * 0.4,
          //         child: Image.asset(
          //           'assets/images/splash-auth.png',
          //           fit: BoxFit.contain,
          //         ),
          //       ),
          //       SizedBox(
          //         height: 50.h,
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
