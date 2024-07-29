import 'package:talaba_uz/utils/tools/file_important.dart';

class Tests extends StatelessWidget {
  const Tests({super.key});

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
                top: 15),
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
                      width: width(context) * 0.29,
                    ),
                    Text(
                      "Testlar",
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: height(context),
                    child: GridView.builder(
                      itemCount: 8,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1 / 1,
                              crossAxisCount: 2,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15),
                      itemBuilder: (context, index) => TestWidget(
                        subjectChoices[jsonList[index]['subject']].toString(),
                        jsonList[index]['tests'].length,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
