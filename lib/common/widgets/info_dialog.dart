import 'package:flutter/material.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';

class InfoDialog extends StatefulWidget {
  final String title;
  final String message;
  final List<Color> colors;
  final bool visible;
  final String dismissText;
  final VoidCallback onDismiss;
  const InfoDialog(
      {super.key,
      required this.title,
      required this.message,
      required this.colors,
      required this.visible,
      this.dismissText = 'OK',
      required this.onDismiss});

  @override
  State<InfoDialog> createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
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
              insetPadding: const EdgeInsets.all(16),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              content: GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * .1),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 8),
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
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
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
                                    colors: widget.colors,
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
