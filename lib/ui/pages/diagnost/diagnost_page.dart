// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:talaba_uz/ui/pages/diagnost/dtm_test.dart';
import 'package:talaba_uz/utils/tools/file_important.dart';

class DiagnostPage extends StatefulWidget {
  const DiagnostPage({super.key});

  @override
  State<DiagnostPage> createState() => _DiagnostPageState();
}

class _DiagnostPageState extends State<DiagnostPage> {
  Duration duration = const Duration(hours: 0, minutes: 0, seconds: 10);

  late Timer timer;
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void indecatorTimer() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {});
  }

  @override
  void dispose() {
    timer.cancel(); // Timer'ı iptal et
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => addTime(),
    );
  }

  void addTime() {
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds - addSeconds;
      if (seconds < 0) {
        timer.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  List anotherTestList = [
    "assets/images/e-avtomaktab.png",
    "assets/images/prezident-mak.png",
    "assets/images/qorako`l-mak.png",
    "assets/images/milliy-sertifikat.png",
  ];
  int _currentPageTest = 0;
  int _currentPageLang = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffEFEEFC),
        title: Text(
          'Testlar',
          style: TextStyle(
            fontSize: 6 * devisePixel(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset("assets/icons/notification.svg"),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xffEFEEFC),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 35, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Diagnostik test",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 5 * devisePixel(context),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: width(context) * 0.89,
                      height: height(context) * 0.25,
                      decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 18),
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffEFEEFC),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icons/math.svg",
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Aniq fanlardan blok test",
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 4.5 * devisePixel(context),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Divider(
                            color: Colors.white10,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/quiz.svg"),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "12-mart, 2024",
                                          style: TextStyle(
                                            color: whiteColor,
                                            fontSize:
                                                4.5 * devisePixel(context),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/time.svg"),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "2 soat vaqt",
                                          style: TextStyle(
                                            color: whiteColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 5 * devisePixel(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    buildTime(),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    duration.inHours == 0 &&
                                            duration.inMinutes == 0 &&
                                            duration.inSeconds == 0
                                        ? SizedBox(
                                            width: width(context) * 0.28,
                                            height: 24,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const DtmTests()));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor: whiteColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Boshlash",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(
                                            width: width(context) * 0.28,
                                            height: 24,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffC8C5D8),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Center(
                                                child: Text(
                                                  "Boshlash",
                                                  style: TextStyle(
                                                    color: whiteColor,
                                                    fontSize: 5 *
                                                        devisePixel(context),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 28,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "DTM testlar",
                          style: TextStyle(
                            fontSize: 5 * devisePixel(context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: const DtmTests(),
                                    type: PageTransitionType.rightToLeft,
                                  ),
                                );
                              },
                              child: Text(
                                "Barchasi",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 4.5 * devisePixel(context),
                                  color: blueColor,
                                ),
                              ),
                            ),
                            Icon(
                              size: 18,
                              Icons.arrow_forward_ios_rounded,
                              color: blueColor,
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    blockTest(),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: CarouselIndicator(
                        animationDuration: 250,
                        color: const Color(0xff0d9d9d9),
                        width: 9,
                        height: 9,
                        activeColor: blueColor,
                        count: 3,
                        index: _currentPageTest,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 28,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Xorijiy tillar",
                          style: TextStyle(
                            fontSize: 5 * devisePixel(context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   PageTransition(
                                //     child: const BlockTests(),
                                //     type: PageTransitionType.rightToLeft,
                                //   ),
                                // );
                              },
                              child: Text(
                                "Barchasi",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 4.5 * devisePixel(context),
                                  color: blueColor,
                                ),
                              ),
                            ),
                            Icon(
                              size: 18,
                              Icons.arrow_forward_ios_rounded,
                              color: blueColor,
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    xorijiyTil(),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: CarouselIndicator(
                        animationDuration: 250,
                        color: const Color(0xff0d9d9d9),
                        width: 9,
                        height: 9,
                        activeColor: blueColor,
                        count: 2,
                        index: _currentPageLang,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Boshqa testlar",
                      style: TextStyle(
                        fontSize: 5 * devisePixel(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    anotherTest()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hour = twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Text(
      "$hour:$minutes:$seconds",
      style: const TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
    );
  }

  Widget blockTest() {
    return CarouselSlider(
      items: [
        1,
        2,
        3,
      ].map((e) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: width(context) * 0.4,
              height: height(context),
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      "Aniq fanlar(Texnika)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 4 * devisePixel(context),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: width(context) * 0.26,
                      height: 24,
                      child: WElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: const DtmTests(),
                              type: PageTransitionType.rightToLeft,
                            ),
                          );
                        },
                        text: Text(
                          "Batafsil",
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 4 * devisePixel(context),
                              letterSpacing: 0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: width(context) * 0.4,
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      "Aniq fanlar(Iqtisod)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 4 * devisePixel(context),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: width(context) * 0.26,
                      height: 24,
                      child: WElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: const DtmTests(),
                              type: PageTransitionType.rightToLeft,
                            ),
                          );
                        },
                        text: Text(
                          "Batafsil",
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 4 * devisePixel(context),
                              letterSpacing: 0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }).toList(),
      options: CarouselOptions(
        initialPage: _currentPageLang,
        padEnds: false,
        viewportFraction: 1.05,
        height: 100,
        onPageChanged: (index, reason) {
          setState(() {
            _currentPageTest = index;
          });
        },
      ),
    );
  }

  Widget xorijiyTil() {
    return SizedBox(
      width: width(context),
      child: CarouselSlider(
        items: [
          1,
          2,
        ].map((e) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: width(context) * 0.4,
                height: height(context),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(
                      "assets/images/ielts.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Container(
                height: height(context),
                width: width(context) * 0.4,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/images/cefr.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(8)),
              ),
            ],
          );
        }).toList(),
        options: CarouselOptions(
          initialPage: _currentPageLang,
          padEnds: false,
          viewportFraction: 1.05,
          height: 78,
          onPageChanged: (index, reason) {
            setState(() {
              _currentPageLang = index;
            });
          },
        ),
      ),
    );
  }

  Widget anotherTest() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(
            right: 12,
          ),
          width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  anotherTestList[index],
                ),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
