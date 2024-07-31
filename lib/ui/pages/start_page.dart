// test ucn
// ignore_for_file: prefer_const_constructors

import 'package:talaba_uz/utils/tools/file_important.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: blueColor,
          image: const DecorationImage(
              image: AssetImage("assets/images/splash_back.png"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 36,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/splash_logo.png",
                        width: 54,
                      ),
                      Text(
                        "Mock-Me",
                        style: TextStyle(
                          fontSize: 8 * devisePixel(context),
                          fontFamily: 'Nunito',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/login_image.png",
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    width: width(context) * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Kirish yoki Ro'yxatdan o'tish",
                            style: TextStyle(
                              fontSize: 6 * devisePixel(context),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            "Tizimga kirish yoki hisob qaydnomasini yaratish, testlarda ishtirok etish va boshqalar.",
                            style: TextStyle(
                              fontSize: 4.5 * devisePixel(context),
                              fontWeight: FontWeight.w500,
                              color: Color(0xff858494),
                            ),
                          ),
                          WElevatedButton(
                            text: Text(
                              "Kirish",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 5 * devisePixel(context),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginPage(),
                                ),
                              );
                            },
                          ),
                          WElevatedTransparentButton(
                            buttonBackground: const Color(0xffE6E6E6),
                            text: "Ro’yxatdan o’tish",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignUpPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
