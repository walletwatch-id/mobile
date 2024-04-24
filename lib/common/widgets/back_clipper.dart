import 'package:flutter/material.dart';

class BackClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height / 2);
    path.cubicTo(
      size.width * 0.1, // First control point X
      0, // First control point Y
      size.width * 0.9, // Second control point X
      0, // Second control point Y
      size.width, // Ending point X
      size.height / 2, // Ending point Y
    );
    path.cubicTo(
      size.width * 0.9, // Third control point X
      size.height, // Third control point Y
      size.width * 0.1, // Fourth control point X
      size.height, // Fourth control point Y
      0, // Ending point X
      size.height / 2, // Ending point Y
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
