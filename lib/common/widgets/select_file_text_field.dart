import 'package:flutter/material.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';
import 'package:wallet_watch/common/widgets/custom_text_field.dart';

class SelectFileTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final VoidCallback onPressed;

  const SelectFileTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(labelText,
                style:
                    AppFontStyle.authLabelText.copyWith(color: Colors.black)),
            const SizedBox(
              height: 6,
            ),
            CustomTextField(
              controller: controller,
              hintText: hintText,
              obscureText: false,
              readOnly: true,
              keyboardType: TextInputType.text,
            ),
          ],
        ),
        Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: onPressed,
            ))
      ],
    );
  }
}
