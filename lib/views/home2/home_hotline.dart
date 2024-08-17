import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/data/hotline.dart';
import 'package:walletwatch_mobile/common/enum/home_state.dart';
import 'package:walletwatch_mobile/common/enum/hotline_state.dart';
import 'package:walletwatch_mobile/common/http/hotline.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/widgets/faq_item.dart';
import 'package:walletwatch_mobile/common/widgets/home_navigator.dart';
import 'package:walletwatch_mobile/common/widgets/hotline_card.dart';
import 'package:walletwatch_mobile/common/widgets/top_bar.dart';

class HomeHotline extends StatefulWidget {
  const HomeHotline({super.key});

  @override
  State<HomeHotline> createState() => _HomeHotlineState();
}

class _HomeHotlineState extends State<HomeHotline> {
  final List<Hotline> _hotlines = [];
  bool isSettingVisible = false;

  @override
  void initState() {
    super.initState();

    loadPage();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
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
      state: HomeState.hotline,
      child: Scaffold(
        backgroundColor: lightColor,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 150.h,
                color: const Color(0xFFe8f6ee),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: TopBar(
                  title: "Hotline",
                  textColor: darkColor,
                  popAction: () {
                    SystemChrome.setSystemUIOverlayStyle(
                        const SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.dark,
                      statusBarColor: Color(0xFFe8f6ee),
                    ));
                  },
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
                child: Column(
                  children: [
                    Container(
                      height: 60.h,
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child: Text(
                                'Kamu butuh bantuan? Tenang dulu, kamu\nbisa menghubungi Hotline di bawah ini',
                                style: AppFontStyle.homeSubTitleText.copyWith(
                                  color: darkColor,
                                  fontSize: 14.sp,
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 0.h,
                              right: 0,
                              bottom: 16.h,
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
                                            color: lightColor,
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Ayo sampaikan keluhanmu sekarang!",
                                              style: AppFontStyle
                                                  .homeCardTitleText
                                                  .copyWith(
                                                      color: primaryColor,
                                                      fontSize: 14.sp),
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
                                      flex: 4,
                                      child: HotlineCard(
                                          state: HotlineState.paylater,
                                          title: "Hotline Paylater Kamu",
                                          hotlines: _hotlines),
                                    ),

                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        children: [
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
                                              ],
                                            ),
                                          ),
                                          // Expanded(
                                          //     child: Padding(
                                          //   padding: EdgeInsets.symmetric(
                                          //       horizontal: 10.w),
                                          //   child: Column(
                                          //     crossAxisAlignment:
                                          //         CrossAxisAlignment.start,
                                          //     children: [
                                          //       Text(
                                          //         "FAQs",
                                          //         style: AppFontStyle
                                          //             .homeCardTitleText
                                          //             .copyWith(
                                          //                 color: darkColor,
                                          //                 fontSize: 22.sp),
                                          //       ),
                                          //       SizedBox(
                                          //         height: 12.h,
                                          //       ),
                                          //       Expanded(
                                          //         child: ListView(
                                          //           padding: EdgeInsets.zero,
                                          //           children: const [
                                          //             FAQItem(
                                          //               question:
                                          //                   'Hal apa saja yang bisa saya tanyakan?',
                                          //               detail:
                                          //                   'Hal-hal yang dapat dibantu',
                                          //             ),
                                          //             FAQItem(
                                          //               question:
                                          //                   'Jam berapa operating hours hotline?',
                                          //               detail:
                                          //                   'Detail operating hours',
                                          //               ),
                                          //             ],
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
