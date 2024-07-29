import 'package:talaba_uz/utils/tools/file_important.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const StartPage()),
    );
  }

  Widget _buildImage(String assetName, double width) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    final bodyStyle = TextStyle(
      fontSize: 4.5 * devisePixel(context),
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );

    final pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 8 * devisePixel(context),
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: const Color(0xff264CEC),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: blueColor,
      allowImplicitScrolling: true,

      infiniteAutoScroll: false,

      pages: [
        PageViewModel(
          title: "Do'stlar bilan mashg'ulotlarda ishtirok eting",
          body:
              "Doimo birinchi bo`lishga intiling yanada yuqori darajaga chiqing va eng yaxshi bo`lishga intiling.",
          image: _buildImage('onBoarding_image.png', 300),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Mock testlar orqali o’z bilimingizni sinab ko’ring",
          body:
              "Siz bu loyihada faqatgina bilimingizni bilibgina qolmasdan yangi biliblarni o`zlashtirasz",
          image: _buildImage('onBoarding_image.png', 260),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Test natijal;ari orqali o`z bilimingizni bilib oling",
          body: "Sinovlar sizni yanada kuchli qilishga yordam beradi",
          image: _buildImage('onBoarding_image.png', 260),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      animationDuration: 1200,

      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,

      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(
        Icons.arrow_back,
      ),
      skip: Text(
        'O`tkazish',
        style: TextStyle(
          color: Colors.white,
          fontSize: 5.5 * devisePixel(context),
          fontWeight: FontWeight.w500,
        ),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFE6E6E6),
        activeSize: Size(22.0, 10.0),
        activeColor: Colors.white,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
