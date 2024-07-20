import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/data/self_discovery.dart';
import 'package:walletwatch_mobile/common/data/survey_answer.dart';
import 'package:walletwatch_mobile/common/data/suvey_question.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:walletwatch_mobile/common/http/personality.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/utils/transtition_fade.dart';
import 'package:walletwatch_mobile/common/widgets/self_discovery_item.dart';
import 'package:walletwatch_mobile/common/widgets/top_bar.dart';
import 'package:walletwatch_mobile/views/monitor/self_discovery_finish.dart';

class SelfDiscovery extends StatefulWidget {
  const SelfDiscovery({super.key});

  @override
  State<SelfDiscovery> createState() => _SelfDiscoveryState();
}

class _SelfDiscoveryState extends State<SelfDiscovery> {
  bool isSettingVisible = false;
  final List<SurveyQuestion> _questions = [];
  final List<SurveyAnswer?> _answers = [];

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, statusBarColor: lightColor));

    EasyLoading.init();
    loadPage();
    super.initState();
  }

  void loadPage() async {
    EasyLoading.show(status: 'Loading...');
    final questions = await fetchPersonalityQuestions();
    setState(() {
      _questions.clear();
      _questions.addAll(questions);
      _answers.addAll(List.generate(questions.length, (index) => null));
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightColor,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: TopBar(
                title: "Self-Discovery",
                textColor: darkColor,
                isLight: true,
                settingAction: () {
                  //
                },
              ),
            ),
            Positioned(
              top: 55.h,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Container(
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
                                  width: 56.h, height: 56.h, child: user.image),
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
                                      .copyWith(
                                          color: subColor, fontSize: 13.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40.h,
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CupertinoColors.lightBackgroundGray,
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
                          setState(() {});
                        },
                        child: Text("Silahkan menjawab pertanyaan di bawah ini",
                            style: AppFontStyle.homeSubTitleText.copyWith(
                                color: darkColor,
                                fontSize: 14.sp,
                                height: 1.4)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 180.h,
              right: 0,
              left: 0,
              bottom: 0,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ..._questions.asMap().entries.map((entry) {
                    int index = entry.key;
                    var item = entry.value;
                    return SelfDiscoveryItem(
                      number: index + 1,
                      surveyQuestion: item,
                      selectedValue: _answers[index]?.answer ?? -1,
                      onSelected: (value) {
                        setState(
                          () {
                            _answers[index] = SurveyAnswer(
                                questionId: item.id, answer: value!);
                          },
                        );
                      },
                    );
                  }),
                  Container(
                    height: 40.h,
                    margin: EdgeInsets.all(16.w),
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
                        onPressed: () async {
                          if (_answers
                                  .toList()
                                  .where((e) => e != null)
                                  .length ==
                              _questions.length) {
                            EasyLoading.show(status: 'Loading...');
                            var result = await storePersonalitySurveyResult();

                            if (result != null) {
                              bool request =
                                  await storePersonalitySurveyAnswers(
                                      resultId: result,
                                      surveyAnswers:
                                          _answers.map((e) => e!).toList());

                              print(result);

                              if (request) {
                                Navigator.of(context).pushReplacement(
                                    TransitionFade(
                                        child: const SelfDiscoveryFinish()));
                              }

                              EasyLoading.dismiss();
                            } else {
                              EasyLoading.showError("Gagal mengirim jawaban");
                            }
                          } else {
                            EasyLoading.showError(
                                "Silahkan jawab semua pertanyaan");
                          }
                        },
                        child: Text("Selesai",
                            style: AppFontStyle.homeSubTitleText
                                .copyWith(color: lightColor)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
