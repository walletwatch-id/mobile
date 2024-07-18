import 'package:flutter/material.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';

class HomeMenuItem extends StatefulWidget {
  final String title;
  final List<Color> colors;
  final VoidCallback onClick;
  const HomeMenuItem(
      {super.key,
      required this.title,
      required this.colors,
      required this.onClick});

  @override
  State<HomeMenuItem> createState() => _HomeMenuItemState();
}

class _HomeMenuItemState extends State<HomeMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: widget.colors,
            stops: const [0.0, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
         // border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: MaterialButton(
              onPressed: widget.onClick,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style:
                        AppFontStyle.homeItemText.copyWith(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
