import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/data/suvey_question.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';

class SelfDiscoveryItem extends StatefulWidget {
  final int number;
  final SurveyQuestion surveyQuestion;
  final Function(int?)? onSelected;
  final int selectedValue;
  const SelfDiscoveryItem(
      {super.key,
      required this.number,
      required this.surveyQuestion,
      this.onSelected,
      required this.selectedValue});

  @override
  State<SelfDiscoveryItem> createState() => _SelfDiscoveryItemState();
}

class _SelfDiscoveryItemState extends State<SelfDiscoveryItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 16.r,
                child: Text(
                  '${widget.number}',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  widget.surveyQuestion.question,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tidak\nSetuju',
                style: TextStyle(color: Colors.red, fontSize: 12.sp),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Row(
                    children: [
                      Radio<int>(
                        value: index,
                        groupValue: widget.selectedValue,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              widget.onSelected!(value);
                            });
                          }
                        },
                        activeColor: primaryColor,
                      ),
                    ],
                  );
                }),
              ),
              Text(
                'Sangat\nSetuju',
                style: TextStyle(color: Colors.green, fontSize: 12.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
