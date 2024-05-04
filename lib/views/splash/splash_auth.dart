import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/common/utils/transtition_fade.dart';
import 'package:wallet_watch/views/auth/intro.dart';
import 'package:wallet_watch/views/auth/login.dart';

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
    // googleSignIn.signInSilently();

    Future.delayed(const Duration(seconds: 3), () async {
              await Navigator.of(context)
            .pushReplacement(TransitionFade(child: const Intro()));
      // signedIn = await storage.read(key: "signedIn") == "true" ? true : false;
      // GoogleSignInAccount? account = googleSignIn.currentUser;
      // bool isAuthorized = account != null;

      // if (kIsWeb && account != null) {
      //   _afterGoogleLogin(googleSignInAccount!);
      //   isAuthorized = await googleSignIn.canAccessScopes(scopes);
      // }

      // if (signedIn) {
      //   try {
      //     googleSignIn.signInSilently().whenComplete(() => () {});
      //   } catch (e) {
      //     storage.write(key: "signedIn", value: "false").then((value) {
      //       setState(() {
      //         signedIn = false;
      //       });
      //     });
      //   }
      // } 
      
      // setState(() {
      //   googleSignInAccount = account;
      //   isAuthorized = isAuthorized;
      // });

      // if (isAuthorized) {
      //   loadPrefs();
      // //  unawaited(handleGetContact(account!));
      //   // ignore: use_build_context_synchronously
      //   await Navigator.of(context)
      //       .pushReplacement(TransitionFade(child: const Home()));
      // } else {
      //   // ignore: use_build_context_synchronously
      //   await Navigator.of(context)
      //       .pushReplacement(TransitionFade(child: const Login()));
      // }
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
              width: MediaQuery.of(context).size.width * 0.7,
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
