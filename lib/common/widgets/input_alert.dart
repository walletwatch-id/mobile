import 'package:flutter/material.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/widgets/custom_text_field.dart';

class InputAlert extends StatefulWidget {
  final String title;
  final String label;
  final String hint;
  final bool visible;
  final String submitText;
  final List<Color> colors;
  final VoidCallback onDismiss;
  final VoidCallback onSubmit;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final int? maxLength;
  const InputAlert(
      {super.key,
      required this.title,
      required this.label,
      required this.hint,
      this.keyboardType,
      required this.visible,
      this.colors = const [
        Color(0xFF3CEAC1),
        Color(0xFF00C0DA),
        Color(0xFF00C0DA)
      ],
      this.submitText = 'Submit',
      required this.onDismiss,
      required this.onSubmit,
      required this.controller,
      this.maxLength});

  @override
  State<InputAlert> createState() => _InputAlertState();
}

class _InputAlertState extends State<InputAlert> {
  @override
  void didUpdateWidget(covariant InputAlert oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible != oldWidget.visible) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (MediaQuery.of(context).viewInsets.bottom == 0.0) {
              widget.controller.clear();
              widget.onDismiss();
            }
          },
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              content: GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * .1),
                  decoration: BoxDecoration(
                      color: backColor,
                      borderRadius: BorderRadius.circular(16)),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(widget.title,
                                  style: AppFontStyle.boldText.copyWith(
                                      color:  Colors.black,
                                      fontSize: 24,
                                      height: 1.4)),
                            ),
                            const SizedBox(height: 14.0),
                            Text(widget.label,
                                style: AppFontStyle.authLabelText.copyWith(
                                    color:  Colors.black)),
                            CustomTextField(
                              controller: widget.controller,
                              hintText: widget.hint,
                              obscureText: false,
                              keyboardType: widget.keyboardType ?? TextInputType.name,
                              color: subColor,
                              // maxLength: widget.maxLength,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                widget.onSubmit();
                              },
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                padding:
                                    WidgetStateProperty.all(EdgeInsets.zero),
                              ),
                              child: Container(
                                height: 42.0,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: widget.colors,
                                    stops: const [0.0, 0.7, 1.0],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.submitText,
                                    style: AppFontStyle.boldText.copyWith(
                                        color: Colors.white,
                                        height: 1.4,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
