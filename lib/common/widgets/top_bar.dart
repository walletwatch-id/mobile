import 'package:flutter/material.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';
import 'package:wallet_watch/common/utils/transtition_fade.dart';

class TopBar extends StatefulWidget {
  final String title;
  final List<Color> colors;
  final VoidCallback settingAction;
  final VoidCallback? popAction;
  const TopBar(
      {super.key,
      this.title = "",
      required this.colors,
      required this.settingAction,
      this.popAction});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: widget.colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 30, left: 16, right: 20),
              alignment: Alignment.topCenter,
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (widget.popAction != null) {
                        widget.popAction!();
                      }
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/icons/backs.png',
                      color: Colors.white,
                      width: 28,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: MediaQuery.of(context).size.width * 0.68,
                    child: Text(
                        widget.title.length > 24
                            ? '${widget.title.substring(0, 24)}...'
                            : widget.title,
                        style: AppFontStyle.topBarText),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.popAction != null) {
                        widget.popAction!();
                      }
                      // Navigator.of(context).pushAndRemoveUntil(
                      //     TransitionFade(child: const Home()),
                      //     (route) => false);
                    },
                    child: Image.asset(
                      'assets/icons/home.png',
                      color: Colors.white,
                      width: 28,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            )));
  }
}
