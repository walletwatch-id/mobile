import 'package:flutter/material.dart';

class QuizClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height / 1.1);
    path.cubicTo(size.width / 1.8, (size.height / .9), size.width / 2,
        size.height * .75, size.width * 1.02, size.height * 0.95);
    path.lineTo(size.width, size.height / 1.5);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}