import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/enum/home_state.dart';
import 'package:walletwatch_mobile/common/enum/notification_state.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/widgets/notification_item.dart';
import 'package:walletwatch_mobile/common/widgets/top_bar.dart';

class HomeNotification extends StatefulWidget {
  final bool isLight;
  final VoidCallback? popAction;
  const HomeNotification({super.key, this.isLight = true, this.popAction});

  @override
  State<HomeNotification> createState() => _HomeNotificationState();
}

class _HomeNotificationState extends State<HomeNotification> {
  bool isSettingVisible = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light, statusBarColor: darkColor));
    super.initState();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: TopBar(
                title: "Notifikasi",
                state: HomeState.notification,
                settingAction: () {
                  // setState(() {
                  //   isSettingAlertVisible = true;
                  // });
                },
                popAction: () {
                  if (widget.popAction != null) {
                    widget.popAction!();
                  }
                  if (widget.isLight) {
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                        statusBarIconBrightness: Brightness.dark,
                        statusBarColor: lightColor));
                  }
                },
              ),
            ),
            Positioned(
              top: 55.h,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: darkColor,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Text('Mengecek Notifikasi Anda!',
                            style: AppFontStyle.homeSubTitleText
                                .copyWith(color: lightColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 83.h),
              decoration: BoxDecoration(
                color: backColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Container(
                  margin: EdgeInsets.all(24.h),
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 0.h,
                        right: 0,
                        bottom: 70.h,
                        left: 0,
                        child: const SizedBox(
                            height: double.infinity,
                            child: Column(
                              children: [
                                NotificationItem(
                                    state: NotificationState.transaction,
                                    content:
                                        "Kamu baru saja menambahkan transaksi paylater baru"),
                                NotificationItem(
                                    state: NotificationState.transaction,
                                    content:
                                        "Data pendapatan kamu sudah di-update"),
                                NotificationItem(
                                    state: NotificationState.personal,
                                    content:
                                        "Password kamu telah diperbaharui"),
                                NotificationItem(
                                    state: NotificationState.personal,
                                    content:
                                        "Nomor HP kamu telah diperbaharui"),
                                NotificationItem(
                                    state: NotificationState.warning,
                                    content:
                                        "Kamu akan mencapai batas wajar pinjaman"),
                                NotificationItem(
                                    state: NotificationState.danger,
                                    content:
                                        "Kamu telah mencapai batas wajar pinjaman"),
                                NotificationItem(
                                    state: NotificationState.safe,
                                    content:
                                        "Selamat! Kamu berhasil menurunkan target risiko bulan ini!"),
                              ],
                            )),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
