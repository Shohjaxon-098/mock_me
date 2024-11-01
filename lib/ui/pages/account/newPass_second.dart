



// ignore_for_file: file_names

import 'package:talaba_uz/utils/tools/file_important.dart';

// ignore: must_be_immutable
class UpdatePasswordSecond extends StatefulWidget {
  const UpdatePasswordSecond ({
    super.key,
  });

  @override
  State<UpdatePasswordSecond > createState() => _UpdatePasswordSecondState();
}

class _UpdatePasswordSecondState extends State<UpdatePasswordSecond > {
  bool isEmpty = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 41,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: SvgPicture.asset(
              "assets/icons/arrow_back.svg",
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffEFEEFC),
        title: Text(
          'Parolni yangilash',
          style: TextStyle(
            fontSize: 6 * devisePixel(context),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFEFEEFC),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          WidgetTextField(
            readOnly: false,
            onChanged: (value) {
              passwordController.text = value;
              setState(() {
                if (passwordController.toString().isNotEmpty &&
                    passwordController.text.length < 8 &&
                    confirmPasswordController.toString().isEmpty) {
                  isEmpty = false;
                } else {
                  isEmpty = true;
                }
                isEmpty = false;
              });
            },
            obscureText: obscureText,
            headText: "Parolingizni kiriting",
            hintText: "Parol",
            errorText: passwordController.text.isNotEmpty &&
                    passwordController.text.length < 8
                ? 'Kamida 8 ta belgidan iborat bolishi kerak.'
                : null,
            suffixIconConstraints: const BoxConstraints(),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: obscureText
                    ? SvgPicture.asset(
                        "assets/icons/off_eye.svg",
                        width: 25,
                        height: 25,
                        fit: BoxFit.cover,
                      )
                    : SvgPicture.asset(
                        "assets/icons/on_eye.svg",
                        width: 25,
                        height: 25,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            prefixIconConstraints: const BoxConstraints(),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 13, right: 13),
              child: SvgPicture.asset(
                width: 23,
                height: 23,
                fit: BoxFit.cover,
                "assets/icons/lock.svg",
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          WidgetTextField(
            readOnly: false,
            obscureText: obscureText,
            headText: "Parolni tasdiqlash",
            hintText: "Parolni qayta kiriting",
            errorText: confirmPasswordController.text.isNotEmpty &&
                    confirmPasswordController.text != passwordController.text
                ? 'Passwords do not match'
                : null,
            onChanged: (value) {
              confirmPasswordController.text = value;
              setState(() {
                if (confirmPasswordController.toString().isNotEmpty &&
                    confirmPasswordController.text == passwordController.text) {
                  isEmpty = true;
                } else {
                  isEmpty = false;
                }
              });
            },
            suffixIconConstraints: const BoxConstraints(),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: obscureText
                    ? SvgPicture.asset(
                        "assets/icons/off_eye.svg",
                        width: 25,
                        height: 25,
                        fit: BoxFit.cover,
                      )
                    : SvgPicture.asset(
                        "assets/icons/on_eye.svg",
                        width: 25,
                        height: 25,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            prefixIconConstraints: const BoxConstraints(),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 13, right: 13),
              child: SvgPicture.asset(
                width: 23,
                height: 23,
                fit: BoxFit.cover,
                "assets/icons/lock.svg",
              ),
            ),
          ),
          const Spacer(),
          Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: isEmpty
                  ? WElevatedButton(
                      text: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Parolni tiklash",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 5 * devisePixel(context),
                              ),
                            ),
                      onPressed: isLoading
                          ? null
                          : () async {
                              _openDialog(context);
                            },
                    )
                  : const WElevatedTransparentButton(
                      buttonBackground: Color(0xffC8C5D8),
                      text: "Parolni tiklash",
                    )),
        ],
      ),
    );
  }

  Future<void> _openDialog(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: whiteColor,
          backgroundColor: whiteColor,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    width: width(context) / 4.6,
                    child: WElevatedButton(
                      text: Text(
                        "Yo’q",
                        style: TextStyle(color: whiteColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width(context) / 4.6,
                  child: WElevatedButton(
                    onPressed: () {},
                    text: Text(
                      "Ha",
                      style: TextStyle(color: whiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
          content: Container(
            padding: const EdgeInsets.only(top: 10),
            height: height(context) * 0.05,
            child: Text(
              "O’zgarishlar saqlansinmi?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 5 * devisePixel(context),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}
