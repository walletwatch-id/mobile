import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/enum/home_state.dart';
import 'package:wallet_watch/common/enum/hotline_state.dart';
import 'package:wallet_watch/common/enum/item_state.dart';
import 'package:wallet_watch/common/enum/notification_state.dart';
import 'package:wallet_watch/common/helper.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';
import 'package:wallet_watch/common/widgets/home_navigator.dart';
import 'package:wallet_watch/common/widgets/hotline_card.dart';
import 'package:wallet_watch/common/widgets/notification_item.dart';
import 'package:wallet_watch/common/widgets/top_bar.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:wallet_watch/views/home/home.dart';

class HomeNotification extends StatefulWidget {
  const HomeNotification({super.key});

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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 28.h),
        child: Stack(
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
                  }),
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
