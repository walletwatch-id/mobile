import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:walletwatch_mobile/common/enum/notification_state.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';

class NotificationItem extends StatefulWidget {
  final NotificationState state;
  final String content;
  const NotificationItem(
      {super.key, required this.state, required this.content});

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  late Icon _icon;
  late Color _contentColor;
  late Color _color;
  final double _iconSize = 40.w;

  @override
  void initState() {
    super.initState();

    switch (widget.state) {
      case NotificationState.transaction:
        _icon = Icon(
          FontAwesomeIcons.moneyBillTransfer,
          color: darkColor,
          size: _iconSize,
        );
        _color = transactionColor;
        _contentColor = darkColor;
        break;
      case NotificationState.warning:
        _icon = Icon(
          Icons.warning,
          color: warningIconColor,
          size: _iconSize,
        );
        _color = warningColor;
        _contentColor = darkColor;
        break;
      case NotificationState.danger:
        _icon = Icon(
          Icons.error,
          color: lightColor,
          size: _iconSize,
        );
        _color = dangerColor;
        _contentColor = lightColor;
        break;
      case NotificationState.personal:
        _icon = Icon(
          Icons.check_circle,
          color: darkColor,
          size: _iconSize,
        );
        _color = transactionColor;
        _contentColor = darkColor;
        break;
      case NotificationState.safe:
        _icon = Icon(
          Icons.check_circle,
          color: lightColor,
          size: _iconSize,
        );
        _color = safeColor;
        _contentColor = lightColor;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: _color,
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
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {});
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              children: [
                _icon,
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: Text(widget.content,
                      style: AppFontStyle.homeSubTitleText
                          .copyWith(color: _contentColor, height: 1.2.h)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
