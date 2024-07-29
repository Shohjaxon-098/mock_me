import 'package:flutter/material.dart';

class CombinedPainter extends CustomPainter {
  final Color timerColor;
  final int totalTime;
  final int remainingTime;

  CombinedPainter({
    required this.timerColor,
    required this.totalTime,
    required this.remainingTime,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Circle
    Paint circlePaint = Paint()
      ..color = timerColor.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    double circleRadius = size.width * 0.5;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      circleRadius,
      circlePaint,
    );

    // Rectangle
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

    // Ellipse
    Paint ellipsePaint = Paint()
      ..color = timerColor
      ..style = PaintingStyle.fill;

    double ellipseX = size.width * 0.3;
    double ellipseY = size.height * 0.3;
    double ellipseWidth = 6;
    double ellipseHeight = 6;

    canvas.drawOval(
      Rect.fromLTWH(ellipseX, ellipseY, ellipseWidth, ellipseHeight),
      ellipsePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}