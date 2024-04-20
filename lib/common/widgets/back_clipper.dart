import 'package:flutter/material.dart';

class BackClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height / 1.3);
    path.cubicTo(size.width / 2.2, (size.height / 2), size.width / 1.4,
        size.height * 1.4, size.width * 1.42, size.height * .35);
    path.lineTo(size.width, size.height / 1.5);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}