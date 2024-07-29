// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:talaba_uz/utils/tools/file_important.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool _emailValid = true;
  bool obscureText = true;
  bool isEmpty = false;
  bool isLoading = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Dio _dio = Dio();

  Future<void> _signIn() async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();
      if (user != null) {
        final GoogleSignInAuthentication googleAuth = await user.authentication;

        final accessToken = googleAuth.accessToken;

        if (accessToken != null) {
          _dio.options.headers['Authorization'] = 'Bearer $accessToken';

          try {
            final response = await _dio.get(baseUrl);
            print('User info: ${response.data}');
          } catch (error) {
            print('Error making request: $error');
          }
        }
      }
    } catch (error) {
      print('Error signing in: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEEFC),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 30,
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
                    width: width(context) * 0.23,
                  ),
                  Text(
                    "Tizimga kirish",
                    style: TextStyle(
                        fontSize: 6 * devisePixel(context),
                        color: Color(0xff001833),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                WidgetTextField(
                  readOnly: false,
                  obscureText: false,
                  errorText: _emailValid
                      ? null
                      : 'Yaroqli elektron pochta manzilini kiriting',
                  onChanged: (String value) {
                    setState(() {
                      _emailValid = validateEmail(value) == null;
                      if (emailController.toString().isEmpty) {
                        isEmpty = false;
                      } else {
                        isEmpty = true;
                      }
                      isEmpty = false;
                    });
                  },
                  controller: emailController,
                  headText: "Emailingizni kiriting",
                  hintText: "Email",
                  prefixIconConstraints: const BoxConstraints(),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 13, left: 13),
                    child: SvgPicture.asset(
                      width: 23,
                      height: 23,
                      fit: BoxFit.cover,
                      "assets/icons/mail.svg",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                WidgetTextField(
                  readOnly: false,
                  onChanged: (value) {
                    passwordController.text = value;
                    setState(() {
                      if (passwordController.toString().isNotEmpty &&
                          passwordController.text.length < 8) {
                        isEmpty = false;
                      } else {
                        isEmpty = true;
                      }
                    });
                  },
                  obscureText: obscureText,
                  headText: "Parolingizni kiriting",
                  hintText: "Parol",
                  errorText: passwordController.text.isNotEmpty &&
                          passwordController.text.length < 8
                      ? 'Kamida 8 ta belgidan iborat bo`lishi kerak.'
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
                  height: 40,
                ),
                isEmpty
                    ? WElevatedButton(
                        text: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Tizimga kirish",
                                style: TextStyle(
                                  fontSize: 5 * devisePixel(context),
                                  color: Colors.white,
                                ),
                              ),
                        onPressed: isLoading
                            ? null
                            : () async {
                                setState(() {
                                  isLoading = true;
                                });

                                Map<String, dynamic>? userData =
                                    await ApiService().loginUser(
                                        emailController.text.trim(),
                                        passwordController.text.trim());
                                if (userData != null) {
                                  // Agar foydalanuvchi ma'lumoti olinib qaytarilgan bo'lsa

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                      (route) => false);
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Xatolik bor.Ko`rib chiqing"),
                                    ),
                                  );
                                }
                              },
                      )
                    : const WElevatedTransparentButton(
                        text: "Tizimga kirish",
                      ),
                const SizedBox(
                  height: 23,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SendEmailPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Parolingizni unutdingizmi?",
                    style: TextStyle(
                        fontSize: 5.5 * devisePixel(context),
                        fontWeight: FontWeight.w600,
                        color: blueColor),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 2,
                      width: width(context) * 0.32,
                      color: const Color(0xFFBFBFBF),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 6 * devisePixel(context),
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFBFBFBF),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 2,
                      width: width(context) * 0.32,
                      color: const Color(0xFFBFBFBF),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Column(
              children: [
                WGoogleButton(
                  onPressed: () {
                    _signIn();
                  },
                  text: "Google bilan kirish",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
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
