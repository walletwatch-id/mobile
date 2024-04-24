import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';

class TopBar extends StatefulWidget {
  final String? title;
  final VoidCallback settingAction;
  final VoidCallback? popAction;
  final AdvancedDrawerController? controller;
  const TopBar(
      {super.key,
      this.title,
      required this.settingAction,
      this.popAction,
      this.controller});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8.w, right: 16.w),
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.controller != null
              ? IconButton(
                  onPressed: _handleMenuButtonPressed,
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                    valueListenable: widget.controller!,
                    builder: (_, value, __) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: Icon(
                          value.visible ? Icons.clear : Icons.menu,
                          key: ValueKey<bool>(value.visible),
                          size: 32.w,
                          color: primaryColor,
                        ),
                      );
                    },
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    if (widget.popAction != null) {
                      widget.popAction!();
                    }
                    // setState(() {
                    //   isSettingAlertVisible = false;
                    // });
                    Navigator.pop(context);
                  },
                  child: Semantics(
                    label: "Kembali ke halaman sebelumnya!",
                    child: Image.asset(
                      'assets/icons/back.png',
                      color: primaryColor,
                      width: 32.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              alignment: Alignment.center,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Center(
                      child: Text(widget.title ?? '',
                          style: AppFontStyle.topBarTitleText.copyWith(
                              color: lightColor)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.settingAction();
              });
            },
            child: Semantics(
              label: "Notification",
              child: Icon(Icons.notifications_outlined, color: primaryColor,)
            ),
          ),
        ],
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    widget.controller!.showDrawer();
  }
}
