import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:walletwatch_mobile/common/enum/home_state.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/utils/transtition_fade.dart';
import 'package:walletwatch_mobile/common/widgets/home_navigator.dart';
import 'package:walletwatch_mobile/common/widgets/top_bar.dart';
import 'package:walletwatch_mobile/views/profile/profile_edit.dart';
import 'package:walletwatch_mobile/views/profile/profile_pdf.dart';

class HomeProfile extends StatefulWidget {
  const HomeProfile({super.key});

  @override
  State<HomeProfile> createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> {

  bool isSettingVisible = false;

  void _refresh() {
    setState(() {});
  }

  Widget _buildListTile(BuildContext context, IconData icon, String title,
      {Function()? onTap}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(title, style: const TextStyle(color: Colors.black)),
          onTap: onTap,
        ),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return HomeNavigator(

        state: HomeState.profil,
        child: Scaffold(
          backgroundColor: lightColor,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: TopBar(

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
                              context.push(
                                  '/home/profile/edit',
                                  extra: _refresh,
                                );
                            },
                            child: Text("Edit Profile",
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
                bottom: 20.h,
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
                            _buildListTile(
                              context,
                              Icons.settings,
                              'Help',
                              onTap: () async {
                              },
                            ),
                            _buildListTile(context, Icons.feedback, 'Feedback'),
                            _buildListTile(
                              context,
                              Icons.article,
                              'Terms of Service',
                              onTap: () {
                                context.push(
                                  '/home/profile/pdf',
                                  extra: {
                                    'title': 'Terms of Service',
                                    'path': 'assets/pdf/terms_of_service.pdf',
                                  },
                                );
                              },
                            ),
                            _buildListTile(
                                context, Icons.lock, 'Privacy Policy',  onTap: () {
                                  context.push('/home/profile/pdf',
                                  extra: {
                                    'title': 'Privacy Policy',
                                    'path': 'assets/pdf/privacy_policy.pdf',
                                  },
                                );
                              },
                            ),
                            _buildListTile(
                              context,
                              Icons.info,
                              'About',
                              onTap: () {
                                context.push('/home/profile/pdf',
                                  extra: {
                                    'title': 'About',
                                    'path': 'assets/pdf/about.pdf',
                                  },
                                );
                              },
                            ),
                            _buildListTile(
                              context,
                              Icons.security,
                              'Data Security Protection',
                              onTap: () {
                                context.push('/home/profile/pdf',
                                  extra: {
                                    'title': 'Data Security Protection',
                                  'path': 'assets/pdf/data_security.pdf',
                                },
                              );
                            },
                          ),
                          _buildListTile(context, Icons.exit_to_app, 'Keluar',
                              onTap: () {
                            EasyLoading.show(status: 'loading...');
                            signOut(context);
                            EasyLoading.dismiss();
                          }),
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
    );
  }
}
