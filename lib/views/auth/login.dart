import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';
import 'package:wallet_watch/common/utils/transtition_fade.dart';
import 'package:wallet_watch/common/widgets/custom_text_field.dart';
import 'package:wallet_watch/views/auth/register.dart';
import 'package:wallet_watch/views/home/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isChecked = false;

  @override
  void initState() {
    EasyLoading.init();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backColor,
        ),
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18.h,
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
                height: 20.h,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 130.h,
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
                height: 22.h,
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
              SizedBox(height: 60.h),
              Text('Email',
                  style:
                      AppFontStyle.authLabelText.copyWith(color: primaryColor)),
              CustomTextField(
                controller: _emailController,
                hintText: "Email..",
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                color: secondaryColor,
                startIcon: Icon(
                  Icons.email,
                  color: secondaryColor,
                ),
              ),
              SizedBox(height: 24.h),
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
              SizedBox(height: 14.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      title: Text('Ingat saya',
                          style: AppFontStyle.authSubLabelText
                              .copyWith(color: subColor)),
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                    ),
                  ),
                  Text('Lupa password?',
                      style: AppFontStyle.authSubLabelText.copyWith(
                          color: primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: primaryColor)),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () async {
                      //  login(context, _emailController.text, _passwordController.text);
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return const Home();
                      // }));
                      EasyLoading.show(status: 'Loading...');
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const Home();
                        }));
                      });
                      EasyLoading.dismiss();
                    },
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Belum memiliki akun?',
                      style: AppFontStyle.normalText
                          .copyWith(color: subColor, fontSize: 15.sp)),
                  SizedBox(
                    width: 4.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      EasyLoading.show(status: 'Loading...');
                      Navigator.of(context).pushReplacement(
                          TransitionFade(child: const Register()));
                      EasyLoading.dismiss();
                    },
                    child: Text('Buat Akun',
                        style: AppFontStyle.authSubLabelText.copyWith(
                            color: primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor)),
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
