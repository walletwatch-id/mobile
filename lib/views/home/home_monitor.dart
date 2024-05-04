import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/data/chart_data.dart';
import 'package:wallet_watch/common/enum/home_state.dart';
import 'package:wallet_watch/common/enum/paylater_state.dart';
import 'package:wallet_watch/common/helper.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';
import 'package:wallet_watch/common/widgets/area_chart.dart';
import 'package:wallet_watch/common/widgets/home_navigator.dart';
import 'package:wallet_watch/common/widgets/monitor_card.dart';
import 'package:wallet_watch/common/widgets/top_bar.dart';

class HomeMonitor extends StatefulWidget {
  final ScrollController controller;
  const HomeMonitor({super.key, required this.controller});

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
          body: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: TopBar(
                    controller: _advancedDrawerController,
                    title: "Monitor",
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
                          child: Text('Halo, ${user.name}!',
                              style: AppFontStyle.homeSubTitleText
                                  .copyWith(color: lightColor)),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20.w),
                        padding: EdgeInsets.symmetric( horizontal: 10.w),
                        height: 260.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: primaryColor,
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
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Column(
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
                                  colorBorder: primaryColor,
                                  colorProgress: Colors.white.withOpacity(.5),
                                  backgroundProgress: secondaryColor,
                                  colorProgressDark: secondaryColor,
                                  borderWidth: 0,
                                  widthShadow: 0,
                                ),
                                percent: 73),
                                SizedBox(height: 11.h,),
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
              Container(
                margin: EdgeInsets.only(top: 360.h),
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
                          right: 0.w,
                          left: 0.w,
                          child: Center(
                            child: CustomSlidingSegmentedControl<int>(
                              initialValue: _segmentedControlValue,
                              children: {
                                0: SizedBox(
                                    width: 140.w,
                                    child: Center(
                                        child: Text(
                                      'Pinjaman',
                                      style: AppFontStyle.homeTabText.copyWith(
                                          color: _segmentedControlValue == 0
                                              ? lightColor
                                              : darkColor),
                                    ))),
                                1: SizedBox(
                                    width: 140.w,
                                    child: Center(
                                        child: Text(
                                      'Pendapatan',
                                      style: AppFontStyle.homeTabText.copyWith(
                                          color: _segmentedControlValue == 1
                                              ? lightColor
                                              : darkColor),
                                    ))),
                              },
                              decoration: BoxDecoration(
                                color: CupertinoColors.lightBackgroundGray,
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
                                ListView(
                                  controller: widget.controller,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 8.h),
                                          height: 280.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: lightColor,
                                              borderRadius:
                                                  const BorderRadius.all(
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
                                                  offset: Offset(0, 5.h),
                                                ),
                                              ]),
                                          child: AreaChart(
                                            title: "Penggunaan Paylater",
                                            color: primaryColor,
                                            data: _data,
                                          ),
                                        ),
                                        const MonitorCard(
                                            state: PaylaterState.shopee,
                                            value: 958125),
                                        const MonitorCard(
                                            state: PaylaterState.kredivo,
                                            value: 958125),
                                        const MonitorCard(
                                            state: PaylaterState.akulaku,
                                            value: 958125),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .3,
                                    )
                                  ],
                                ),
                                // Content for Pendapatan tab
                                const Center(
                                  child: Text('Pendapatan'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
