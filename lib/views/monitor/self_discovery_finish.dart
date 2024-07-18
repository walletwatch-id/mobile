import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/widgets/top_bar.dart';

class SelfDiscoveryFinish extends StatefulWidget {
  const SelfDiscoveryFinish({super.key});

  @override
  State<SelfDiscoveryFinish> createState() => _SelfDiscoveryFinishState();
}

class _SelfDiscoveryFinishState extends State<SelfDiscoveryFinish> {
  bool isSettingVisible = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, statusBarColor: lightColor));
    super.initState();
  }

  void refresh() {
    setState(() {});
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
                              child: Image.asset(
                                user.image,
                              ),
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
                  SizedBox(
                    height: 60.h,
                  ),
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
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text("Kamu telah menjawab semua pertanyaan",
                            style: AppFontStyle.homeSubTitleText
                                .copyWith(color: lightColor)),
                      ),
                    ),
                  ),
                  Container(
                    height: 200.h,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        border: Border.all(color: borderColor, width: 1.5.w)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Text("Selesai",
                            style: AppFontStyle.homeSubTitleText.copyWith(
                                color: primaryColor, fontSize: 28.sp)),
                        Container(
                          height: 40.h,
                          width: 120.w,
                          margin: EdgeInsets.all(16.w),
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
                              child: Text("Coba ulang",
                                  style: AppFontStyle.homeNormalText
                                      .copyWith(color: darkColor)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 120.h,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Text("Money Personality Kamu",
                        style: AppFontStyle.homeSubTitleText.copyWith(
                            color: darkColor, fontSize: 28.sp, height: 1.4)),
                    Text(
                      "Berdasarkan jawaban kamu",
                      style: AppFontStyle.homeListHeaderText.copyWith(
                          color: subColor, fontSize: 16.sp, height: 1.4),
                    ),
                    Container(
                      height: 100.h,
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                          border: Border.all(color: borderColor, width: 1.5.w)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Personality Type",
                            style: AppFontStyle.homeListHeaderText.copyWith(
                                color: subColor, fontSize: 20.sp, height: 1.4),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text("Binger",
                              style: AppFontStyle.homeSubTitleText
                                  .copyWith(color: darkColor, fontSize: 28.sp)),
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
