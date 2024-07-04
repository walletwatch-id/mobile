import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/enum/home_state.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';
import 'package:wallet_watch/common/utils/transition_vertical_top.dart';
import 'package:wallet_watch/views/home/home_notification.dart';

class TopBar extends StatefulWidget {
  final String? title;
  final VoidCallback settingAction;
  final VoidCallback? popAction;
  final AdvancedDrawerController? controller;
  final Color? backgroundColor;
  final Color? textColor;
  final HomeState? state;
  const TopBar(
      {super.key,
      this.title,
      required this.settingAction,
      this.popAction,
      this.state,
      this.backgroundColor,
      this.textColor,
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
      color: widget.backgroundColor ?? Colors.transparent,
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
              : SizedBox(
                width: 58.w,
                child: GestureDetector(
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
                      child: Icon(Icons.close_rounded, color: primaryColor, size: 32.w,)
                      // child: Image.asset(
                      //   'assets/icons/back.png',
                      //   color: primaryColor,
                      //   width: 32.w,
                      //   fit: BoxFit.cover,
                      // ),
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
                          style: AppFontStyle.topBarTitleText
                              .copyWith(color: widget.textColor ?? lightColor)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.settingAction();
              if (widget.state != HomeState.notification) {
                Navigator.of(context).push(
                    TransitionVerticalTop(child: const HomeNotification()));
              }
            },
            child: Semantics(
                label: "Notification",
                child: Icon(
                  widget.state == HomeState.notification ? Icons.notifications : Icons.notifications_outlined,
                  color: primaryColor,
                )),
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
