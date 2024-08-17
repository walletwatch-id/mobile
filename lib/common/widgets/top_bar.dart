import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/enum/home_state.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/utils/transition_vertical_top.dart';
import 'package:walletwatch_mobile/views/home/home_notification.dart';

class TopBar extends StatefulWidget {
  final String? title;
  final VoidCallback settingAction;
  final VoidCallback? popAction;
  final bool canClose;
  final Color? backgroundColor;
  final Color? textColor;
  final HomeState? state;
  final bool isLight;
  const TopBar(
      {super.key,
      this.title,
      required this.settingAction,
      this.popAction,
      this.state,
      this.backgroundColor,
      this.textColor,
      this.canClose = false,
      this.isLight = false});

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
          if (widget.canClose)
              SizedBox(
                  width: 58.w,
                  child: GestureDetector(
                    onTap: () {
                      if (widget.popAction != null) {
                        widget.popAction!();
                      }

                      if (widget.isLight) {
                        SystemChrome.setSystemUIOverlayStyle(
                            SystemUiOverlayStyle(
                                statusBarIconBrightness: Brightness.light,
                                statusBarColor: darkColor));
                      }
                      Navigator.pop(context);
                    },
                    child: Semantics(
                        label: "Kembali ke halaman sebelumnya!",
                        child: Icon(
                          Icons.close_rounded,
                          color: primaryColor,
                          size: 32.w,
                        )
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
                Navigator.of(context).push(TransitionVerticalTop(
                    child: HomeNotification(
                  isLight: widget.isLight,
                  popAction: widget.popAction,

                )));
              }
            },
            child: Semantics(
                label: "Notification",
                child: Icon(
                  widget.state == HomeState.notification
                      ? Icons.notifications
                      : Icons.notifications_outlined,
                  color: primaryColor,
                )),
          ),
        ],
      ),
    );
  }
}
