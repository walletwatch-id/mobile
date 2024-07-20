import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/data/provider.dart';
import 'package:walletwatch_mobile/common/data/period.dart';
import 'package:walletwatch_mobile/common/enum/transaction_field_state.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/widgets/custom_text_field.dart';
import 'package:walletwatch_mobile/common/widgets/dynamic_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TransactionFieldState state;
  final VoidCallback? callback;
  const TransactionTextField(
      {super.key,
      required this.label,
      required this.hint,
      required this.controller,
      required this.state,
      this.callback});

  @override
  State<TransactionTextField> createState() => _TransactionTextFieldState();
}

class _TransactionTextFieldState extends State<TransactionTextField> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Text(widget.label,
            style: AppFontStyle.authLabelText
                .copyWith(color: primaryColor, fontSize: 22.sp)),
        SizedBox(height: 8.h),
        if (widget.state == TransactionFieldState.period)
          DropdownButtonHideUnderline(
            child: DropdownButton2<Period>(
              customButton: Container(
                height: 55.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: lightColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Stack(
                    children: [
                      DynamicText(
                          text: widget.controller.text.isNotEmpty
                              ? "${periodList.firstWhere((element) => element.id == widget.controller.text).value} Bulan"
                              : widget.hint,
                          textStyle: AppFontStyle.homeCardTitleText,
                          textColor: darkColor),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: 12.w,
                        child: Icon(
                          _isFocused ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                          color: darkColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              isExpanded: true,
              dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                      color: lightColor,
                      borderRadius: BorderRadius.circular(20.r))),
              items: periodList
                  .map((item) => DropdownMenuItem<Period>(
                        value: item,
                        child: Text(
                          "${item.value} Bulan",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (Period? value) {
                setState(() {
                  widget.controller.text = value?.id ?? '';
                  _isFocused = false;
                });
              },
              onMenuStateChange: (isOpen) => {
                setState(() {
                  _isFocused = isOpen;
                })
              },
              buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                height: 40.h,
                width: 140.w,
              ),

              menuItemStyleData: MenuItemStyleData(
                height: 40.h,
              ),
            ),
          )
          else if (widget.state == TransactionFieldState.provider)
          DropdownButtonHideUnderline(
            child: DropdownButton2<Paylater>(
              customButton: Container(
                height: 70.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: lightColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
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
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 95.w, vertical: 8.h),
                      child: widget.controller.text.isNotEmpty
                          ? getStateImage(paylaterList
                              .firstWhere((element) =>
                                  element.id == widget.controller.text)
                              .state)
                          : DynamicText(
                              text: widget.hint,
                              textStyle: AppFontStyle.homeCardTitleText,
                              textColor: darkColor),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 12.w,
                      child: Icon(
                        _isFocused
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: darkColor,
                      ),
                    )
                  ],
                ),
              ),
              isExpanded: true,
              dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                      color: lightColor,
                      borderRadius: BorderRadius.circular(20.r))),
              items: paylaterList
                  .map((item) => DropdownMenuItem<Paylater>(
                        value: item,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: getStateImage(item.state)),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (Paylater? value) {
                setState(() {
                  widget.controller.text = value?.id ?? '';
                  _isFocused = false;
                });
              },
              onMenuStateChange: (isOpen) => {
                setState(() {
                  _isFocused = isOpen;
                })
              },
              buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                height: 60.h,
                width: 140.w,
              ),
              menuItemStyleData: MenuItemStyleData(
                height: 60.h,
              ),
            ),
          )
        else if (!_isFocused)
          Container(
            height: 55.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: lightColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.r),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: MaterialButton(
                onPressed: () {
                  if (widget.callback != null) {
                    widget.callback!();
                  } else {
                    setState(() {
                      _isFocused = true;
                    });
                    _focusNode.requestFocus();
                  }
                },
                child: DynamicText(
                    text: (widget.controller.text.isNotEmpty)
                        ? widget.state == TransactionFieldState.firstInstallmentDateTime ? widget.controller.text : formatCurrency(
                            double.tryParse(widget.controller.text) ?? 0)
                        : widget.hint,
                    textStyle: AppFontStyle.homeCardTitleText,
                    textColor: darkColor),
              ),
            ),
          )
        else if (_isFocused)
          if (widget.state == TransactionFieldState.installment)
            CustomTextField(
              height: 55,
              fontSize: 18,
              controller: widget.controller,
              hintText: "Cicilan..",
              obscureText: false,
              keyboardType: TextInputType.number,
              color: secondaryColor,
              focusNode: _focusNode,
              onFocusChange: (isFocused) {
                if (!isFocused) {
                  setState(() {
                    _isFocused = false;
                  });
                }
              },
              startIcon: Icon(
                FontAwesomeIcons.rupiahSign,
                size: 20.sp,
                color: secondaryColor,
              ),
            )
          else if (widget.state == TransactionFieldState.total)
            CustomTextField(
              height: 55,
              fontSize: 18,
              controller: widget.controller,
              hintText: "Total..",
              obscureText: false,
              keyboardType: TextInputType.number,
              color: secondaryColor,
              focusNode: _focusNode,
              onFocusChange: (isFocused) {
                if (!isFocused) {
                  setState(() {
                    _isFocused = false;
                  });
                }
              },
              startIcon: Icon(
                FontAwesomeIcons.rupiahSign,
                size: 20.sp,
                color: secondaryColor,
              ),
            )

          else
            CustomTextField(
              hintText: widget.hint,
              backColor: lightColor,
              color: darkColor,
              keyboardType: TextInputType.text,
              readOnly: false,
              obscureText: false,
              controller: TextEditingController(),
              startIcon: null,
            ),
      ],
    );
  }
}
