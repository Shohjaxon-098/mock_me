// ignore_for_file: avoid_print

import 'package:talaba_uz/utils/tools/file_important.dart';

import '../../../services/model/responses/dtm_direction/dtm_direction.dart';
import '../diagnost/variant_subject.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEEFC),
      body: pages[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: height(context) * 0.08,
          child: CustomNavigationBar(
            iconSize: 30,
            borderRadius: const Radius.circular(24),
            elevation: 0,
            currentIndex: _currentIndex,
            onTap: (newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
            items: [
              CustomNavigationBarItem(
                selectedIcon:
                    SvgPicture.asset("assets/icons/homeBottomActive.svg"),
                icon: SvgPicture.asset("assets/icons/homeBottomNoActive.svg"),
                title: const Text(""),
              ),
              CustomNavigationBarItem(
                selectedIcon:
                    SvgPicture.asset("assets/icons/testlarBottomActive.svg"),
                icon:
                    SvgPicture.asset("assets/icons/testlarBottomNoActive.svg"),
                title: const Text(""),
              ),
              CustomNavigationBarItem(
                selectedIcon:
                    SvgPicture.asset("assets/icons/chartBottomActive.svg"),
                icon: SvgPicture.asset("assets/icons/chartBottomNoActive.svg"),
                title: const Text(""),
              ),
              CustomNavigationBarItem(
                selectedIcon:
                    SvgPicture.asset("assets/icons/accountBottomActive.svg"),
                icon:
                    SvgPicture.asset("assets/icons/accountBottomNoActive.svg"),
                title: const Text(""),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController url = TextEditingController();
  final Dio _dio = Dio();
  late int userId = 0;

  List<DtmDirection> dtmDirections = [];
  @override
  void initState() {
    super.initState();
    _fetchData();
    _loadUserId();
    fetchAndSetTests();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('id') ??
          userId; // If userId is null, use empty string as default value
    });
  }

  Future<void> _fetchData() async {
    try {
      Response response = await _dio.get("$baseUrl/api/v1/dtmtests/direction/");

      if (response.statusCode == 200) {
        var responseData = response.data;
        if (responseData != null &&
            responseData.containsKey('date') &&
            responseData.containsKey('point')) {
          setState(() {
            jsonDegree = responseData;
          });
        } else {
          print('Error: Date or point not found in response data');
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  _textFromJsonDegree() {
    if (jsonDegree != null && jsonDegree.containsKey('test_id')) {
      var testId = jsonDegree['test_id'];
      if (testId != null && testId.containsKey('subject')) {
        var subject = testId['subject'];
        if (subjectChoices.containsKey(subject)) {
          return "${subjectChoices[subject]} fanidan";
        }
      }
    }
    return "Noma'lum fan";
  }

  bool isLoading = true;

  Future<void> fetchAndSetTests() async {
    try {
      List<DtmDirection> directions = await fetchTests();
      setState(() {
        dtmDirections = directions;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List<DtmDirection>> fetchTests() async {
    Response response = await _dio.get("$baseUrl/api/v1/dtmtests/directions/");

    if (response.statusCode == 200) {
      List<dynamic> jsonList = response.data;
      return jsonList.map((json) => DtmDirection.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  }

  void getReklama() async {
    try {
      // Verify OTP with the backend server
      Response response =
          await Dio().get("$baseUrl/api/v1/dtmtest//testcollections/");
      if (response.statusCode == 200) {
        setState(() {
          jsonImageList = response.data;
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEEFC),
      appBar: AppBar(
        backgroundColor: const Color(0xffEFEEFC),
        title: Text(
          'Home',
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
      body: jsonDegree == null
          ? Padding(
              padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height(context) * 0.09,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: width(context) * 0.5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(listImage[index]),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    jsonDegree != null
                        ? Container(
                            width: width(context) * 0.89,
                            height: height(context) * 0.15,
                            decoration: BoxDecoration(
                                color: blueColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 18),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _textFromJsonDegree(),
                                        style: TextStyle(
                                          color: whiteColor,
                                          fontSize: 5 * devisePixel(context),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      if (jsonDegree != null &&
                                          jsonDegree.containsKey('date'))
                                        Text(
                                          jsonDegree['date'],
                                          style: TextStyle(
                                            color: whiteColor,
                                            fontSize:
                                                4.5 * devisePixel(context),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Bali: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  4.5 * devisePixel(context),
                                              color: const Color(0xffA8B7F7),
                                            ),
                                          ),
                                          if (jsonDegree != null &&
                                              jsonDegree.containsKey('point'))
                                            Text(
                                              "${jsonDegree['point']}",
                                              style: TextStyle(
                                                color: whiteColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    5 * devisePixel(context),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
                                    "87 %",
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontSize: 6.5 * devisePixel(context),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            width: width(context) * 0.89,
                            height: height(context) * 0.15,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: blueColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sizda natijalar mavjud emas :(",
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 5 * devisePixel(context),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 4 * devisePixel(context),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    "Siz testlarimizdan ishlaganingizda shu oynada \noxirgi natijalaringizni ko’rishingiz mumkin bo’ladi. ")
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 28,
                    ),
                    isLoading
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Shimmer.fromColors(
                                baseColor: whiteColor,
                                highlightColor: Colors.grey[200]!,
                                child: SizedBox(
                                  width: width(context) * 0.4,
                                  height: height(context) * 0.03,
                                  child: Card(
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              SizedBox(
                                height: height(context) * 0.23,
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 2,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 1 / 1,
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 15,
                                          crossAxisSpacing: 15),
                                  itemBuilder: (context, index) =>
                                      Shimmer.fromColors(
                                    baseColor: whiteColor,
                                    highlightColor: Colors.grey[200]!,
                                    child: const Card(),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : testlar(),
                    const SizedBox(
                      height: 28,
                    ),
                    university(),
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
              child: _buildLoadingShimmerTests(),
            ),
    );
  }

  Widget testlar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Testlar",
              style: TextStyle(
                fontSize: 6 * devisePixel(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const Tests(),
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
        SizedBox(
          height: height(context) * 0.23,
          child: GridView.builder(
            itemCount: dtmDirections.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1 / 1,
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15),
            itemBuilder: (context, index) {
              final direction = dtmDirections[index];
              return TestWidget(direction.name, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VariantSubject(
                            directionCode: direction.id.toString(),
                            name: direction.name,
                          )),
                );
              });
            },
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }

  Widget university() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Oliygohlar",
              style: TextStyle(
                fontSize: 6 * devisePixel(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const UniverSity(),
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
        SizedBox(
          height: height(context) * 0.15,
          child: GridView.builder(
            itemCount: 2,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2 / 1,
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15),
            itemBuilder: (context, index) => const OliygohlarWidget(
                text: "Toshkent axborot texnologiyalari universiteti",
                image: "assets/images/oliygoh1.png"),
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _buildLoadingShimmerTests() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height(context) * 0.103,
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: whiteColor,
                highlightColor: Colors.grey[200]!,
                child: SizedBox(
                  width: width(context) * 0.5,
                  child: Card(
                    color: whiteColor,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          Shimmer.fromColors(
            baseColor: whiteColor,
            highlightColor: Colors.grey[200]!,
            child: SizedBox(
              width: width(context) * 0.89,
              height: height(context) * 0.15,
              child: Card(
                color: whiteColor,
              ),
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          Shimmer.fromColors(
            baseColor: whiteColor,
            highlightColor: Colors.grey[200]!,
            child: SizedBox(
              width: width(context) * 0.4,
              height: height(context) * 0.03,
              child: Card(
                color: whiteColor,
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          SizedBox(
            height: height(context) * 0.23,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1 / 1,
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15),
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: whiteColor,
                highlightColor: Colors.grey[200]!,
                child: const Card(),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Shimmer.fromColors(
            baseColor: whiteColor,
            highlightColor: Colors.grey[200]!,
            child: SizedBox(
              width: width(context) * 0.4,
              height: height(context) * 0.03,
              child: Card(
                color: whiteColor,
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          SizedBox(
            height: height(context) * 0.23,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2 / 1,
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15),
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: whiteColor,
                highlightColor: Colors.grey[200]!,
                child: const Card(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Post {
  final String subject;
  final int test;

  Post({
    required this.subject,
    required this.test,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(subject: json['subject'], test: json['tests']);
  }
}