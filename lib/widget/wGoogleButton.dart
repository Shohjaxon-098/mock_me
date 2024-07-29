// ignore_for_file: file_names, prefer_const_constructors

import 'package:talaba_uz/utils/tools/file_important.dart';

class WGoogleButton extends StatelessWidget {
  const WGoogleButton({super.key, this.text, this.onPressed});
  final String? text;
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.8,
      height: height(context) * 0.052,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/google.svg",
              width: width(context) / 9,
            ),
            Text(
              text!,
              style: TextStyle(
                color: Color(0xff0C092A),
                fontWeight: FontWeight.w500,
                fontSize: 6 * devisePixel(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
