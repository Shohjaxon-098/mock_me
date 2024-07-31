import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'time_painter.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<StatefulWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? timer;
  final int totalTime = 3 * 3600; // 3 hours in seconds
  int remainingTime = 3 * 3600;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Future<void> saveRemainingTime(int remainingTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('remainingTime', remainingTime);
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
          saveRemainingTime(remainingTime);
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Color getTimerColor() {
    if (remainingTime <= 600) {
      return const Color(0xFFEA1313);
    } else if (remainingTime <= 2 * 3600 && remainingTime > 1 * 3600) {
      return const Color(0xFF1E1E1E);
    } else {
      return const Color(0xFF1E1E1E);
    }
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return "${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${secs.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEEFC),
      body: Center(
        child: SizedBox(
          width: 152,
          height: 34,
          child: CustomPaint(
            painter: TimePainter(
              timerColor: getTimerColor(),
              totalTime: totalTime,
              remainingTime: remainingTime ,

            ),
          ),
        ),
      ),
    );
  }
}








