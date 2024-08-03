import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:walletwatch_mobile/common/http/auth.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/utils/transtition_fade.dart';
import 'package:walletwatch_mobile/views/auth/login.dart';
import 'package:walletwatch_mobile/views/home2/home.dart';

class SplashAuth extends StatefulWidget {
  const SplashAuth({super.key});

  @override
  State<SplashAuth> createState() => _SplashAuthState();
}

class _SplashAuthState extends State<SplashAuth>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      final fUser = await fetchUser();

      if (fUser == null) {
        // ignore: use_build_context_synchronously
        await Navigator.of(context)
            .pushReplacement(TransitionFade(child: const Login()));
        return;
      }

      setState(() {
        user = fUser;
      });

      // ignore: use_build_context_synchronously
      await Navigator.of(context)
          .pushReplacement(TransitionFade(child: const Home()));
    });
  }

  // Future<void> _afterGoogleLogin(GoogleSignInAccount gSA) async {
  //   googleSignInAccount = gSA;
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount!.authentication;

  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );

  //   final UserCredential authResult =
  //       await firebaseAuth.signInWithCredential(credential);
  //   final User? user = authResult.user;

  //   assert(user!.isAnonymous);
  //   assert(await user!.getIdToken() != null);

  //   final User? currentUser = firebaseAuth.currentUser;
  //   assert(user!.uid == currentUser!.uid);

  //   storage.write(key: "signedIn", value: "true").then((value) {
  //     setState(() {
  //       signedIn = true;
  //     });
  //   });
  // }

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
        color: darkColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Image.asset(
                'assets/images/splash-auth.png',
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
