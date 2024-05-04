import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/enum/item_state.dart';
import 'package:wallet_watch/common/helper.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';

class MonitorCard extends StatefulWidget {
  final ItemState state;
  final double value;
  final String unit;
  const MonitorCard(
      {super.key,
      required this.state,
      required this.value,
      this.unit = "Per Bulan"});

  @override
  State<MonitorCard> createState() => _MonitorCardState();
}

class _MonitorCardState extends State<MonitorCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      width: double.infinity,
      decoration: BoxDecoration(
          color: lightColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          border: Border.all(
            color: borderColor,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(child: getStateImage(widget.state)),
            
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w, right: 20.w, top: 20.h, bottom: 20.h),
            child: Column(
              children: [
                Text(formatCurrency(widget.value), style: AppFontStyle.homeCardTitleText.copyWith(color: darkColor),),
                SizedBox(height: 4.h,),
                Text(widget.unit, style: AppFontStyle.authSubLabelText.copyWith(color: subColor),)
              ],
            ),
          )
        ],
      )
    );
  }
}
