import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 287,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF264CEC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        child: Text(
          'Boshlash',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
