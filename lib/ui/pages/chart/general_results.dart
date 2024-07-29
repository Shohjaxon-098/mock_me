import 'package:talaba_uz/utils/tools/file_important.dart';

class GeneralResults extends StatefulWidget {
  const GeneralResults({super.key});

  @override
  State<GeneralResults> createState() => _GeneralResultsState();
}

class _GeneralResultsState extends State<GeneralResults> {
  int current = 0;
  List<String> items = [
    "19.04.2024",
    "1.02.2024",
    "3.03.2024",
  ];
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEEFC),
      body: Column(
        children: [
          /// Tab Bar
          SizedBox(
            height: height(context) * 0.037,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          current = index;
                        });
                        pageController.animateToPage(
                          current,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.ease,
                        );
                      },
                      child: AnimatedContainer(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        duration: const Duration(milliseconds: 300),
                        width: width(context) * 0.27,
                        height: height(context) * 0.037,
                        decoration: BoxDecoration(
                          color: current == index ? blueColor : Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                items[index],
                                style: GoogleFonts.ubuntu(
                                  fontWeight: FontWeight.w500,
                                  color: current == index
                                      ? whiteColor
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, left: 5, right: 8),
            height: height(context) * 0.67,
            child: PageView.builder(
              itemCount: icons.length,
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(24),
                  width: width(context),
                  height: height(context),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    itemCount: 13,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () {
                            _dialogBuilder(
                                "assets/images/oliygoh1.png",
                                "Akbarov Ahmadali",
                                "5-o`rin",
                                "Matematika",
                                "156.3",
                                "45",
                                '12',
                                "9");
                          },
                          child: Row(
                            children: [
                              Text(
                                "${index + 1}. ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 4.5 * devisePixel(context),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: index + 1 >= 10 ? 4 : 12, right: 12),
                                child: const CircleAvatar(
                                  radius: 14,
                                ),
                              ),
                              Text(
                                "Axmadov Akbar",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 4.5 * devisePixel(context),
                                ),
                              ),
                              const Spacer(),
                              index + 1 == 1
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.58),
                                      child: Image.asset(
                                        "assets/images/firstMedal.png",
                                        width: width(context) * 0.04,
                                        height: height(context) * 0.02,
                                      ),
                                    )
                                  : index + 1 == 2
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.58),
                                          child: Image.asset(
                                            "assets/images/firstMedal.png",
                                            width: width(context) * 0.04,
                                            height: height(context) * 0.02,
                                          ),
                                        )
                                      : index + 1 == 3
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.58),
                                              child: Image.asset(
                                                "assets/images/firstMedal.png",
                                                width: width(context) * 0.04,
                                                height: height(context) * 0.02,
                                              ),
                                            )
                                          : const SizedBox(),
                              Text(
                                "162.2 ball",
                                style: TextStyle(
                                  color: blueColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 4.5 * devisePixel(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _dialogBuilder(
    String image,
    String name,
    String place,
    String subject,
    String point,
    String allQues,
    String trueQue,
    String falseQue,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: whiteColor,
          backgroundColor: whiteColor,
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            width: 255,
            height: 192,
            padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 4.5 * devisePixel(context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            place,
                            style: TextStyle(
                              color: blueColor,
                              fontSize: 4.5 * devisePixel(context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "$point ball",
                      style: TextStyle(
                        color: blueColor,
                        fontSize: 4.5 * devisePixel(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Fan: ",
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 4.5 * devisePixel(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subject,
                      style: TextStyle(
                        fontSize: 4.5 * devisePixel(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Umumiy savollar",
                      style: TextStyle(
                        fontSize: 4.5 * devisePixel(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      allQues,
                      style: TextStyle(
                        fontSize: 4.5 * devisePixel(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "To’g’ri javoblar",
                      style: TextStyle(
                        fontSize: 4.5 * devisePixel(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      trueQue,
                      style: TextStyle(
                        fontSize: 4.5 * devisePixel(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Noto’g’ri javoblar",
                      style: TextStyle(
                        fontSize: 4.5 * devisePixel(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      falseQue,
                      style: TextStyle(
                        fontSize: 4.5 * devisePixel(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
