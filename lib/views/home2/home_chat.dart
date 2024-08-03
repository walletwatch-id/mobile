import 'dart:async';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/data/chat_message.dart';
import 'package:walletwatch_mobile/common/data/chat_session.dart';
import 'package:walletwatch_mobile/common/data/feedback_item.dart';
import 'package:walletwatch_mobile/common/enum/home_state.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:walletwatch_mobile/common/http/chat.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/utils/transtition_fade.dart';
import 'package:walletwatch_mobile/common/widgets/feedback_item.dart';
import 'package:walletwatch_mobile/common/widgets/home_navigator.dart';
import 'package:walletwatch_mobile/common/widgets/input_alert.dart';
import 'package:walletwatch_mobile/common/widgets/top_bar.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:walletwatch_mobile/views/chat/chatbot.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeChat extends StatefulWidget {
  const HomeChat({super.key});

  @override
  State<HomeChat> createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  final _advancedDrawerController = AdvancedDrawerController();
  bool isSettingVisible = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, statusBarColor: lightColor));

    loadPage();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadPage() async {
    EasyLoading.show(status: 'Loading...');

    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return HomeNavigator(
      controller: _advancedDrawerController,
      state: HomeState.chat,
      child: Scaffold(
        backgroundColor: lightColor,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: TopBar(
                  controller: _advancedDrawerController,
                  title: "ChatBot",
                  textColor: darkColor,
                  isLight: true,
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child:  Container(
                      height: 60.h,
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: darkColor,
                                  width: 2.w,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: SizedBox(
                                    width: 56.h,
                                    height: 56.h,
                                    child: user.image),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 16.w, top: 6.h),
                              height: 60.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ChatBot",
                                    style: AppFontStyle.accountNameText,
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                    "Personal Assistant Kamu",
                                    style: AppFontStyle.homeListHeaderText
                                        .copyWith(
                                            color: subColor, fontSize: 13.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),),),
            Positioned(
              top: 124.h,
              right: 0,
              left: 0,
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'User Feedback',
                              style: AppFontStyle.monitorSubHeaderText.copyWith(
                                color: darkColor,
                                height: 1.4,
                                fontSize: 20.sp,
                              ),
                            ),
                            Text(
                              "Apa yang mereka katakan tentang ChatBot",
                              style: AppFontStyle.homeListHeaderText
                                  .copyWith(color: subColor, fontSize: 13.sp),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      height: 200.h,
                      child: ListView.builder(
                        itemCount: feedbackItems.length,
                        itemBuilder: (context, index) {
                          return FeedbackCard(feedbackItems[index]);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Divider(
                      color: borderColor,
                      height: 1.5.h,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Berita Terknini',
                            style: AppFontStyle.monitorSubHeaderText
                                .copyWith(color: darkColor, fontSize: 20.sp)),
                        SizedBox(
                          height: 30.h,
                          width: 100.w,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.white),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              padding: WidgetStateProperty.all(EdgeInsets.zero),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    "Cari Tahu",
                                    style: AppFontStyle.homeNormalText.copyWith(
                                        color: darkColor, fontSize: 14.sp),
                                  ),
                                  Icon(
                                    Icons.arrow_right,
                                    color: darkColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1.w, color: borderColor)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.black.withOpacity(.05),
                              height: 180.h,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Positioned(
                                      bottom: 0,
                                      left: 0,
                                      top: 0,
                                      right: 0,
                                      child: Image.asset(
                                        'assets/images/news1.png',
                                        fit: BoxFit.cover,
                                      )),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(8.r),
                                        ),
                                      ),
                                      child: Text(
                                        'Berita Pemerintah',
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 30.w,
                                    top: 0,
                                    bottom: 0,
                                    child: SizedBox(
                                      width: 150.w,
                                      child: Center(
                                        child: Text(
                                          'Untuk pengontrolan lebih baik, mari kita mencari tahu tipe personalitas keuangan kamu!',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Financial:',
                                      style: AppFontStyle.homeNormalText
                                          .copyWith(color: primaryColor)),
                                  SizedBox(height: 6.h),
                                  Text(
                                    'OJK Batasi Penggunaan Paylater hingga 3 Platform Saja',
                                    style: AppFontStyle.homeSubHeaderText
                                        .copyWith(
                                            color: darkColor,
                                            fontSize: 17.sp,
                                            height: 1.4),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Container(
                      height: 45.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.r),
                        ),
                        border: Border.all(
                          color: borderColor,
                          width: 1.5.w,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(TransitionFade(child: const ChatBot()));
                          },
                          child: Text(
                            "Mulai Obrolan/Konsultasi",
                            style: AppFontStyle.homeSubTitleText
                                .copyWith(color: lightColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
