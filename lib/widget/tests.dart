// ignore_for_file: prefer_const_constructors

import 'package:talaba_uz/utils/tools/file_important.dart';

class TestWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const TestWidget(
    this.subject,
    this.onPressed,
  );
  final String subject;
  final Function? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 5, spreadRadius: 0.1, color: Colors.grey.shade300),
        ],
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
                color: Color.fromARGB(15, 38, 78, 236),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(90),
                    topRight: Radius.circular(90),
                    bottomRight: Radius.circular(90))),
          ),
          Container(
            margin: const EdgeInsets.only(top: 102, left: 125),
            alignment: Alignment.bottomRight,
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(75, 38, 78, 236),
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                    bottomRight: Radius.circular(100))),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                subject,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 4.3 * devisePixel(context),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Savollar",
                      style: TextStyle(
                        fontSize: 4 * devisePixel(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "90 ta",
                      style: TextStyle(
                        fontSize: 4 * devisePixel(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vaqt",
                      style: TextStyle(
                        fontSize: 4 * devisePixel(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "3 soat",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 4 * devisePixel(context),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: width(context) * 0.26,
                height: 24,
                child: WElevatedButton(
                  onPressed: onPressed,
                  text: Text(
                    "Boshlash",
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 4 * devisePixel(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
