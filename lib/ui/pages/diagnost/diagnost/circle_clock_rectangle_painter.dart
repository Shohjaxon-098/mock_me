import 'package:flutter/material.dart';

class CircleClockRectanglePainter extends CustomPainter {
  final Color timerColor;
  final int totalTime;
  final int remainingTime;

  CircleClockRectanglePainter({
    required this.timerColor,
    required this.totalTime,
    required this.remainingTime,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint()
      ..color = timerColor.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    double circleRadius = size.width * 0.5;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      circleRadius,
      circlePaint,
    );

    Paint rectanglePaint = Paint()
      ..color = timerColor.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    double rectWidth = size.width * 0.3;
    double rectHeight = size.height * 0.15;

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: rectWidth,
        height: rectHeight,
      ),
      rectanglePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}