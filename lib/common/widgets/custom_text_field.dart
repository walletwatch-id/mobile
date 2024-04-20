import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool readOnly;
  final Widget? startIcon;
  final Color? color;
  final Color? backColor;
  final VoidCallback? onFocus;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.obscureText = false,
      this.readOnly = false,
      this.startIcon,
      this.onFocus,
      this.color,
      this.backColor,
      required this.keyboardType});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
      if (_isFocused) {
        widget.onFocus!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const double radius = 16;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: 50.h,
        width: double.maxFinite,
        color: widget.backColor ?? const Color(0xFFFFFFFF).withOpacity(0.7),
        child: TextField(
          showCursor: true,
          cursorColor: widget.color ?? Colors.black,
          obscureText: !_isVisible && widget.obscureText,
          keyboardType: widget.keyboardType,
          readOnly: widget.readOnly,
          focusNode: _focusNode,
          controller: widget.controller,
          style: AppFontStyle.customInputText
              .copyWith(color: widget.color ?? Colors.black),
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
                    child: Icon(_isVisible ? Icons.visibility_off : Icons.visibility, color: widget.color,))),
            contentPadding: EdgeInsets.only(left: 18.w, right: 18.w),
            hintText: widget.hintText,
            hintStyle: AppFontStyle.authHintText
                .copyWith(color: widget.color),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.color ??
                        const Color(0xFF9EA3A2)),
                borderRadius: BorderRadius.circular(radius)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.color ??
                        const Color(0xFF9EA3A2)),
                borderRadius: BorderRadius.circular(radius)),
            focusedBorder: OutlineInputBorder(
              
                borderSide:
                    BorderSide(color: widget.color ?? const Color(0xFF9EA3A2), width: 2),
                borderRadius: BorderRadius.circular(radius)),
          ),
        ),
      ),
    );
  }
}
