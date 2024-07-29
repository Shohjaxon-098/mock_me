// ignore_for_file: file_names

import 'package:talaba_uz/utils/tools/file_important.dart';

// ignore: must_be_immutable
class SendEmailPage extends StatefulWidget {
  const SendEmailPage({super.key});

  @override
  State<SendEmailPage> createState() => _SendEmailPageState();
}

class _SendEmailPageState extends State<SendEmailPage> {
  TextEditingController emailController = TextEditingController();

  bool isEmpty = false;
  bool _emailValid = true;
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
                  width: width(context) * 0.19,
                ),
                Text(
                  "Parolni tiklash",
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
              "Elektron pochtangizni kiriting va biz sizga parolingizni tiklash uchun kod yuboramiz",
              style: TextStyle(
                color: Color(0xff8B8B8B),
                fontSize: 6.5 * devisePixel(context),
              ),
            ),
          ),
          const SizedBox(
            height: 31,
          ),
          WidgetTextField(
            readOnly: false,
            obscureText: false,
            controller: emailController,
            headText: "Emailingizni kiriting",
            hintText: "Email",
            errorText: _emailValid ? null : 'Please enter a valid email',
            prefixIconConstraints: const BoxConstraints(),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: SvgPicture.asset(
                width: 23,
                height: 23,
                fit: BoxFit.cover,
                "assets/icons/mail.svg",
              ),
            ),
            onChanged: (value) {
              _emailValid = validateEmail(value) == null;
              setState(() {
                if (emailController.toString().isNotEmpty && _emailValid) {
                  isEmpty = true;
                } else {
                  isEmpty = false;
                }
              });
            },
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
                              fontWeight: FontWeight.w500,
                     fontSize: 6 * devisePixel(context),
                            ),
                          ),
                    onPressed: isLoading
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                            });
                            bool isSendEmail = await ApiService()
                                .sendEmail(emailController.text.trim());
                            if (isSendEmail) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.push(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RestVerf(
                                      emailController: emailController.text,
                                    ),
                                  ));
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Xatolik yuz berdi,qayta urining"),
                                ),
                              );
                            }
                          },
                  )
                : const WElevatedTransparentButton(
                    text: "Parolni tiklash",
                  ),
          ),
        ],
      ),
    );
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}
