import 'package:flutter/material.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';

class ConfirmDialog extends StatefulWidget {
  final String title;
  final String message;
  final List<Color> colors;
  final bool reverseColor;
  final bool visible;
  final String confirmText;
  final String dismissText;
  final VoidCallback onConfirm;
  final VoidCallback onDismiss;
  const ConfirmDialog(
      {super.key,
      required this.title,
      required this.message,
      required this.colors,
      this.reverseColor = false,
      required this.visible,
      this.confirmText = 'Setuju',
      this.dismissText = 'Batal',
      required this.onConfirm,
      required this.onDismiss});

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (MediaQuery.of(context).viewInsets.bottom == 0.0) {
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
                      bottom: MediaQuery.of(context).size.height * .3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(widget.title,
                                style: AppFontStyle.dialogTitleText),
                            const SizedBox(height: 14.0),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                widget.message,
                                style: AppFontStyle.dialogText,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                widget.onConfirm();
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                              ),
                              child: Container(
                                height: 42.0,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: widget.reverseColor ? const  [
                                  Color(0xFFED254E),
                                  Color(0xFF6D213C),
                                ] : widget.colors,
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.confirmText,
                                    style: AppFontStyle.dialogButtonText,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            ElevatedButton(
                              onPressed: () {
                                widget.onDismiss();
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                              ),
                              child: Container(
                                height: 42.0,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: widget.reverseColor ? widget.colors : const  [
                                  Color(0xFFED254E),
                                  Color(0xFF6D213C),
                                ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.dismissText,
                                    style: AppFontStyle.dialogButtonText,
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
