import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';
import 'package:wallet_watch/common/utils/transtition_fade.dart';
import 'package:wallet_watch/views/auth/intro.dart';
import 'package:wallet_watch/views/splash/splash_auth.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context)
          .pushReplacement(TransitionFade(child: const SplashAuth()));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: lightColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              // child:               Center(
              //     child: RichText(
              //   text: TextSpan(children: [
              //     TextSpan(
              //         text: "Wallet",
              //         style: AppFontStyle.authTitleText
              //             .copyWith(color: primaryColor, fontSize: 52.sp)),
              //     TextSpan(
              //         text: "Watch",
              //         style: AppFontStyle.authTitleText
              //             .copyWith(color: secondaryColor, fontSize: 52.sp))
              //   ]),
              //   textAlign: TextAlign.center,
              // )),
              child: Image.asset(
                'assets/images/splash.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 50.h,
            )
          ],
        ),
      ),
    );
  }
}
