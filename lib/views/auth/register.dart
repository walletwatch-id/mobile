import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';
import 'package:wallet_watch/common/utils/transtition_fade.dart';
import 'package:wallet_watch/common/widgets/custom_text_field.dart';
import 'package:wallet_watch/views/auth/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfController = TextEditingController();
  bool isDateSelectorVisible = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                      'Register',
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
                      'Selamat bergabung di WalletWatch!',
                      style: AppFontStyle.normalText
                          .copyWith(color: darkColor, fontSize: 14.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text('Nama',
                      style: AppFontStyle.authLabelText
                          .copyWith(color: primaryColor)),
                  CustomTextField(
                    controller: _nameController,
                    hintText: "Nama..",
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    color: secondaryColor,
                    startIcon: Icon(
                      Icons.person,
                      color: secondaryColor,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text('Email',
                      style: AppFontStyle.authLabelText
                          .copyWith(color: primaryColor)),
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
                  SizedBox(height: 16.h),
                  Text('Password',
                      style: AppFontStyle.authLabelText
                          .copyWith(color: primaryColor)),
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
                  SizedBox(height: 16.h),
                  Text('Konfirmasi Password',
                      style: AppFontStyle.authLabelText
                          .copyWith(color: primaryColor)),
                  CustomTextField(
                    controller: _passwordConfController,
                    hintText: "Konfirmasi Password..",
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    color: secondaryColor,
                    startIcon: Icon(
                      Icons.lock_person,
                      color: secondaryColor,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  // SingleChildScrollView(
                  //   child: SizedBox(
                  //     width: double.infinity,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [

                  //         Flexible(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               GestureDetector(
                  //                 onTap: () {
                  //                   setState(() {
                  //                     isDateSelectorVisible = true;
                  //                   });
                  //                 },
                  //                 child: Text(
                  //                   'Tanggal Lahir',
                  //                   style: AppFontStyle.authLabelText
                  //                       .copyWith(color: darkColor),
                  //                 ),
                  //               ),
                  //               CustomTextField(
                  //                 controller: _tanggalLahirController,
                  //                 hintText: "Tanggal..",
                  //                 readOnly: true,
                  //                 obscureText: false,
                  //                 keyboardType: TextInputType.datetime,
                  //                 onFocusChange: (isFocused) {
                  //                   if (isFocused) {
                  //                     setState(() {
                  //                       isDateSelectorVisible = true;
                  //                     });
                  //                   }
                  //                 },
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ElevatedButton(
                        onPressed: () async {
                          //  login(context, _usernameController.text, _passwordController.text);
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return const Home();
                          // }));
                          EasyLoading.show(status: 'Loading...');
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const Login();
                            }));
                          });
                          EasyLoading.dismiss();
                        },
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
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
                              "Buat Akun",
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
                      Text('Sudah memiliki akun?',
                          style: AppFontStyle.normalText
                              .copyWith(color: subColor, fontSize: 15.sp)),
                      SizedBox(
                        width: 4.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          EasyLoading.show(status: 'Loading...');
                          Navigator.of(context).pushReplacement(
                              TransitionFade(child: const Login()));
                          EasyLoading.dismiss();
                        },
                        child: Text('Masuk',
                            style: AppFontStyle.authSubLabelText.copyWith(
                                color: primaryColor,
                                decoration: TextDecoration.underline,
                                decorationColor: primaryColor)),
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
          // DateSelector(
          //   visible: isDateSelectorVisible,
          //   onDismiss: (args) {
          //     setState(() {
          //       isDateSelectorVisible = false;
          //       _tanggalLahirController.text = args;
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}
