import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/data/feedback_item.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';

class FeedbackCard extends StatelessWidget {
  final FeedbackItem feedbackItem;

  const FeedbackCard(this.feedbackItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      color: lightColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          color: Colors.black.withOpacity(0.05),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(feedbackItem.userImage),
                            radius: 20.r,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Expanded(
                            child: Text(
                              feedbackItem.userName,
                               style: AppFontStyle.homeListHeaderText
                                  .copyWith(color: darkColor, fontSize: 15.sp),
                            ),
                          ),
                          Row(
                            children: List.generate(feedbackItem.rating, (index) {
                              return Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                                size: 16,
                              );
                            }),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        feedbackItem.feedback,
                         style: AppFontStyle.homeListHeaderText
                                  .copyWith(color: darkColor, fontSize: 14.sp),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
