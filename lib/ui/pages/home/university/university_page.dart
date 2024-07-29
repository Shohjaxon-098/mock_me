import 'package:talaba_uz/utils/tools/file_important.dart';

class UniverSity extends StatelessWidget {
  const UniverSity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEEFC),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: width(context) * 0.01,
              right: width(context) * 0.01,
              top: 15,
            ),
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
                      width: width(context) * 0.24,
                    ),
                    Text(
                      "Oliygohlar",
                      style: TextStyle(
                        fontSize: 6 * devisePixel(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height(context) * 0.032,
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: GridView.count(
                    shrinkWrap: true,
                    childAspectRatio: 2 / 1,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const SizedBox(
                        child: OliygohlarWidget(
                            text:
                                "Toshkent axborot texnologiyalari universiteti",
                            image: "assets/images/oliygoh1.png"),
                      ),
                      const OliygohlarWidget(
                          text: "Toshkent moliya instituti",
                          image: "assets/images/oliygoh2.png"),
                      const OliygohlarWidget(
                          text: "Toshkent axborot texnologiyalari universiteti",
                          image: "assets/images/oliygoh1.png"),
                      const OliygohlarWidget(
                          text: "Toshkent moliya instituti",
                          image: "assets/images/oliygoh2.png"),
                      const OliygohlarWidget(
                          text: "Toshkent axborot texnologiyalari universiteti",
                          image: "assets/images/oliygoh1.png"),
                      const OliygohlarWidget(
                          text: "Toshkent moliya instituti",
                          image: "assets/images/oliygoh2.png"),
                      const OliygohlarWidget(
                          text: "Toshkent axborot texnologiyalari universiteti",
                          image: "assets/images/oliygoh1.png"),
                      const OliygohlarWidget(
                          text: "Toshkent moliya instituti",
                          image: "assets/images/oliygoh2.png"),
                      const OliygohlarWidget(
                          text: "Toshkent axborot texnologiyalari universiteti",
                          image: "assets/images/oliygoh1.png"),
                      const OliygohlarWidget(
                          text: "Toshkent moliya instituti",
                          image: "assets/images/oliygoh2.png"),
                      const OliygohlarWidget(
                          text: "Toshkent axborot texnologiyalari universiteti",
                          image: "assets/images/oliygoh1.png"),
                      const OliygohlarWidget(
                          text: "Toshkent moliya instituti",
                          image: "assets/images/oliygoh2.png"),
                      const OliygohlarWidget(
                          text: "Toshkent axborot texnologiyalari universiteti",
                          image: "assets/images/oliygoh1.png"),
                      const OliygohlarWidget(
                          text: "Toshkent moliya instituti",
                          image: "assets/images/oliygoh2.png"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
