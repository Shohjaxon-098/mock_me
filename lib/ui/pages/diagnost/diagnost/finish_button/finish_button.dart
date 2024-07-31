import 'package:flutter/material.dart';

class FinishButton extends StatelessWidget {
  final VoidCallback onPressed;
  const FinishButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      height: 47,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFF4617E8),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1e000000),
              offset: Offset(0, 6),
              blurRadius: 12,
            ),
          ],
        ),
        child: Center(
          child: TextButton(
            onPressed: onPressed,
            child: const Text(
              'Testni yakunlash',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'Inter-Medium',
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// SizedBox(
// width: 327,
// height: 47,
// child: Stack(
// children: [
// Positioned(
// left: 0,
// width: 327,
// top: 0,
// child: SizedBox(
// width: 327,
// child: DecoratedBox(
// decoration: BoxDecoration(
// color: const Color(0xFF4617E8),
// borderRadius: BorderRadius.circular(8),
// boxShadow: const [
// BoxShadow(
// color: Color(0x1e000000),
// offset: Offset(0, 6),
// blurRadius: 12,
// )
// ]
// ),
// child: Center(
// child: TextButton(
// onPressed: onPressed,
// child: const Text(
// 'Testni yakunlash',
// style: TextStyle(
// fontSize: 16,
// color: Colors.white,
// fontFamily: 'Inter-Medium',
// ),
// ),
// ),
// ),
// ),
// ),
// )
// ],
// ),
// );