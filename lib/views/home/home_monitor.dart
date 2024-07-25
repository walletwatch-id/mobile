import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/data/chart_data.dart';
import 'package:walletwatch_mobile/common/data/statistic.dart';
import 'package:walletwatch_mobile/common/data/survey_answer.dart';
import 'package:walletwatch_mobile/common/data/suvey_question.dart';
import 'package:walletwatch_mobile/common/enum/home_state.dart';
import 'package:walletwatch_mobile/common/enum/item_state.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:walletwatch_mobile/common/http/financial.dart';
import 'package:walletwatch_mobile/common/http/statistics.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/utils/transition_vertical_bottom.dart';
import 'package:walletwatch_mobile/common/widgets/area_chart.dart';
import 'package:walletwatch_mobile/common/widgets/home_navigator.dart';
import 'package:walletwatch_mobile/common/widgets/input_alert.dart';
import 'package:walletwatch_mobile/common/widgets/monitor_card.dart';
import 'package:walletwatch_mobile/common/widgets/top_bar.dart';
import 'package:walletwatch_mobile/views/monitor/self_discovery.dart';

class HomeMonitor extends StatefulWidget {
  final ScrollController controller;
  const HomeMonitor({super.key, required this.controller});

  @override
  State<HomeMonitor> createState() => _HomeMonitorState();
}

class _HomeMonitorState extends State<HomeMonitor>
    with SingleTickerProviderStateMixin {
  final _advancedDrawerController = AdvancedDrawerController();
  final _incomeController = TextEditingController();
  bool isSettingVisible = false;
  final List<ChartData> _installmentData = [];
  final List<ChartData> _incomeData = [];
  final List<Statistic> _statistics = [];
  final List<SurveyQuestion> _questions = [];
  final List<SurveyAnswer?> _answers = [];
  late TabController _tabController;
  double _limitPercentage = 0;
  int _segmentedControlValue = 0;
  double _installmentIncome = 0;
  Map<int, String> _installmentSummarizer = {1: ""};
  Map<int, String> _incomeSummarizer = {1: ""};
  bool _isInputIncomeVisible = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light, statusBarColor: darkColor));

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    loadPage();

    super.initState();
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
    _incomeController.dispose();
    _tabController.dispose();
  }

  void loadPage() async {
    EasyLoading.show(status: 'Loading...');
    final statistics = await fetchStatistics();
    final questions = await fetchFinancialQuestions();
    setState(() {
      _statistics.clear();
      _statistics.addAll(statistics);

      _installmentIncome =
          (_statistics.last.totalInstallment / _statistics.last.totalIncome);
      print(_installmentIncome);

      _limitPercentage = (_statistics.last.totalInstallment /
              (_statistics.last.ratio * _statistics.last.totalIncome)) *
          100;

      _incomeSummarizer = summarizeValues(_statistics
          .reduce((current, next) =>
              current.totalIncome > next.totalIncome ? current : next)
          .totalIncome);

      _installmentSummarizer = summarizeValues(_statistics
          .reduce((current, next) =>
              current.totalInstallment > next.totalInstallment ? current : next)
          .totalInstallment);

      for (var statistic in _statistics) {
        _incomeData.add(ChartData(convertIntToMonth(statistic.month),
            statistic.totalIncome / _incomeSummarizer.keys.first));

        _installmentData.add(ChartData(convertIntToMonth(statistic.month),
            statistic.totalInstallment / _installmentSummarizer.keys.first));
      }

      _questions.addAll(questions);
      _answers.addAll(List.generate(questions.length, (index) => null));
    });

    EasyLoading.dismiss();
  }

  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
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
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                                    'Batas wajar pinjaman kamu sudah mencapai ${_limitPercentage.toStringAsFixed(2)}%',
                                    style: AppFontStyle.homeNormalText.copyWith(
                                        color: lightColor,
                                        fontSize: 12.5.sp,
                                        height: 2)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          if (_statistics.isNotEmpty)
                            RoundedProgressBar(
                                height: 150.h,
                                childLeft: Padding(
                                  padding: EdgeInsets.only(
                                      left: _limitPercentage.w > 100
                                          ? 100
                                          : _limitPercentage.w / 1.3),
                                  child: Text(
                                      "${_limitPercentage.toStringAsFixed(2)}%",
                                      style: AppFontStyle
                                          .homeMonitorIndicatorText
                                          .copyWith(
                                              color: _installmentIncome < .15
                                                  ? darkColor
                                                  : lightColor)),
                                ),
                                style: RoundedProgressBarStyle(
                                  colorBorder: primaryColor,
                                  colorProgress: _installmentIncome < .15
                                      ? Colors.white.withOpacity(.5)
                                      : _installmentIncome > .15 &&
                                              _installmentIncome < .35
                                          ? monitorWarning
                                          : monitorDanger,
                                  backgroundProgress: secondaryColor,
                                  colorProgressDark: secondaryColor,
                                  borderWidth: 0,
                                  widthShadow: 0,
                                ),
                                percent: _limitPercentage),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 4.h),
                              child: Center(
                                child: SizedBox(
                                  height: 7.h,
                                  child: Image.asset(
                                    'assets/images/monitor_indicator.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
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
                margin: EdgeInsets.symmetric(vertical: 16.h),
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
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: ListView(
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
                                          title: "Penggunaan Paylater Bulanan",
                                          color: primaryColor,
                                          data: _installmentData,
                                          yName: _installmentSummarizer
                                              .values.first,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20.h),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24.w, vertical: 10.h),
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
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    'Money personality-mu saat ini:',
                                                    style: AppFontStyle
                                                        .homeSubTitleText
                                                        .copyWith(
                                                            color: darkColor)),
                                                SizedBox(
                                                  height: 25.h,
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 20.h),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    _statistics.isNotEmpty
                                                        ? _statistics
                                                            .last.personality
                                                        : "Personality",
                                                    style: AppFontStyle
                                                        .homeCardTitleText
                                                        .copyWith(
                                                            color: darkColor,
                                                            fontSize: 28.sp),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
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
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      Navigator.of(context).push(
                                                          TransitionVerticalBottom(
                                                              child:
                                                                  const SelfDiscovery()));
                                                    });
                                                  },
                                                  child: Text("Survey Ulang",
                                                      style: AppFontStyle
                                                          .homeSubTitleText
                                                          .copyWith(
                                                              color:
                                                                  lightColor)),
                                                ),
                                              ),
                                            ),
                                          ],
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
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * .3,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: ListView(
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
                                          title: "Pendapatan Bulanan",
                                          color: primaryColor,
                                          data: _incomeData,
                                          yName: _incomeSummarizer.values.first,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20.h),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24.w, vertical: 10.h),
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
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                                            color: darkColor)),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _isInputIncomeVisible =
                                                          true;
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.edit_outlined,
                                                    size: 25.h,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 20.h),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    formatCurrency(
                                                        _statistics.isNotEmpty
                                                            ? _statistics.last
                                                                .totalIncome
                                                            : 0),
                                                    style: AppFontStyle
                                                        .homeCardTitleText
                                                        .copyWith(
                                                            color: darkColor,
                                                            fontSize: 28.sp),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.h, horizontal: 12.w),
                                        child: Divider(
                                          color: borderColor,
                                          thickness: 2.w,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24.w, vertical: 10.h),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: lightColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16.r),
                                          ),
                                          border: Border.all(
                                            color: borderColor,
                                            width: 1.5,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: borderColor,
                                              spreadRadius: -1.0,
                                              blurRadius: 5.0,
                                              offset: Offset(0, 5.h),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: _toggleExpand,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Historis',
                                                      style: AppFontStyle
                                                          .homeSubTitleText
                                                          .copyWith(
                                                              fontSize: 24.sp,
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
                                                    _isExpanded
                                                        ? Icons
                                                            .keyboard_arrow_up
                                                        : Icons
                                                            .keyboard_arrow_down,
                                                    color: darkBorderColor,
                                                    size: 28.h,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            AnimatedCrossFade(
                                              firstChild: Container(),
                                              secondChild: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 14.h),
                                                child: Column(
                                                  children: [
                                                    for (var statistic
                                                        in _statistics)
                                                      Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Bulan ${convertIntToMonth(statistic.month)}",
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
                                                                    statistic
                                                                        .totalIncome),
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
                                                          if (_statistics
                                                                  .isNotEmpty &&
                                                              statistic !=
                                                                  _statistics
                                                                      .last)
                                                            SizedBox(
                                                              height: 8.h,
                                                            ),
                                                        ],
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              crossFadeState: _isExpanded
                                                  ? CrossFadeState.showSecond
                                                  : CrossFadeState.showFirst,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * .3,
                                  )
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
            InputAlert(
              title: "Update Pendapatan",
              label: " Jumlah Pendapatan",
              hint: "Masukkan Jumlah Pendapatan..",
              submitText: "Update",
              colors: [secondaryColor, primaryColor, primaryColor],
              keyboardType: TextInputType.number,
              visible: _isInputIncomeVisible,
              onSubmit: () async {
                try {
                  setState(() {
                    double.parse(_incomeController.text);
                    _answers[0] = SurveyAnswer(
                        questionId: _questions[0].id,
                        answer: _incomeController.text);
                  });
                } catch (e) {
                  EasyLoading.showError("Masukkan angka yang valid");
                }

                if (_answers[0] != null) {
                  EasyLoading.show(status: 'Loading...');
                  var result = await storeFinancialSurveyResult();
                  EasyLoading.dismiss();

                  if (result != null) {
                    bool request = await storeFinancialSurveyAnswers(
                        resultId: result,
                        surveyAnswers: _answers.map((e) => e).toList());

                    if (request) {
                      EasyLoading.showSuccess("Berhasil mengirim jawaban");
                      loadPage();
                    }
                  } else {
                    EasyLoading.showError("Gagal mengirim jawaban");
                  }
                } else {
                  EasyLoading.showError("Silahkan jawab semua pertanyaan");
                }

                setState(() {
                  _isInputIncomeVisible = false;
                  _incomeController.clear();
                });
              },
              onDismiss: () {
                setState(() {
                  _isInputIncomeVisible = false;
                });
              },
              controller: _incomeController,
            ),
          ],
        ),
      ),
    );
  }
}
