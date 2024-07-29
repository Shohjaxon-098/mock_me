// ignore_for_file: file_names

import 'package:talaba_uz/utils/tools/file_important.dart';

class WElevatedTransparentButton extends StatelessWidget {
  const WElevatedTransparentButton(
      {super.key, this.text, this.onPressed, this.buttonBackground});
  final String? text;
  final Color? buttonBackground;
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.8,
      height: height(context) * 0.051,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: buttonBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text!,
          style: TextStyle(
            color: whiteColor,
            fontSize: 5 * devisePixel(context),
          ),
        ),
      ),
    );
  }
}
