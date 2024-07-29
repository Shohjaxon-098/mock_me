import 'package:talaba_uz/utils/tools/file_important.dart';

class OliygohlarWidget extends StatelessWidget {
  const OliygohlarWidget({super.key, this.text, this.image});
  final String? text;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * 0.43,
      height: height(context) * 0.101,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image!,
            width: 32,
            height: 32,
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Text(
              text!,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
