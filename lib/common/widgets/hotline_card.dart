import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/enum/hotline_state.dart';
import 'package:wallet_watch/common/enum/item_state.dart';
import 'package:wallet_watch/common/helper.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';

class HotlineCard extends StatefulWidget {
  final HotlineState state;
  final String title;
  final List<Map<ItemState, String>> hotlines;
  const HotlineCard({super.key, required this.state, required this.title, required this.hotlines});

  @override
  State<HotlineCard> createState() => _HotlineCardState();
}

class _HotlineCardState extends State<HotlineCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.all(10.h),
      width: double.infinity,
      decoration: BoxDecoration(
          color: widget.state == HotlineState.government ? primaryColor.withOpacity(.4) : lightColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          border: Border.all(
            color: widget.state == HotlineState.government ? darkColor : primaryColor,
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
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                //  login(context, _usernameController.text, _passwordController.text);
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) {
                //   return const Home();
                // }));
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                  border: widget.state == HotlineState.government ? Border.all(color: lightColor) : null,
                ),
                child: Center(
                  child: Text(
                    widget.title,
                    style: AppFontStyle.homeCardTitleText
                        .copyWith(color: lightColor, fontSize: 18.sp),
                  ),
                ),
              ),
            ),
          ),
          for (int i = 0; i < widget.hotlines.length; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                      child: getStateImage(widget.hotlines[i].keys.first)),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 8.w, right: 30.w, top: 30.h, bottom: 20.h),
                      child: Text(
                        widget.hotlines[i].values.first,
                        style: widget.state == HotlineState.government ? AppFontStyle.homeCardTitleText
                        .copyWith(color: dark, fontSize: 30.sp) : AppFontStyle.homeCardTitleText
                            .copyWith(color: darkColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
