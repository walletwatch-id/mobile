import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';
import 'package:wallet_watch/common/utils/transtition_fade.dart';
import 'package:wallet_watch/common/widgets/custom_text_field.dart';
import 'package:wallet_watch/views/auth/login.dart';
import 'package:wallet_watch/views/auth/register.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _LoginState();
}

class _LoginState extends State<Intro> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                height: 12.h,
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
                  style: AppFontStyle.authSmallText.copyWith(color: darkColor),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          TransitionFade(child: const Login()));
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
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
                  style: AppFontStyle.authSmallText.copyWith(color: darkColor),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          TransitionFade(child: const Register()));
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
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
              const SizedBox(
                height: 12,
              ),
              const SizedBox(height: 20),
              Text('Email',
                  style:
                      AppFontStyle.authLabelText.copyWith(color: primaryColor)),
              CustomTextField(
                controller: _usernameController,
                hintText: "Email..",
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                color: secondaryColor,
                startIcon: Icon(
                  Icons.person,
                  color: secondaryColor,
                ),
              ),
              const SizedBox(height: 24),
              Text('Password',
                  style:
                      AppFontStyle.authLabelText.copyWith(color: primaryColor)),
              CustomTextField(
                controller: _passwordController,
                hintText: "Password..",
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                color: secondaryColor,
                startIcon: Icon(
                  Icons.lock,
                  color: secondaryColor,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      //  login(context, _usernameController.text, _passwordController.text);
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return const Home();
                      // }));
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                    ),
                    child: Container(
                      height: 42.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3CEAC1), Color(0xFF00C0DA)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text(
                          "Intro",
                          style: AppFontStyle.authLabelText
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum punya akun?",
                      style: AppFontStyle.authSmallText
                          .copyWith(color: darkColor)),
                  const SizedBox(
                    width: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        TransitionFade(child: const Register()),
                      );
                    },
                    child:
                        Text("Sign up", style: AppFontStyle.authSmallBoldText),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ]),
      ),
    );
  }
}
