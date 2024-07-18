import 'package:flutter/material.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';

class ResultDialog extends StatefulWidget {
  final String title;
  final String message;
  final List<Color> colors;
  final bool visible;
  final String dismissText;
  final VoidCallback onDismiss;
  const ResultDialog(
      {super.key,
      required this.title,
      required this.message,
      required this.colors,
      required this.visible,
      this.dismissText = 'OK',
      required this.onDismiss});

  @override
  State<ResultDialog> createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> {
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
              buttonPadding: EdgeInsets.zero,
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
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            // QrImageView(
                            //   data: widget.message,
                            //   version: QrVersions.auto,
                            //   size: 200,
                            //   embeddedImage: const AssetImage(
                            //       'assets/images/embedded.png'),
                            //   embeddedImageStyle: const QrEmbeddedImageStyle(
                            //     size: Size(80, 80),
                            //   ),
                            // ),
                            const SizedBox(height: 4),
                            ElevatedButton(
                              onPressed: () {
                                widget.onDismiss();
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
