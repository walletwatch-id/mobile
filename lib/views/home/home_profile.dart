import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/enum/home_state.dart';
import 'package:wallet_watch/common/enum/hotline_state.dart';
import 'package:wallet_watch/common/enum/item_state.dart';
import 'package:wallet_watch/common/helper.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';
import 'package:wallet_watch/common/utils/transtition_fade.dart';
import 'package:wallet_watch/common/widgets/home_navigator.dart';
import 'package:wallet_watch/common/widgets/hotline_card.dart';
import 'package:wallet_watch/common/widgets/top_bar.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:wallet_watch/views/profile/edit_profile.dart';

class HomeProfile extends StatefulWidget {
  final ScrollController controller;
  const HomeProfile({super.key, required this.controller});

  @override
  State<HomeProfile> createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> {
  final _advancedDrawerController = AdvancedDrawerController();
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

  Widget _buildListTile(BuildContext context, IconData icon, String title) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(title, style: TextStyle(color: Colors.black)),
          onTap: () {},
        ),
        Divider(height: 1, color: Colors.grey),
      ],
    );
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
                  title: "Profile",
                  textColor: darkColor,
                  isLight: true,
                  settingAction: () {
                    //
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40.h),
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 40.w),
                  alignment: Alignment.bottomCenter,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(
                        height: 60.h,
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
                                      user.email,
                                      style: AppFontStyle.homeListHeaderText
                                          .copyWith(
                                              color: subColor, fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
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
                          borderRadius: BorderRadius.circular(12.r),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.of(context).push(TransitionFade(
                                  child: EditProfile(
                                      controller: widget.controller)));
                            },
                            child: Text("Edit Profil",
                                style: AppFontStyle.homeSubTitleText
                                    .copyWith(color: lightColor)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        height: 100.h,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 200.h,
                bottom: 100.h,
                left: 0,
                right: 0,
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 40.w),
                  height: MediaQuery.of(context).size.height * .5,
                  padding: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.05),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: borderColor,
                      width: 1.5.w,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: Text(
                          "Settings",
                          style: AppFontStyle.accountNameText
                              .copyWith(fontSize: 24.sp),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            _buildListTile(context, Icons.settings, 'Help'),
                            _buildListTile(context, Icons.feedback, 'Feedback'),
                            _buildListTile(
                                context, Icons.article, 'Terms of Service'),
                            _buildListTile(
                                context, Icons.lock, 'Privacy Policy'),
                            _buildListTile(context, Icons.info, 'About'),
                            _buildListTile(context, Icons.security,
                                'Data Security Protection'),
                            _buildListTile(
                                context, Icons.exit_to_app, 'Keluar'),
                          ],
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
