import '../../../utils/tools/file_important.dart';

class MyResults extends StatefulWidget {
  const MyResults({super.key});

  @override
  State<MyResults> createState() => _MyResultsState();
}

class _MyResultsState extends State<MyResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEEFC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width(context) * 0.89,
              height: height(context) * 0.21,
              decoration: BoxDecoration(
                  color: blueColor, borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Aniq fanlar(Texnika)",
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 5 * devisePixel(context),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "12-mart, 2024",
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 4.5 * devisePixel(context),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Umumiy savollar",
                                  style: TextStyle(
                                    fontSize: 4.5 * devisePixel(context),
                                    color: whiteColor,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width(context) * 0.07),
                                  child: Text(
                                    "45",
                                    style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 4.5 * devisePixel(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "To’g’ri javoblar",
                                  style: TextStyle(
                                    fontSize: 4.5 * devisePixel(context),
                                    color: whiteColor,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width(context) * 0.1),
                                  child: Text(
                                    "45",
                                    style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 4.5 * devisePixel(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Noto’g’ri javoblar",
                                  style: TextStyle(
                                    fontSize: 4.5 * devisePixel(context),
                                    color: whiteColor,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width(context) * 0.07),
                                  child: Text(
                                    "45",
                                    style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 4.5 * devisePixel(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircularPercentIndicator(
                        animationDuration: 1300,
                        animation: true,
                        radius: 45,
                        lineWidth: 10,
                        percent: 0.85,
                        progressColor: whiteColor,
                        backgroundColor: const Color(0xffA8B7F7),
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          "82%",
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 6.5 * devisePixel(context),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Darajasi: ",
                            style: TextStyle(
                              fontSize: 4.5 * devisePixel(context),
                              fontWeight: FontWeight.w500,
                              color: Colors.white54,
                            ),
                          ),
                          Text(
                            "Yaxshi",
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 5 * devisePixel(context),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Natijalar tarixi",
                  style: TextStyle(
                    fontSize: 6 * devisePixel(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: height(context),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) => resultsHistory(
                        "78", "Matematika", "30", "28", '23.04.2024'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget resultsHistory(String foizi, String fan, String savollar,
      String togriJavoblar, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: width(context) * 0.89,
            height: height(context) * 0.135,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 14),
                  child: Text(
                    "$fan",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 5 * devisePixel(context),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 14,
                    right: 14,
                  ),
                  child: Text(
                    "Jami savollar $savollar ta, to’g’ri javoblar $togriJavoblar ta",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 4.5 * devisePixel(context),
                        color: Colors.black45),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    children: [
                      LinearPercentIndicator(
                        width: width(context) * 0.75,
                        lineHeight: 4,
                        percent: 0.5,
                        barRadius: const Radius.circular(4),
                        backgroundColor: const Color(0xffC8C5D8),
                        progressColor: const Color(0xff264CEC),
                      ),
                      Text(
                        "$foizi%",
                        style: TextStyle(
                            color: const Color(0xff264CEC),
                            fontSize: 6 * devisePixel(context),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            date,
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w500,
              fontSize: 4 * devisePixel(context),
            ),
          ),
        ],
      ),
    );
  }
}
