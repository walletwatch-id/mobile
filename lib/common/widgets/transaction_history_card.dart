import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';

class TransactionHistoryCard extends StatefulWidget {
  final String title;
  final String value;
  final String description;
  const TransactionHistoryCard(
      {super.key,
      required this.title,
      required this.value,
      required this.description});

  @override
  State<TransactionHistoryCard> createState() => _TransactionHistoryCardState();
}

class _TransactionHistoryCardState extends State<TransactionHistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1.w, color: borderColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: AppFontStyle.normalText
                  .copyWith(fontSize: 18.sp, color: subColor, height: 1.4,),
            ),
            SizedBox(height: 8.h),
            Text(
              widget.value,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              widget.description,
              style: TextStyle(color: darkColor),
            ),
          ],
        ),
      ),
    );
  }
}
