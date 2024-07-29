// ignore_for_file: use_build_context_synchronously, file_names

import 'package:talaba_uz/utils/tools/file_important.dart';

class Otp extends StatelessWidget {
  const Otp({super.key, required this.otpController, required this.onChanged});
  final void Function(String)? onChanged;
  final TextEditingController otpController;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 46,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: TextFormField(
          controller: otpController,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: onChanged,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: ('__'),
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 6 * devisePixel(context),
                  color: Colors.black)),
          onSaved: (value) {},
        ),
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.emailController});
  final String emailController;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();
  TextEditingController otp5Controller = TextEditingController();
  int resendTime = 60;

  late Timer countdownTimer;
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  stopTimer() {
    if (countdownTimer.isActive) {
      countdownTimer.cancel();
    }
  }

  String strFormatting(n) => n.toString().padLeft(2, '0');

  startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendTime = resendTime - 1;
      });
      if (resendTime < 1) {
        countdownTimer.cancel();
      }
    });
  }

  Future<void> verifyOTP(String emailController, String otp) async {
    // Send the entered OTP to the server for verification
    bool isOTPVerified =
        await ApiService().verifyEmailOTP(emailController, otp);
    print(isOTPVerified);
    if (isOTPVerified) {
      // OTP verified successfully, navigate to the next screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // Show error message if OTP verification fails
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Xatolik'),
            content: const Text('Kod xato.Qayta urunib kuring'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Xa'),
              ),
            ],
          );
        },
      );
    }
  }

  bool isEmpty = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEEFC),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: SvgPicture.asset(
                    "assets/icons/arrow_back.svg",
                    width: 15,
                    height: 15,
                  ),
                ),
                SizedBox(
                  width: width(context) * 0.23,
                ),
                Text(
                  "Tasdiqlash",
                  style: TextStyle(
                    fontSize: 6 * devisePixel(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Elektron pochtangizga yuborilgan kodni kiriting",
                      style: TextStyle(
                          fontSize: 6 * devisePixel(context),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff8B8B8B)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Kodni kiriting",
                      style: TextStyle(
                        fontSize: 6 * devisePixel(context),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Otp(
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        otpController: otp1Controller,
                      ),
                      Otp(
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        otpController: otp2Controller,
                      ),
                      Otp(
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        otpController: otp3Controller,
                      ),
                      Otp(
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        otpController: otp4Controller,
                      ),
                      Otp(
                        onChanged: (value) {
                          if (value.length == 1) {
                            isEmpty = true;
                            FocusScope.of(context).nextFocus();
                          }
                          if (value.isEmpty) {
                            isEmpty = false;
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        otpController: otp5Controller,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            const SizedBox(
              height: 80,
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
                              "Tasdiqlash",
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

                              String enteredOTP = otp1Controller.text +
                                  otp2Controller.text +
                                  otp3Controller.text +
                                  otp4Controller.text +
                                  otp5Controller.text;
                              verifyOTP(widget.emailController.toString(),
                                  enteredOTP);
                            })
                  : const WElevatedTransparentButton(
                      text: "Tasdiqlash",
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
