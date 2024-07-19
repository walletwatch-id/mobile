import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/data/hotline.dart';
import 'package:walletwatch_mobile/common/enum/home_state.dart';
import 'package:walletwatch_mobile/common/enum/hotline_state.dart';
import 'package:walletwatch_mobile/common/enum/item_state.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:walletwatch_mobile/common/http/hotline.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/widgets/home_navigator.dart';
import 'package:walletwatch_mobile/common/widgets/hotline_card.dart';
import 'package:walletwatch_mobile/common/widgets/top_bar.dart';
import 'package:http/http.dart' as http;
import 'package:toggle_list/toggle_list.dart';

class HomeHotline extends StatefulWidget {
  final ScrollController controller;
  const HomeHotline({super.key, required this.controller});

  @override
  State<HomeHotline> createState() => _HomeHotlineState();
}

class _HomeHotlineState extends State<HomeHotline> {
  final _advancedDrawerController = AdvancedDrawerController();
  final List<Hotline> _hotlines = [];
  bool isSettingVisible = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light, statusBarColor: darkColor));

    loadPage();
    super.initState();
  }

  void loadPage() async {
    EasyLoading.show(status: 'Loading...');
    final hotlines = await fetchHotlines();
    setState(() {
      _hotlines.addAll(hotlines);
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return HomeNavigator(
        controller: _advancedDrawerController,
        state: HomeState.monitor,
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: TopBar(
                    controller: _advancedDrawerController,
                    title: "Hotline",
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
                          child: Text('Informasi Hotline Terkait Paylater!',
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
                    margin: EdgeInsets.all(16.h),
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 0.h,
                          right: 0,
                          bottom: 70.h,
                          left: 0,
                          child: SizedBox(
                              height: double.infinity,
                              child: Column(
                                children: [
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        //  login(context, _usernameController.text, _passwordController.text);
                                        // Navigator.pushReplacement(context,
                                        //     MaterialPageRoute(builder: (context) {
                                        //   return const Home();
                                        // }));
                                      },
                                      style: ButtonStyle(
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                        ),
                                        padding: WidgetStateProperty.all(
                                            EdgeInsets.zero),
                                      ),
                                      child: Container(
                                        height: 48.h,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Ayo sampaikan keluhanmu sekarang!",
                                            style: AppFontStyle
                                                .homeCardTitleText
                                                .copyWith(
                                                    color: lightColor,
                                                    fontSize: 18.sp),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // const HotlineCard(
                                  //     state: HotlineState.paylater,
                                  //     title: "Hotline Paylater Kamu",
                                  //     hotlines: [
                                  //       {ItemState.shopee: "1500739"},
                                  //       {ItemState.kredivo: "1500590"},
                                  //       {ItemState.akulaku: "1500920"},
                                  //     ]),

                                  Expanded(
                                    child: HotlineCard(
                                        state: HotlineState.paylater,
                                        title: "Hotline Paylater Kamu",
                                        hotlines: _hotlines),
                                  ),

                                  Expanded(
                                    child: HotlineCard(
                                        state: HotlineState.government,
                                        title: "Hotline Pemerintah",
                                        hotlines: [
                                          Hotline(
                                            "OJK",
                                            id: "1",
                                            phoneNumber: "157",
                                          ),
                                          Hotline(
                                            "Kominfo",
                                            id: "2",
                                            phoneNumber: "150",
                                          ),
                                        ]),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
