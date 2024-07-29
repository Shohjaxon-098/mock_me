// ignore_for_file: file_names

import 'package:talaba_uz/utils/tools/file_important.dart';

class WElevatedButton extends StatelessWidget {
  const WElevatedButton({super.key, this.text, this.onPressed});
  final Widget? text;
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.792,
      height: height(context) * 0.051,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: blueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Center(child: text),
      ),
    );
  }
}
