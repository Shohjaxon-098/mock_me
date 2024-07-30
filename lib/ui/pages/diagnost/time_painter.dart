import 'package:flutter/material.dart';

class TimePainter extends CustomPainter {
  final Color timerColor;
  final int totalTime;
  final int remainingTime;

  TimePainter({
    required this.timerColor,
    required this.totalTime,
    required this.remainingTime,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    //Calculate the remaining time in hours, minutes, and seconds
    int hours = remainingTime ~/ 3600;
    int minutes = (remainingTime % 3600) ~/ 60;
    int seconds = remainingTime % 60;

    // Format the time as HH : MM : SS
    String timeString =
        "${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}";

    // Text style for hours and minutes
    TextSpan textSpan = TextSpan(
        style: const TextStyle(
          fontSize: 24,
          color: Color(0xFF1E1E1E),
          fontFamily: 'Inter-Medium'
        ),
        children: [
          TextSpan(text: "${hours.toString().padLeft(2, '0')} : "),
          TextSpan(text: minutes.toString().padLeft(2, '0')),
          TextSpan(
            text: " : ",
            style: TextStyle(color: timerColor),
          ),
          TextSpan(
            text: seconds.toString().padLeft(2, '0'),
            style: TextStyle(color: timerColor),
          )
        ]);

    // TextPainter to paint the text
    TextPainter textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Layout the text
    textPainter.layout();

    // Find the position to draw the text so it is centered
    Offset offset = Offset(
      centerX - textPainter.width / 2,
      centerY - textPainter.height / 2,
    );

    // Draw the text on the canvas
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
