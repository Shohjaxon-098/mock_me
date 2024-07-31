import 'package:flutter/material.dart';

class CustomButtonPattern extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomButtonPattern({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF264CEB),
          minimumSize: Size(327, 47),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Bosh sahifaga qaytish',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFFFFFFFF),
          ),
          textAlign: TextAlign.center,
        ),
    );
  }
}
