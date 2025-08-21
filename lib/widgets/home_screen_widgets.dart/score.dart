import 'package:autism_ai_test/constants/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// This widget displays visually to the user the score they get
/// It uses a partial circle to represent the score as a fraction of 100
/// The fraction is represented as a percentage in the center of the circle
class PartialCircle extends StatelessWidget {
  final double fraction;
  final double size;
  final Color color;

  const PartialCircle({
    super.key,
    required this.fraction,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          '${(fraction * 100).toInt()}%',
          style: TextStyle(
            fontSize: 25,
            color: ColorTheme.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        CustomPaint(
          size: Size(size, size),
          painter: _PartialCirclePainter(fraction, color),
        ),
      ],
    );
  }
}

class _PartialCirclePainter extends CustomPainter {
  final double fraction;
  final Color color;

  _PartialCirclePainter(this.fraction, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawArc(
      rect,
      -pi / 2, // start at top
      2 * pi * fraction,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} // EOF score.dart
