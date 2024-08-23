import 'dart:math';
import 'package:flutter/material.dart';

const double TEXT_OUTLINE_SIZE = 1.2;

class FortuneWheel extends StatefulWidget {
  final double divisionStroke;
  final double outlineStroke;
  final double size;
  final double radius;
  final Color outlineColor;
  final Color divisionColor;
  final List<WheelItem> items;
  final AnimationController? controller;
  final Animation<double>? animation;

  const FortuneWheel(
      {Key? key,
      required this.items,
      required this.size,
      required this.radius,
      required this.outlineColor,
      required this.outlineStroke,
      required this.divisionColor,
      required this.divisionStroke,
      this.controller,
      this.animation})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FortuneWheelState();
}

class _FortuneWheelState extends State<FortuneWheel>
    with SingleTickerProviderStateMixin {
  late AnimationController? controller;
  late Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    animation = widget.animation;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: WheelPainter(
            radius: widget.radius,
            divisionStroke: widget.divisionStroke,
            items: widget.items,
            outlineColor: widget.outlineColor,
            divisionColor: widget.divisionColor,
            outlineStroke: widget.outlineStroke,
            angle: animation?.value),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class WheelItem {
  final String text;
  final Color color;

  WheelItem(this.text, this.color);
}

class WheelPainter extends CustomPainter {
  final double divisionStroke;
  final double outlineStroke;
  final double radius;
  final Color divisionColor;
  final Color outlineColor;
  final List<WheelItem> items;
  final double? angle;

  WheelPainter(
      {required this.items,
      required this.radius,
      required this.outlineColor,
      required this.outlineStroke,
      required this.divisionColor,
      required this.divisionStroke,
      required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(angle ?? 0.0); // Apply the rotation to the canvas
    canvas.translate(-size.width / 2, -size.height / 2);

    Paint paint = Paint()..style = PaintingStyle.fill;

    double divisionAngle = 2 * pi / items.length;
    double textRadius = radius * 0.7;

    // Draw division fills
    for (int i = 0; i < items.length; i++) {
      final item = items[i];

      // Set the color for the current item
      paint.color = item.color;

      // Calculate the start and sweep angles
      double startAngle = divisionAngle * i;
      double sweepAngle = divisionAngle;

      // Draw the arc for the current item
      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // Calculate the angle for the text
      double textAngle =
          (2 * pi / items.length) * i + (2 * pi / items.length) / 2 - pi / 2;

      // Calculate the position where the text should be drawn
      double x =
          (size.width / 2) + (textRadius - 20) * -cos(textAngle - pi / 2);
      double y =
          (size.height / 2) + (textRadius - 20) * -sin(textAngle - pi / 2);

      // Prepare the text painter
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: item.text,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: 'LuckiestGuy',
              shadows: [
                Shadow(
                  // bottomLeft
                  offset: Offset(-TEXT_OUTLINE_SIZE, -TEXT_OUTLINE_SIZE),
                  color: Colors.black,
                ),
                Shadow(
                  // bottomRight
                  offset: Offset(TEXT_OUTLINE_SIZE, -TEXT_OUTLINE_SIZE),
                  color: Colors.black,
                ),
                Shadow(
                  // topRight
                  offset: Offset(TEXT_OUTLINE_SIZE, TEXT_OUTLINE_SIZE),
                  color: Colors.black,
                ),
                Shadow(
                  // topLeft
                  offset: Offset(-TEXT_OUTLINE_SIZE, TEXT_OUTLINE_SIZE),
                  color: Colors.black,
                ),
              ]),
        ),
        textDirection: TextDirection.ltr,
      );

      // Layout the text
      textPainter.layout();

      // Save the canvas state before drawing
      canvas.save();
      // Move the canvas to the position where the text will be drawn
      canvas.translate(x, y);
      // Rotate the canvas so the text is angled towards the center of the wheel
      canvas.rotate(textAngle + pi / 2);
      // Draw the text such that its center aligns with the line from the center of the wheel
      textPainter.paint(
          canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      // Restore the canvas after drawing the text
      canvas.restore();
    }

    // Draw divisions outlines
    for (int i = 0; i < items.length; i++) {
      // Calculate the start and sweep angles
      double startAngle = divisionAngle * i;

      // Draw division outlines
      Paint linePaint = Paint()
        ..color = divisionColor
        ..strokeWidth = divisionStroke
        ..style = PaintingStyle.stroke;

      // The line starts from the center and goes to the edge of the circle at the start angle
      Offset start = Offset(size.width / 2, size.height / 2);
      Offset end = Offset(size.width / 2 + cos(startAngle) * radius,
          size.height / 2 + sin(startAngle) * radius);
      canvas.drawLine(start, end, linePaint);
    }

    //Draw inner circle
    paint
      ..color = divisionColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), radius * 0.08, paint);

    // Draw the outer division of the wheel
    paint
      ..color = divisionColor
      ..strokeWidth = outlineStroke
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);

    // Draw the outline of the wheel
    paint
      ..color = outlineColor
      ..strokeWidth = outlineStroke
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), radius + outlineStroke, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
