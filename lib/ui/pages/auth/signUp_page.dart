// ignore_for_file: file_names

import 'package:flutter/gestures.dart';
import 'package:talaba_uz/utils/tools/file_important.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController regionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  bool isLoading = false;
  bool isEmpty = false;
  bool obscureText = true;
  Dio dio = Dio();
  bool _isChecked = false;

  void _toggleCheckbox(bool? newValue) {
    setState(() {
      _isChecked = newValue ?? false;
      isEmpty = newValue ?? true;
    });
  }

  @override
  void dispose() {
    regionController.dispose();
    phoneController.dispose();
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }

  bool _emailValid = true;
  Timer? debounce;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEEFC),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, bottom: 25),
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
                      width: MediaQuery.of(context).size.width * 0.24,
                    ),
                    Text(
                      "Ro'yxatdan o'tish",
                      style: TextStyle(
                          fontSize: 6 * devisePixel(context),
                          color: const Color(0xff001833),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              WidgetTextField(
                readOnly: false,
                obscureText: false,
                controller: nameController,
                headText: "Ismingizni kiriting",
                hintText: "Ism",
                onChanged: (text) {
                  setState(() {
                    if (nameController.text.isNotEmpty) {
                      isEmpty = true;
                    } else {
                      isEmpty = false;
                    }
                    isEmpty = false;
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              WidgetTextField(
                readOnly: false,
                obscureText: false,
                controller: surnameController,
                headText: "Familiyangizni kiriting",
                hintText: "Familiya",
                onChanged: (text) {
                  setState(() {
                    if (surnameController.text.isNotEmpty) {
                      isEmpty = true;
                    } else {
                      isEmpty = false;
                    }
                    isEmpty = false;
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: width(context) * 0.55,
                        child: WidgetTextField(
                          controller: dateOfBirthController,
                          readOnly: true,
                          onChanged: (text) {
                            setState(() {
                              if (dateOfBirthController.text.isNotEmpty) {
                                isEmpty = true;
                              } else {
                                isEmpty = false;
                              }
                              isEmpty = false;
                            });
                          },
                          onTap: () {
                            selectDate();
                          },
                          hintStyle: TextStyle(fontSize: 14),
                          obscureText: false,
                          headText: "Tug’ilgan sana",
                          hintText: "DD:MM:YYY",
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              "assets/icons/kalendar.svg",
                              fit: BoxFit.cover,
                              width: 35,
                              height: 25,
                            ),
                          ),
                          suffixIconConstraints: const BoxConstraints(),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Viloyat",
                            style: TextStyle(
                              fontSize: 5 * devisePixel(context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          inputField(regionController),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              WidgetTextField(
                readOnly: false,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top: 12, left: 10, right: 10),
                  child: Text(
                    "+998  |",
                    style: TextStyle(
                      fontSize: 5 * devisePixel(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                obscureText: false,
                keyboardType: TextInputType.phone,
                headText: "Telefon raqami",
                hintText: "(_ _)   _ _ _   _ _   _ _",
                controller: phoneController,
                onChanged: (text) {
                  setState(() {
                    if (phoneController.text.isNotEmpty) {
                      isEmpty = true;
                    } else {
                      isEmpty = false;
                    }
                    isEmpty = false;
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              WidgetTextField(
                readOnly: false,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                errorText: _emailValid ? null : 'Please enter a valid email',
                onChanged: (String value) {
                  if (debounce?.isActive ?? false) debounce?.cancel();
                  debounce = Timer(const Duration(milliseconds: 500), () {
                    setState(() {
                      _emailValid = validateEmail(value) == null;
                      if (emailController.text.isNotEmpty &&
                          confirmPasswordController.toString().isNotEmpty) {
                        isEmpty = true;
                      } else {
                        isEmpty = false;
                      }
                    });
                  });
                },
                controller: emailController,
                headText: "Emailngizni kiriting",
                hintText: "Email",
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
              ),
              const SizedBox(
                height: 12,
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
                    ? 'Password must be at least 8 characters'
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
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: SvgPicture.asset(
                    width: 23,
                    height: 23,
                    fit: BoxFit.cover,
                    "assets/icons/lock.svg",
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              WidgetTextField(
                readOnly: false,
                obscureText: obscureText,
                headText: "Parolni tasdiqlash",
                hintText: "Parolni qayta kiriting",
                errorText: confirmPasswordController.text.isNotEmpty &&
                        confirmPasswordController.text !=
                            passwordController.text
                    ? 'Passwords do not match'
                    : null,
                onChanged: (value) {
                  confirmPasswordController.text = value;
                  setState(() {
                    if (confirmPasswordController.toString().isNotEmpty &&
                        confirmPasswordController.text ==
                            passwordController.text) {
                      isEmpty = _isChecked;
                    } else {
                      isEmpty = _isChecked;
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
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: SvgPicture.asset(
                    width: 23,
                    height: 23,
                    fit: BoxFit.cover,
                    "assets/icons/lock.svg",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                        checkColor: whiteColor,
                        activeColor: blueColor,
                        value:
                            _isChecked, // Set this to false if you want it unchecked
                        onChanged: _toggleCheckbox),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Siz davom etishingiz uchun ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'Xizmatlar shartlari',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle tap on "Xizmatlar shartlari"
                              },
                          ),
                          TextSpan(
                            text: ' & \n',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: 'Maxfiylik siyosati',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle tap on "Maxfiylik siyosati"
                              },
                          ),
                          TextSpan(
                            text: ' shartlariga rozilik bildirasiz',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
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

                              bool isRegistered =
                                  await ApiService().registerUser(
                                nameController.text.trim(),
                                surnameController.text.trim(),
                                dateOfBirthController.text.trim(),
                                regionController.text.trim(),
                                phoneController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );

                              if (isRegistered) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OtpScreen(
                                      emailController: emailController.text,
                                    ),
                                  ),
                                );
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Xatolik bor.Ko`rib chiqing"),
                                  ),
                                );
                              }

                              setState(() {
                                isLoading = false;
                              });
                            },
                    )
                  : const WElevatedTransparentButton(
                      text: "Tizimga kirish",
                    ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 2,
                    width: 145,
                    color: const Color(0xFFBFBFBF),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                      fontSize: 6 * devisePixel(context),
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFBFBFBF),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 2,
                    width: 145,
                    color: const Color(0xFFBFBFBF),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              WGoogleButton(
                onPressed: () {},
                text: "Google bilan kirish",
              ),
              const SizedBox(
                height: 25,
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width * 0.36,
      height: 45,
      child: TextFormField(
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        controller: controller,
        onChanged: (text) {
          setState(() {
            if (regionController.text.isNotEmpty) {
              isEmpty = true;
            } else {
              isEmpty = false;
            }
            isEmpty = false;
          });
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          fillColor: Colors.white,
          filled: true,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 5 * devisePixel(context),
            fontWeight: FontWeight.w500,
          ),
          hintText: "Viloyat",
          contentPadding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
          suffixIcon: GestureDetector(
            child: Icon(
              Icons.arrow_drop_down_sharp,
              size: 28,
              color: blueColor,
            ),
          ),
        ),
        onTap: () => _dialogBuilder(),
        readOnly: true,
      ),
    );
  }

  Widget selectionField(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      width: MediaQuery.of(context).size.width * 0.32,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.builder(
        itemCount: capitalizeList(regionList).length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(
                () {
                  controller.text = regionList[index];
                  Navigator.of(context).pop();
                },
              );
            },
            child: ListTile(
              title: Text(
                capitalizeList(regionList)[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 5 * devisePixel(context),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        dateOfBirthController.text = picked.toString().split(" ")[0];
      });
    }
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Iltimos, elektron pochtangizni kiriting';
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Yaroqli elektron pochta manzilini kiriting';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Iltimos, parolingizni kiriting';
    }
    if (value.length < 8) {
      return 'Kamida 8 ta belgidan iborat bo`lishi kerak.';
    }
    return null;
  }

  String? confirmValidatePassword(value) {
    if (value.isEmpty) {
      return "Iltimos, parolingizni kiriting";
    }
    if (value != confirmPasswordController) {
      return "Bir xil parol kiriting";
    }
    return null;
  }

  Future<void> _dialogBuilder() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            "Viloyat",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          content: selectionField(regionController),
        );
      },
    );
  }

  List<String> capitalizeList(List<String> list) {
    List<String> capitalizedList = [];
    for (String item in list) {
      // Check if item is not empty
      if (item.isNotEmpty) {
        // Capitalize first letter and concatenate with the rest of the string
        String capitalizedItem =
            item.substring(0, 1).toUpperCase() + item.substring(1);
        capitalizedList.add(capitalizedItem);
      }
    }
    return capitalizedList;
  }
}
