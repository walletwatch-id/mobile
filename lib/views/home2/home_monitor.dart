import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/data/chart_data.dart';
import 'package:walletwatch_mobile/common/enum/home_state.dart';
import 'package:walletwatch_mobile/common/enum/item_state.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/widgets/area_chart.dart';
import 'package:walletwatch_mobile/common/widgets/home_navigator.dart';
import 'package:walletwatch_mobile/common/widgets/monitor_card.dart';
import 'package:walletwatch_mobile/common/widgets/top_bar.dart';

class HomeMonitor extends StatefulWidget {
  const HomeMonitor({super.key});

  @override
  State<HomeMonitor> createState() => _HomeMonitorState();
}

class _HomeMonitorState extends State<HomeMonitor>
    with SingleTickerProviderStateMixin {
  final _advancedDrawerController = AdvancedDrawerController();
  bool isSettingVisible = false;
  late List<ChartData> _data;
  late TabController _tabController;
  int _segmentedControlValue = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, statusBarColor: lightColor));

    _data = [
      ChartData("Januari", 1.52),
      ChartData("Februari", 4.54),
      ChartData("Maret", 3.51),
      ChartData("April", 9.22),
      ChartData("Mei", 6.23),
      ChartData("Juni", 7.41),
    ];

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    Future.delayed(const Duration(milliseconds: 280), () {
      setState(() {
        _segmentedControlValue = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return HomeNavigator(
        controller: _advancedDrawerController,
        state: HomeState.monitor,
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
                    title: "Monitor",
                    textColor: darkColor,
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
                child: Container(
                  height: 60.h,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                                user.name,
                                style: AppFontStyle.accountNameText,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                "Selamat datang di Aplikasi WalletWatch!",
                                style: AppFontStyle.homeListHeaderText
                                    .copyWith(color: subColor, fontSize: 13.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 120.h,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: lightColor,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20.w),
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        height: 260.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: darkColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                          border: Border.all(
                            color: const Color(0xFF4F4F4F).withOpacity(0.31),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 18.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Financial Status',
                                    style: AppFontStyle.homeSubHeaderText
                                        .copyWith(color: lightColor)),
                                Text(
                                    'Batas wajar pinjaman kamu sudah mencapai 73%',
                                    style: AppFontStyle.homeNormalText
                                        .copyWith(color: lightColor)),
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            RoundedProgressBar(
                                height: 150.h,
                                childLeft: Padding(
                                  padding: EdgeInsets.only(left: 73.w / 1.1),
                                  child: Text("73%",
                                      style: AppFontStyle
                                          .homeMonitorIndicatorText
                                          .copyWith(color: darkColor)),
                                ),
                                style: RoundedProgressBarStyle(
                                  colorBorder: monitorBackgroundColor,
                                  colorProgress: Colors.white.withOpacity(.5),
                                  backgroundProgress: monitorBackgroundColor,
                                  colorProgressDark: monitorBackgroundColor,
                                  borderWidth: 0,
                                  widthShadow: 0,
                                ),
                                percent: 73),
                            SizedBox(
                              height: 11.h,
                            ),
                            Center(
                              child: SizedBox(
                                height: 7.h,
                                child: Image.asset(
                                  'assets/images/monitor_indicator.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 400.h,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                  alignment: Alignment.bottomCenter,
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Money Personality Kamu',
                              style: AppFontStyle.monitorSubHeaderText
                                  .copyWith(color: darkColor, fontSize: 20.sp)),
                          SizedBox(
                            height: 30.h,
                            width: 100.w,
                            child: ElevatedButton(
                              onPressed: () {
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.white),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                padding:
                                    WidgetStateProperty.all(EdgeInsets.zero),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 8.w,),
                                      Text(
                                        "Cari Tahu",
                                        style: AppFontStyle.homeNormalText.copyWith(
                                            color: darkColor, fontSize: 14.sp),
                                      ),
                                      Icon(Icons.arrow_right, color: darkColor,)
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
                        width: 300.w,
                        
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1.w, color: borderColor)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.black.withOpacity(.05),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
Text(
                              'Self-Discovery',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.pinkAccent,
                                  child: CircleAvatar(
                                    radius: 38,
                                    backgroundImage: AssetImage(
                                        'assets/personality.png'), // Add your image asset here
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    'Untuk pengontrolan lebih baik, mari kita mencari tahu tipe personalitas keuangan kamu!',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                              ],)),
                            Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(
                              'Kamu tipe:',
                              style: AppFontStyle.homeNormalText.copyWith(color: primaryColor)
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              'Melati Binger',
                              style: AppFontStyle.homeSubHeaderText
                            ),
                              ],),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      SizedBox(
                        height: 800.h,
                        child: Center(
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0.h,
                                right: 0.w,
                                left: 0.w,
                                child: Center(
                                  child: CustomSlidingSegmentedControl<int>(
                                    initialValue: _segmentedControlValue,
                                    children: {
                                      0: SizedBox(
                                          width: 150.w,
                                          child: Center(
                                              child: Text(
                                            'Pinjaman',
                                            style: AppFontStyle.homeTabText
                                                .copyWith(
                                                    color:
                                                        _segmentedControlValue ==
                                                                0
                                                            ? lightColor
                                                            : darkColor),
                                          ))),
                                      1: SizedBox(
                                          width: 150.w,
                                          child: Center(
                                              child: Text(
                                            'Pendapatan',
                                            style: AppFontStyle.homeTabText
                                                .copyWith(
                                                    color:
                                                        _segmentedControlValue ==
                                                                1
                                                            ? lightColor
                                                            : darkColor),
                                          ))),
                                    },
                                    decoration: BoxDecoration(
                                      color:
                                          CupertinoColors.lightBackgroundGray,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    height: 35.h,
                                    thumbDecoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(.3),
                                          blurRadius: 4.0,
                                          spreadRadius: 1.0,
                                          offset: const Offset(
                                            0.0,
                                            2.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInToLinear,
                                    onValueChanged: (v) async {
                                      setState(() {
                                        _tabController.index = v;
                                      });

                                      // await Future.delayed(
                                      //     const Duration(milliseconds: 3000), () async {

                                      // });
                                      // setState(() {
                                      //     _segmentedControlValue =
                                      //         _tabController.index;
                                      //   });
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 46.h,
                                right: 0,
                                bottom: 0,
                                left: 0,
                                child: SizedBox(
                                  height: double.infinity,
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      Column(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 8.h),
                                                  height: 280.h,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: lightColor,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(16),
                                                      ),
                                                      border: Border.all(
                                                        color: borderColor,
                                                        width: 1.5.w,
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: borderColor,
                                                          spreadRadius: -1.h,
                                                          blurRadius: 5.w,
                                                          offset:
                                                              Offset(0, 5.h),
                                                        ),
                                                      ]),
                                                  child: AreaChart(
                                                    title:
                                                        "Penggunaan Paylater Bulanan",
                                                    color: primaryColor,
                                                    data: _data,
                                                  ),
                                                ),
                                                const MonitorCard(
                                                    state: ItemState.shopee,
                                                    value: 958125),
                                                const MonitorCard(
                                                    state: ItemState.kredivo,
                                                    value: 638750),
                                                const MonitorCard(
                                                    state: ItemState.akulaku,
                                                    value: 532291),
                                              ],
                                            ),
                                          ],
                                        
                                      ),
                                      // Content for Pendapatan tab
                                       Column(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 8.h),
                                                  height: 280.h,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: lightColor,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(16),
                                                      ),
                                                      border: Border.all(
                                                        color: borderColor,
                                                        width: 1.5.w,
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: borderColor,
                                                          spreadRadius: -1.h,
                                                          blurRadius: 5.w,
                                                          offset:
                                                              Offset(0, 5.h),
                                                        ),
                                                      ]),
                                                  child: AreaChart(
                                                    title: "Pendapatan Bulanan",
                                                    color: primaryColor,
                                                    data: _data,
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 20.h),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 24.w,
                                                      vertical: 10.h),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: lightColor,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(16),
                                                      ),
                                                      border: Border.all(
                                                        color: borderColor,
                                                        width: 1.5.w,
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: borderColor,
                                                          spreadRadius: -1.h,
                                                          blurRadius: 5.w,
                                                          offset:
                                                              Offset(0, 5.h),
                                                        ),
                                                      ]),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              'Total pendapatan bulan ini:',
                                                              style: AppFontStyle
                                                                  .homeSubTitleText
                                                                  .copyWith(
                                                                      color:
                                                                          darkColor)),
                                                          Icon(
                                                            Icons.edit_outlined,
                                                            size: 25.h,
                                                          )
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 20.h),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              formatCurrency(
                                                                  9462962),
                                                              style: AppFontStyle
                                                                  .homeCardTitleText
                                                                  .copyWith(
                                                                      color:
                                                                          darkColor,
                                                                      fontSize:
                                                                          28.sp),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 16.h,
                                                      horizontal: 12.w),
                                                  child: Divider(
                                                    color: borderColor,
                                                    thickness: 2.w,
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 24.w,
                                                      vertical: 10.h),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: lightColor,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(16),
                                                      ),
                                                      border: Border.all(
                                                        color: borderColor,
                                                        width: 1.5.w,
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: borderColor,
                                                          spreadRadius: -1.h,
                                                          blurRadius: 5.w,
                                                          offset:
                                                              Offset(0, 5.h),
                                                        ),
                                                      ]),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text('Historis',
                                                              style: AppFontStyle.homeSubTitleText.copyWith(
                                                                  fontSize:
                                                                      24.sp,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                  decorationColor:
                                                                      primaryColor,
                                                                  decorationThickness:
                                                                      2.h,
                                                                  color:
                                                                      primaryColor)),
                                                          Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            color:
                                                                darkBorderColor,
                                                            size: 28.h,
                                                          )
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 14.h),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Bulan Mei",
                                                                  style: AppFontStyle
                                                                      .homeCardTitleText
                                                                      .copyWith(
                                                                          color:
                                                                              darkColor,
                                                                          fontSize:
                                                                              18.sp),
                                                                ),
                                                                Text(
                                                                  formatCurrency(
                                                                      9254000),
                                                                  style: AppFontStyle
                                                                      .homeCardTitleText
                                                                      .copyWith(
                                                                          color:
                                                                              darkColor,
                                                                          fontSize:
                                                                              18.sp),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 8.h,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Bulan April",
                                                                  style: AppFontStyle
                                                                      .homeCardTitleText
                                                                      .copyWith(
                                                                          color:
                                                                              darkColor,
                                                                          fontSize:
                                                                              18.sp),
                                                                ),
                                                                Text(
                                                                  formatCurrency(
                                                                      9350000),
                                                                  style: AppFontStyle
                                                                      .homeCardTitleText
                                                                      .copyWith(
                                                                          color:
                                                                              darkColor,
                                                                          fontSize:
                                                                              18.sp),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
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
        ));
  }
}
