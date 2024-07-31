

import 'package:flutter/material.dart';


class StepPainter extends CustomPainter {
  final Offset p1;
  final Offset p2;
  final Paint stepPaint;
  final bool isActive;

  StepPainter({
    required this.p1,
    required this.p2,
    required this.stepPaint,
    this.isActive = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(p1, p2, stepPaint);
  }

  @override
  bool shouldRepaint(StepPainter oldDelegate) {
    return oldDelegate.p1 != p1 ||
        oldDelegate.p2 != p2 ||
        oldDelegate.isActive != isActive;
  }

  @override
  bool shouldRebuildSemantics(StepPainter oldDelegate) => false;
}

// class TrianglePainter extends CustomPainter {
//   final double remainingSeconds;
//   final double totalSeconds;
//   final Color color;
//
//   TrianglePainter({required this.remainingSeconds, required this.totalSeconds, required this.color});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;
//
//     double width = size.width;
//     double height = size.height;
//
//     double progress = (remainingSeconds / totalSeconds) * 360;
//
//     // Triangle vertices
//     Offset center = Offset(width / 2, height / 2);
//     double radius = width / 2;
//
//     double angle = -90 * (3.14 / 180) + (progress * (3.14 / 180));
//
//     Offset p1 = center;
//     Offset p2 = Offset(center.dx + radius * cos(angle - 3.14 / 6), center.dy + radius * sin(angle - 3.14 / 6));
//     Offset p3 = Offset(center.dx + radius * cos(angle + 3.14 / 6), center.dy + radius * sin(angle + 3.14 / 6));
//
//     Path path = Path();
//     path.moveTo(p1.dx, p1.dy);
//     path.lineTo(p2.dx, p2.dy);
//     path.lineTo(p3.dx, p3.dy);
//     path.close();
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
//
// }