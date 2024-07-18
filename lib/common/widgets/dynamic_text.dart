import 'package:flutter/material.dart';

class DynamicText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color textColor;

  const DynamicText({super.key, required this.text, required this.textStyle, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Measure the width of the text
        TextPainter textPainter = TextPainter(
          text: TextSpan(text: text, style: textStyle.copyWith(color: textColor)),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        // Check if the text width exceeds the available width
        if (textPainter.width > constraints.maxWidth) {
          // Use ListView when text width exceeds the parent width
          return ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            children: [
              Center(
                child: Text(
                  text,
                  style: textStyle.copyWith(color: textColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        } else {
          // Use Center when text width does not exceed the parent width
          return Center(
            child: Text(
              text,
              style: textStyle.copyWith(color: textColor),
              textAlign: TextAlign.center,
            ),
          );
        }
      },
    );
  }
}
