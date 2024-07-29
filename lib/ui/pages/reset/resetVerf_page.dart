// ignore_for_file: file_names

import 'package:talaba_uz/utils/tools/file_important.dart';

class RestOTP extends StatefulWidget {
  const RestOTP(
      {super.key, required this.otpController, required this.onChanged});
  final TextEditingController otpController;
  final void Function(String)? onChanged;
  @override
  State<RestOTP> createState() => _RestOTPState();
}

class _RestOTPState extends State<RestOTP> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 56,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: TextFormField(
          controller: widget.otpController,
          keyboardType: TextInputType.number,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: widget.onChanged,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: ('__'),
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 6 * devisePixel(context),
                  color: Colors.black45)),
        ),
      ),
    );
  }
}

class RestVerf extends StatefulWidget {
  const RestVerf({super.key, required this.emailController});
  final String emailController;
  @override
  State<RestVerf> createState() => _RestVerfState();
}

class _RestVerfState extends State<RestVerf> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();
  TextEditingController otp5Controller = TextEditingController();
  int resendTime = 60;
  bool isEmpty = false;
  bool isLoading = false;
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
        resendTime--;
      });
      if (resendTime == 0) {
        countdownTimer.cancel();
        setState(() {
          resendTime = 60;
        });
      }
    });
  }

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
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Elektron pochtangizga yuborilgan kodni kiriting",
                      style: TextStyle(
                          fontSize: 6 * devisePixel(context),
                          fontWeight: FontWeight.w600,
                          color: Color(0xff8B8B8B)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Code",
                      style: TextStyle(
                        fontSize: 6 * devisePixel(context),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RestOTP(
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
                      RestOTP(
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
                      RestOTP(
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
                      RestOTP(
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
                      RestOTP(
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
                  resendTime != 60
                      ? Center(
                          child: Text.rich(
                            TextSpan(
                                text: '00:${strFormatting(resendTime)} s ',
                                style: TextStyle(
                                    fontSize: 5.5 * devisePixel(context),
                                    color: blueColor,
                                    fontWeight: FontWeight.w500),
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const TextSpan(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                    text: "dan keyin qayta yuborish",
                                  )
                                ]),
                          ),
                        )
                      : Center(
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                startTimer();
                              });
                              await ApiService()
                                  .sendEmail(widget.emailController.trim());
                            },
                            child: Text(
                              "Kodni qayta yuborish",
                              style: TextStyle(
                                  fontSize: 5.5 * devisePixel(context),
                                  color: blueColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
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
                              String enteredOTP = otp1Controller.text +
                                  otp2Controller.text +
                                  otp3Controller.text +
                                  otp4Controller.text +
                                  otp5Controller.text;
                              resetOTP(widget.emailController, enteredOTP);
                            },
                    )
                  : const WElevatedTransparentButton(
                      text: "Parolni tiklash",
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> resetOTP(String emailController, String otp) async {
    // Send the entered OTP to the server for verification
    bool isOTPresetEmail =
        await ApiService().resetEmailOTP(emailController, otp);
    if (isOTPresetEmail) {
      stopTimer();
      // OTP verified successfully, navigate to the next screen
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => NewPasswordPage(
            emailController: widget.emailController,
          ),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // Show error message if OTP verification fails
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Invalid OTP. Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
