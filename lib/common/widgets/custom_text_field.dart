import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final double height;
  final double fontSize;
  final TextInputType keyboardType;
  final bool readOnly;
  final Widget? startIcon;
  final Color? color;
  final Color? backColor;
  final FocusNode? focusNode;
  final Function(bool)? onFocusChange;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.obscureText = false,
      this.readOnly = false,
      this.startIcon,
      this.height = 50,
      this.fontSize = 18,
      this.onFocusChange,
      this.color,
      this.backColor,
      this.focusNode,
      required this.keyboardType});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  late bool _isVisible = !widget.obscureText;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
      widget.onFocusChange?.call(_isFocused);
    });
  }

  @override
  Widget build(BuildContext context) {
    const double radius = 16;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: widget.height.h,
        width: double.maxFinite,
        color: widget.backColor ?? const Color(0xFFFFFFFF).withOpacity(0.7),
        child: TextField(
          showCursor: true,
          cursorColor: primaryColor,
          obscureText: !_isVisible && widget.obscureText,
          keyboardType: widget.keyboardType,
          readOnly: widget.readOnly,
          focusNode: _focusNode,
          controller: widget.controller,
          style: AppFontStyle.customInputText.copyWith(
              color: widget.color ?? Colors.black,
              height: 1.9.h,
              fontSize: widget.fontSize.sp),
          decoration: InputDecoration(
            prefixIcon: widget.startIcon,
            suffixIcon: Visibility(
                visible: widget.keyboardType == TextInputType.visiblePassword,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    child: Icon(
                      _isVisible ? Icons.visibility_off : Icons.visibility,
                      color: widget.color,
                    ))),
            contentPadding: EdgeInsets.only(left: 18.w, right: 18.w),
            hintText: widget.hintText,
            hintStyle: AppFontStyle.authHintText.copyWith(
                color: widget.color?.withOpacity(.7),
                height: 1.7.h,
                fontSize: (widget.fontSize - 2).sp),
            border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: widget.color ?? const Color(0xFF9EA3A2)),
                borderRadius: BorderRadius.circular(radius)),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: widget.color ?? const Color(0xFF9EA3A2)),
                borderRadius: BorderRadius.circular(radius)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.color ?? const Color(0xFF9EA3A2), width: 2.w),
                borderRadius: BorderRadius.circular(radius)),
          ),
        ),
      ),
    );
  }
}
