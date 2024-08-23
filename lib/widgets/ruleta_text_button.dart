import 'package:flutter/material.dart';

class RuletaTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final TextStyle textStyle;
  final double width;

  const RuletaTextButton(
      {super.key,
      required this.width,
      required this.text,
      required this.onTap,
      required this.color,
      required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 5),
          borderRadius: BorderRadius.circular(20.0),
          color: color,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        width: width,
        child: Text(
          text,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
