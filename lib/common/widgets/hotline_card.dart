import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toggle_list/toggle_list.dart';
import 'package:walletwatch_mobile/common/data/hotline.dart';
import 'package:walletwatch_mobile/common/enum/hotline_state.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';

class HotlineCard extends StatefulWidget {
  final HotlineState state;
  final String title;
  final double height;
  final List<Hotline> hotlines;
  const HotlineCard({
    super.key,
    required this.state,
    required this.title,
    this.height = 400,
    required this.hotlines,
  });

  @override
  State<HotlineCard> createState() => _HotlineCardState();
}

class _HotlineCardState extends State<HotlineCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10.h),
      height: widget.height.h,
      padding: EdgeInsets.all(10.h),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppFontStyle.homeCardTitleText
                .copyWith(color: darkColor, fontSize: 22.sp),
          ),
          SizedBox(
            height: 12.h,
          ),
          Expanded(
            child: ToggleList(
              toggleAnimationDuration: const Duration(milliseconds: 200),
              scrollDuration: const Duration(milliseconds: 200),
              scrollPosition: AutoScrollPosition.middle,
              divider: SizedBox(
                height: 12.h,
              ),
              innerPadding: EdgeInsets.zero,
              trailing: Padding(
                padding: EdgeInsets.all(12.w),
                child: const Icon(Icons.expand_more),
              ),
              viewPadding: EdgeInsets.symmetric(horizontal: 10.w),
              children: [
                for (int i = 0; i < widget.hotlines.length; i++)
                  ToggleListItem(
                    divider: Divider(
                      color: borderColor,
                      height: 2.h,
                      indent: 16.w,
                      endIndent: 16.w,
                    ),
                    itemDecoration: BoxDecoration(
                      color: backColor,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: borderColor,
                        width: 1.5.w,
                      ),
                    ),
                    title: ListTile(
                      leading: const Icon(Icons.phone),
                      title: Text(
                        // '${getStateTitle(widget.hotlines[i].keys.first)} - ${widget.hotlines[i].values.first}'),
                        widget.hotlines[i].name,
                        style: AppFontStyle.homeCardTitleText
                            .copyWith(color: darkColor, fontSize: 17.sp),
                      ),
                    ),
                    content: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'No. Telp: ${widget.hotlines[i].phoneNumber ?? ''}',
                            style: AppFontStyle.homeCardTitleText.copyWith(
                              color: darkColor,
                              fontSize: 17.sp,
                              height: 1.8.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
