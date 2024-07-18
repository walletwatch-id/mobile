import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/utils/transtition_fade.dart';
import 'package:walletwatch_mobile/common/widgets/back_clipper.dart';
import 'package:walletwatch_mobile/views/auth/login.dart';
import 'package:walletwatch_mobile/views/auth2/register.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _LoginState();
}

class _LoginState extends State<Intro> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: backColor,
          // gradient: const LinearGradient(
          //         colors: [
          //           Color(0xFF0F2C48),
          //           Color(0xFF122447),
          //           Color(0xFF040E31),
          //           Color(0xFF071336)
          //         ],
          //         stops: [0.0, 0.25, 0.75, 1.0],
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //       ),
        ),
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 42.h,
              ),
              Center(
                child: Text(
                  'Selamat Menggunakan',
                  style: AppFontStyle.authTitleText.copyWith(color: darkColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Center(
                  child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Wallet",
                      style: AppFontStyle.authTitleText
                          .copyWith(color: primaryColor, fontSize: 52.sp)),
                  TextSpan(
                      text: "Watch",
                      style: AppFontStyle.authTitleText
                          .copyWith(color: secondaryColor, fontSize: 52.sp))
                ]),
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: 46.h,
              ),
              Center(
                child: Text(
                  'Sudah punya akun?',
                  style:
                      AppFontStyle.authSubTitleText.copyWith(color: darkColor),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(TransitionFade(child: const Login()));
                    },
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                    ),
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text(
                          "Login/Masuk",
                          style: AppFontStyle.authLabelText
                              .copyWith(color: darkColor, fontSize: 20.sp),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: Text(
                  'Belum punya akun?',
                  style:
                      AppFontStyle.authSubTitleText.copyWith(color: darkColor),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(TransitionFade(child: const Register()));
                    },
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                    ),
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text(
                          "Sign Up/Daftar",
                          style: AppFontStyle.authLabelText
                              .copyWith(color: darkColor, fontSize: 20.sp),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
              Stack(
                children: [
                  ClipPath(
                      clipper: BackClipper(),
                      child: Container(
                          color: const Color(0xFF80D6DA),
                          height: 200.h,
                          child: Container(
                            width: double.infinity,
                            color: secondaryColor,
                          ))),
                  Positioned(
                    top: 40.h,
                    bottom: 40.h,
                    right: 40.w,
                    left: 40.w,
                    child: Center(
                        child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: '"Mari Gunakan ',
                            style: AppFontStyle.authTitleText
                                .copyWith(color: lightColor, fontSize: 24.sp)),
                        TextSpan(
                            text: "Paylater\n",
                            style: AppFontStyle.authTitleText.copyWith(
                                color: primaryColor, fontSize: 24.sp)),
                        TextSpan(
                            text: 'dengan ',
                            style: AppFontStyle.authTitleText
                                .copyWith(color: lightColor, fontSize: 24.sp)),
                        TextSpan(
                            text: "Bijak",
                            style: AppFontStyle.authTitleText.copyWith(
                                color: primaryColor, fontSize: 24.sp)),
                        TextSpan(
                            text: '"',
                            style: AppFontStyle.authTitleText
                                .copyWith(color: lightColor, fontSize: 24.sp)),
                      ]),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ],
              ),
              SizedBox(
                height: 50.h,
              )
            ],
          ),
        ]),
      ),
    );
  }
}
