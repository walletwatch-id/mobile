import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googleapis/datamigration/v1.dart';
import 'package:wallet_watch/common/data/self_discovery.dart';
import 'package:wallet_watch/common/enum/home_state.dart';
import 'package:wallet_watch/common/enum/hotline_state.dart';
import 'package:wallet_watch/common/enum/item_state.dart';
import 'package:wallet_watch/common/enum/notification_state.dart';
import 'package:wallet_watch/common/helper.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';
import 'package:wallet_watch/common/utils/transtition_fade.dart';
import 'package:wallet_watch/common/widgets/home_navigator.dart';
import 'package:wallet_watch/common/widgets/hotline_card.dart';
import 'package:wallet_watch/common/widgets/notification_item.dart';
import 'package:wallet_watch/common/widgets/self_discovery_item.dart';
import 'package:wallet_watch/common/widgets/top_bar.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:wallet_watch/views/home/home.dart';
import 'package:wallet_watch/views/monitor/self_discovery_finish.dart';

class SelfDiscovery extends StatefulWidget {
  const SelfDiscovery({super.key});

  @override
  State<SelfDiscovery> createState() => _SelfDiscoveryState();
}

class _SelfDiscoveryState extends State<SelfDiscovery> {
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
    return Padding(
      padding: EdgeInsets.only(top: 28.h),
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
                            style: AppFontStyle.homeSubTitleText
                                .copyWith(color: darkColor, fontSize: 17.sp)),
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
                  ...selfDiscoveries.asMap().entries.map((entry) {
                    int index = entry.key;
                    var item = entry.value;
                    return SelfDiscoveryItem(
                      number: index + 1,
                      selfDiscovery: item,
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
                        onPressed: () {
                          Navigator.of(context).pushReplacement(TransitionFade(
                              child: const SelfDiscoveryFinish()));
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
