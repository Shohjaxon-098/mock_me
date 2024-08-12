import 'package:talaba_uz/utils/tools/file_important.dart';

import 'loading_pattern/general_results_shimmer.dart';
import 'model/result_id_model.dart';

class GeneralResults extends StatefulWidget {
  const GeneralResults({super.key});

  @override
  State<GeneralResults> createState() => _GeneralResultsState();
}

class _GeneralResultsState extends State<GeneralResults> {
  String? firstName;
  String? lastName;
  String? userId;
  int? studentId;
  String? testCode;
  final Dio _dio = Dio();
  List<ResultIdModel> _results = [];
  bool _isLoading = true;
  String? imagePathPic;

  Future<void> _loadNameUser() async {
    var nameBox = await Hive.box('auth');
    firstName = nameBox.get('name');
    lastName = nameBox.get('surname');
    setState(() {});
  }

  Future<void> _fetchUserId() async {
    var box = await Hive.box('auth');
    userId = box.get('user_id'); // Fetch userId from Hive
    studentId = box.get('student_id');
    testCode = box.get('test_code');
    setState(() {
      // Make sure userId is set before proceeding
      _studentId(); // Fetch studentId related data if needed
    });
  }

  Future<void> _studentId() async {
    if (userId != null && studentId != null && testCode != null) {
      final userIdInt = int.tryParse(userId!); // Convert userId to int
      if (userIdInt != null) {
        final results = await _resultId(userIdInt); // Use userId here
        if (results != null) {
          setState(() {
            _results = results;
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        print('Invalid userId format');
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<List<ResultIdModel>?> _resultId(int userId) async {
    try {
      final response = await _dio.get('$baseUrl/api/v1/dtmtests/result/$userId');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        List<ResultIdModel> results = data
            .map((json) => ResultIdModel.fromJson(json))
            .toList();



        return results;


      } else {
        print('API response status code: ${response.statusCode}');
        print('API response data: ${response.data}');
        return null;
      }
    } catch (e) {
      print('Error fetching result ID: $e');
      return null;
    }
  }

  Future<void> _loadProfileImage() async {
    var box = await Hive.openBox('auth');
    imagePathPic = box.get('image_path');

  }

  @override
  void initState() {
    super.initState();
    _loadNameUser();
    _fetchUserId(); // Fetch userId and related data
    _loadProfileImage();
  }

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
      body: _isLoading
          ? GeneralShimmerResult()
          : Column(
        children: [
          /// Tab Bar
          SizedBox(
            height: height(context) * 0.037,
            child: ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: _results.length,
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
                          color:
                          current == index ? blueColor : Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _results[index].date,
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
              itemCount: _results.length,
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final result = _results[index];
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
                                AssetImage(imagePathPic ?? "assets/images/oliygoh1.png"),
                                "$firstName $lastName",
                                "5-o`rin",
                                "Matematika",
                                "${result.point} ball",
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
                                    left: index + 1 >= 10 ? 4 : 12,
                                    right: 12),
                                child: const CircleAvatar(
                                  radius: 14,
                                ),
                              ),
                              Text(
                                "$firstName $lastName",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 4.5 * devisePixel(context),
                                ),
                              ),
                              const Spacer(),
                              index + 1 == 1
                                  ? Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.58),
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
                                  height:
                                  height(context) * 0.02,
                                ),
                              )
                                  : index + 1 == 3
                                  ? Padding(
                                padding:
                                const EdgeInsets.only(
                                    right: 10.58),
                                child: Image.asset(
                                  "assets/images/firstMedal.png",
                                  width:
                                  width(context) * 0.04,
                                  height: height(context) *
                                      0.02,
                                ),
                              )
                                  : const SizedBox(),
                              Text(
                                "${result.point} ball",
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
      ImageProvider image, // Update to ImageProvider type
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
                    CircleAvatar(
                      radius: 14,
                      backgroundImage: image, // This now accepts ImageProvider
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


// Future<void> _dialogBuilder(
//     File image, // Use ImageProvider type
//     String name,
//     String place,
//     String subject,
//     String point,
//     String allQues,
//     String trueQue,
//     String falseQue,
//     ) {
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         surfaceTintColor: whiteColor,
//         backgroundColor: whiteColor,
//         content: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           width: 255,
//           height: 192,
//           padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 14,
//                     backgroundImage: image, // Use ImageProvider here
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           name,
//                           style: TextStyle(
//                             fontSize: 4.5 * devisePixel(context),
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Text(
//                           place,
//                           style: TextStyle(
//                             color: blueColor,
//                             fontSize: 4.5 * devisePixel(context),
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Spacer(),
//                   Text(
//                     "$point ball",
//                     style: TextStyle(
//                       color: blueColor,
//                       fontSize: 4.5 * devisePixel(context),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     "Fan: ",
//                     style: TextStyle(
//                       color: Colors.black38,
//                       fontSize: 4.5 * devisePixel(context),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Text(
//                     subject,
//                     style: TextStyle(
//                       fontSize: 4.5 * devisePixel(context),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Umumiy savollar",
//                     style: TextStyle(
//                       fontSize: 4.5 * devisePixel(context),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     allQues,
//                     style: TextStyle(
//                       fontSize: 4.5 * devisePixel(context),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "To’g’ri javoblar",
//                     style: TextStyle(
//                       fontSize: 4.5 * devisePixel(context),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     trueQue,
//                     style: TextStyle(
//                       fontSize: 4.5 * devisePixel(context),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Noto’g’ri javoblar",
//                     style: TextStyle(
//                       fontSize: 4.5 * devisePixel(context),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     falseQue,
//                     style: TextStyle(
//                       fontSize: 4.5 * devisePixel(context),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
}
