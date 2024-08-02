import 'package:flutter_svg/flutter_svg.dart';
import 'package:talaba_uz/utils/tools/file_important.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var auth = Hive.box('auth');
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3))
        .then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  auth.get("token", defaultValue: '').toString().isNotEmpty
                      ? const HomePage()
                      : const StartPage(),
            ),
            (route) => false));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
        overlays: SystemUiOverlay.values);
  }

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/splash_logo.png",
                width: width(context) * 0.22,
              ),
              Text(
                "Mock-Me",
                style: TextStyle(
                  fontSize: 12.5 * devisePixel(context),
                  fontFamily: 'Nunito',
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
