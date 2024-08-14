import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/utils/transtition_fade.dart';
import 'package:walletwatch_mobile/views/splash/splash_auth.dart';
import 'package:permission_handler/permission_handler.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();

    checkPermission();

    // Future.delayed(const Duration(seconds: 2), () {
    //   Navigator.of(context)
    //       .pushReplacement(TransitionFade(child: const SplashAuth()));
    // });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  Future<void> permissionIsGranted() async {
    final startTime = DateTime.now();
    final endTime = DateTime.now();
    final elapsedTime = endTime.difference(startTime);

    const minimumDelay = Duration(seconds: 2);
    final remainingDelay =
        elapsedTime.isNegative ? minimumDelay : (minimumDelay - elapsedTime);

    if (remainingDelay.inMilliseconds > 0) {
      await Future.delayed(remainingDelay);
    }

    // ignore: use_build_context_synchronously
    context.go('/splash/auth');
  }

  Future<void> checkPermission() async {
    var backgroundStatus = await Permission.ignoreBatteryOptimizations.status;
    var notificationStatus = await Permission.notification.status;
    bool status = false;

    if (notificationStatus.isGranted && backgroundStatus.isGranted) {
      status = true;
    }

    requestPermission(status);
  }

  Future<void> requestPermission(bool status) async {
    var backgroundStatus =
        await Permission.ignoreBatteryOptimizations.request();
    var notificationStatus = await Permission.notification.request();
    // var scheduleStatus = await Permission.scheduleExactAlarm.request();
    // var notificationPolicyStatus =
    //     await Permission.accessNotificationPolicy.request();

    if (backgroundStatus.isGranted && notificationStatus.isGranted
        // && (scheduleStatus.isGranted || notificationPolicyStatus.isGranted)
        ) {
      // if (!status) {
      //   await restartApp();
      // }
      permissionIsGranted();
    } else {
      // permissionDeniedDialog();
      permissionIsGranted();
    }
  }

  // Future<void> restartApp() async {
  //   IsolateNameServer.removePortNameMapping('isolate');
  //   IsolateNameServer.registerPortWithName(ReceivePort().sendPort, 'isolate');
  //   Isolate.spawn(restart, null);
  // }

  // static void restart(_) {
  //   // Delay for a short time to allow the current isolate to exit
  //   Future.delayed(Duration.zero, () {
  //     // Retrieve the isolate port and send a message to restart the app
  //     final SendPort send = IsolateNameServer.lookupPortByName('isolate')!;
  //     send.send(null);
  //   });
  // }

  Future<void> permissionDeniedDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Permission is Required'),
          content: const Text('Please grant permission to use this app next time.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        );
      },
    );

    permissionIsGranted();
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
              width: MediaQuery.of(context).size.width * 0.4,
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
