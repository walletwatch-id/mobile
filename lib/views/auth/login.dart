import 'package:flutter/material.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';
import 'package:wallet_watch/common/utils/transtition_fade.dart';
import 'package:wallet_watch/common/widgets/custom_text_field.dart';
import 'package:wallet_watch/views/auth/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              Text('Login',
                  style: AppFontStyle.authTitleText
                      .copyWith(color: darkColor)),
              const SizedBox(height: 20),
              Text('Email',
                  style: AppFontStyle.authLabelText
                      .copyWith(color: primaryColor)),
              CustomTextField(
                controller: _usernameController,
                hintText: "Email..",
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                color: secondaryColor,
                startIcon: Icon(Icons.person, color: secondaryColor,),
              ),
              const SizedBox(height: 24),
              Text('Password',
                  style: AppFontStyle.authLabelText
                      .copyWith(color: primaryColor)),
              CustomTextField(
                controller: _passwordController,
                hintText: "Password..",
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                                color: secondaryColor,
                startIcon: Icon(Icons.lock, color: secondaryColor,),
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
                          "Login",
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
                      style: AppFontStyle.authSmallText.copyWith(
                          color: darkColor)),
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
