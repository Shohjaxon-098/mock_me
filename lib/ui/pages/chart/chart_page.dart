import 'package:talaba_uz/utils/tools/file_important.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xffEFEEFC),
        appBar: AppBar(
          backgroundColor: const Color(0xffEFEEFC),
          title: Text(
            'Natijalar',
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Color(0xff264CEC),
                  dividerColor: Colors.transparent,
                  labelColor: Color(0xff264CEC),
                  unselectedLabelColor: Color(0xff817D8F),
                  tabs: [
                    TabItem(
                      title: 'Mening natijalarim',
                    ),
                    TabItem(
                      title: 'Umumiy natijalar',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.only(left: 20, top: 28, right: 20),
          child: TabBarView(
            children: [
              MyResults(),
              GeneralResults(),
            ],
          ),
        ),
      ),
    );
  }
}
