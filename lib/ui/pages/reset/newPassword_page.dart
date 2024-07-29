// ignore_for_file: file_names

import 'package:talaba_uz/utils/tools/file_important.dart';

// ignore: must_be_immutable
class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key, required this.emailController});
  final String emailController;
  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  bool isEmpty = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEEFC),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 25, bottom: 25),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: SvgPicture.asset(
                    "assets/icons/arrow_back.svg",
                    width: 15,
                    height: 15,
                  ),
                ),
                SizedBox(
                  width: width(context) * 0.25,
                ),
                Text(
                  "Yangi parol",
                  style: TextStyle(
                      fontSize: 6 * devisePixel(context),
                      color: Color(0xff001833),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 23,
          ),
          Padding(
            padding: EdgeInsets.only(left: 33, right: 33),
            child: Text(
              "Yangi parolingiz eski parolingizdan farq qilishi kerak.",
              style: TextStyle(
                fontSize: 6 * devisePixel(context),
              ),
            ),
          ),
          const SizedBox(
            height: 31,
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
                          :  Text(
                              "Parolni tiklash",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                  fontSize: 6 * devisePixel(context),
                              ),
                            ),
                      onPressed: isLoading
                          ? null
                          : () async {
                              setState(() {
                                isLoading = true;
                              });
                              bool isNewPassword = await ApiService()
                                  .newPassword(widget.emailController,
                                      passwordController.text.trim());
                              if (isNewPassword) {
                                Navigator.push(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                              }
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
}
