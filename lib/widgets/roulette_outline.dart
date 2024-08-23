import 'package:flutter/material.dart';

class RouletteOutline extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xff000000)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(125, 125), 175, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
