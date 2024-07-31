import 'dart:math';

import 'package:flutter/material.dart';

class TimerPainter extends CustomPainter {
  final Color timerColor;
  final int totalTime;
  final int remainingTime;

  TimerPainter({
    required this.timerColor,
    required this.totalTime,
    required this.remainingTime,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate the angle for the remaining time
    double remainingAngle = (remainingTime / totalTime) * 360;

    // Draw the outer circle
    Paint outerCirclePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..color = Colors.grey;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2 - 20,
      outerCirclePaint,
    );

    // Draw the timer arc
    Paint timerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..color = timerColor;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width - 40,
        height: size.height - 40,
      ),
      -pi / 2,
      remainingAngle * pi / 180,
      false,
      timerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}