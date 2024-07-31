import 'package:flutter/material.dart';

class EllipsePainter extends CustomPainter {
  final Color timerColor;
  final int totalTime;
  final int remainingTime;

  EllipsePainter({
   required this.timerColor,
   required this.totalTime,
   required this.remainingTime,
});

  @override
  void paint(Canvas canvas, Size size) {
    Paint ellipsePaint = Paint()
      ..color = timerColor
      ..style = PaintingStyle.fill;

    double ellipseX = 46; // X position of the ellipse
    double ellipseY = 23; // Y position of the ellipse
    double ellipseWidth = 6; // Width of the ellipse
    double ellipseHeight = 6; // Height of the ellipse
    double ellipseDiameter = 6;

    canvas.drawCircle(
      Offset(ellipseX, ellipseY),
      ellipseDiameter / 2,
      ellipsePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}



// void paint(Canvas canvas, Size size){
//   Paint ellipsePaint = Paint()
//     ..color = timerColor
//     ..style = PaintingStyle.fill;
//
//   double radius = size.width / 2;
//   Offset center = Offset(size.width / 2, size.height / 2);
//
//   double ellipseX = center.dx + radius * 0.3;
//   double ellipseY = center.dy - radius * 0.35;
//
//   canvas.drawCircle(Offset(ellipseX, ellipseY), 3, ellipsePaint);