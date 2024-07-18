import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:walletwatch_mobile/main.dart';

@pragma('vm:entry-point')
class NotificationController {
  static ReceivedAction? initialAction;
  static ReceivePort? receivePort;
  // ignore: constant_identifier_names
  static const CHANNEL_KEY = "walletwatch_mobile_controller";

  @pragma('vm:entry-point')
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
          channelKey: CHANNEL_KEY,
          channelName: 'Wallet Watch Controller',
          channelDescription: 'Notification',
          playSound: false,
          onlyAlertOnce: true,
          channelShowBadge: false,
          groupAlertBehavior: GroupAlertBehavior.Children,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
          defaultColor: const Color(0xFF2c3e50),
          ledColor: const Color(0xFF2c3e50),
          locked: true),
    ]);

    initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  @pragma('vm:entry-point')
  static Future<void> stopLocalNotifications() async {
    await AwesomeNotifications().cancelAll();
    initialAction = null;
  }

  @pragma('vm:entry-point')
  static Future<void> _onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // final service = FlutterBackgroundService();
    // BackgroundService.isSyncOn =
    //     receivedAction.buttonKeyPressed == "SYNC START";
    // service.invoke("updateService", {'isSyncOn': BackgroundService.isSyncOn});
    // BackgroundService.dataStreamController.add(BackgroundService.isSyncOn);
    // if (NotificationController.receivePort == null) {
    //   print(
    //       'onActionReceivedMethod was called inside a parallel dart isolate.');
    //   SendPort? sendPort =
    //       IsolateNameServer.lookupPortByName('notification_action_port');

    //   if (sendPort != null) {
    //     print('Redirecting the execution to main isolate process.');
    //     sendPort.send(receivedAction);
    //     return;
    //   }
    // }

    // return onActionReceivedImplementationMethod(receivedAction);
  }

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedImplementationMethod(
      ReceivedAction receivedAction) async {
    MainApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/notification-page',
        (route) =>
            (route.settings.name != '/notification-page') || route.isFirst,
        arguments: receivedAction);
  }

  @pragma('vm:entry-point')
  static Future<void> initializeIsolateReceivePort() async {
    await AwesomeNotifications()
        .setListeners(onActionReceivedMethod: _onActionReceivedMethod);
    receivePort = ReceivePort('Notification action port in main isolate')
      ..listen(
          (silentData) => onActionReceivedImplementationMethod(silentData));

    IsolateNameServer.registerPortWithName(
        receivePort!.sendPort, 'notification_action_port');
  }

  @pragma('vm:entry-point')
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: _onActionReceivedMethod);
  }

  @pragma('vm:entry-point')
  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = MainApp.navigatorKey.currentContext!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Get Notified!',
                style: Theme.of(context).textTheme.titleLarge),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/animated-bell.gif',
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                    'Allow Awesome Notifications to send you beautiful notifications!'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Deny',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    userAuthorized = true;
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Allow',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.deepPurple),
                  )),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  @pragma('vm:entry-point')
  static Future<void> createNewNotification(int id, bool isSyncOn) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            locked: true,
            autoDismissible: false,
            channelKey: CHANNEL_KEY,
            title: 'Notification',
            body: "Your Status : ${isSyncOn ? "On" : "Off"}",
            notificationLayout: NotificationLayout.BigPicture,
            category: NotificationCategory.Navigation,
            //     icon: 'assets/images/logo-orange.png',
            backgroundColor: const Color(0xFF2c3e50),
            badge: 0,
            color: Colors.yellow,
            payload: {'notificationId': '$id'}),
        actionButtons: [
          NotificationActionButton(
              key: isSyncOn ? 'SYNC STOP' : 'SYNC START',
              label: isSyncOn ? 'Stop Sync' : 'Start Sync',
              isAuthenticationRequired: true,
              autoDismissible: false)
        ]);
  }
}
