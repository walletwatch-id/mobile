import 'package:flutter/material.dart';
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
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Sign Up',
                      style: AppFontStyle.authTitleText
                          .copyWith(color: darkColor)),
                  SizedBox(height: 22.h),
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
                  SizedBox(height: 16.h),
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
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ElevatedButton(
                        onPressed: () {
                          // register(
                          //     context,
                          //     _usernameController.text,
                          //     _passwordController.text,
                          //     _passwordConfController.text,
                          //     _namaLengkapController.text,
                          //     _tanggalLahirController.text);
                        },
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                        ),
                        child: Container(
                          height: 42.0,
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
