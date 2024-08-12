import 'package:talaba_uz/ui/pages/chart/decoration_chart/result_card_chart.dart';
import 'package:talaba_uz/ui/pages/chart/loading_pattern/my_result_loading.dart';

import '../../../utils/tools/file_important.dart';
import 'model/result_id_model.dart';

class MyResults extends StatefulWidget {
  const MyResults({super.key});

  @override
  State<MyResults> createState() => _MyResultsState();
}
class _MyResultsState extends State<MyResults> {
  String? userId;
  final Dio _dio = Dio();
  List<ResultIdModel> _results = [];
  bool _isLoading = true;

  // bool _hasError = false;
  int? mathPoints;
  int? englishPoints;
  int? spSubjects;
  String? currentLocalDate;

  @override
  void initState() {
    super.initState();
    _loadStudentId();
    _allSubjectPoints();
  }


  Future<void> _allSubjectPoints() async {
    var subjectBox = Hive.box('auth');
    spSubjects = await subjectBox.get('Majburiy Fanlar');
    mathPoints = await subjectBox.get('Matematika');
    englishPoints = await subjectBox.get('Xorijiy Til');
  }


  Future<void> _loadStudentId() async {
    var box = Hive.box('auth');
    userId = await box.get('user_id');

    if (userId != null) {
      final results = await _resultId(userId!);
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
      setState(() {
        _isLoading = false;
      });
    }
  }


  Future<List<ResultIdModel>?> _resultId(String userId) async {
    try {
      final response = await _dio.get(
        '$baseUrl/api/v1/dtmtests/result/$userId',
      );

      print('Fetching results for user ID: $userId');
      print('API response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ResultIdModel.fromJson(json)).toList();
      } else {
        print('API response status code: ${response.statusCode}');
        print('API response data: ${response.data}');
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching result ID: $e');
      }
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEEFC),
      body: _isLoading
          ? MyResultLoading()
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width(context) * 0.89,
              height: height(context) * 0.21,
              decoration: BoxDecoration(
                color: blueColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Variant: ${_results.isNotEmpty ? _results.last
                              .testCode : 'N/A'}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 16,
                            color: const Color(0xffffffff),
                            fontFamily: 'Inter-SemiBold',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${_results.isNotEmpty ? _results.last.date : 'N/A'}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 12,
                            color: const Color(0xffffffff),
                            fontFamily: 'Inter-Medium',
                            fontWeight: FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 63,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRowPattern(
                            'Majburiy Fanlar', '${spSubjects} ta'),
                        const SizedBox(height: 10),
                        _buildRowPattern(
                            'Matematika', '${mathPoints} ta'),
                        const SizedBox(height: 10),
                        _buildRowPattern(
                            'Xorijiy til', '${englishPoints} ta'),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 63,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Umumiy ball:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins-Medium',
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: 4),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF264CEC),
                                    // Background color
                                    border: Border.all(
                                      color: Colors.white, // Border color
                                      width: 1, // Border width
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        8), // Match border radius
                                  ),
                                  child: SizedBox(
                                    width: 88,
                                    height: 38,
                                    child: Center(
                                      child: Text(
                                        '${_results.isNotEmpty ? _results.last
                                            .point : 'N/A'}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins-Medium',
                                          fontSize: 16, // Font size
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                      fontFamily: 'Inter-SemiBold'
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.5,
                  child: ListView.separated(
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      final result = _results[index];
                      return ResultCard(
                        testCode: result.testCode,
                        point: result.point,
                        date: result.date,
                        mathPoint: mathPoints ?? 0,
                        englishPoints: englishPoints ?? 0,
                        spSubjectPoint: spSubjects ?? 0,);
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 12),
                  ),
                ),
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

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 4 * devisePixel(context),
              color: whiteColor,
              fontFamily: 'Inter-Medium'),
        ),
        Padding(
          padding: EdgeInsets.only(left: 39),
          child: Text(
            value,
            style: TextStyle(
                color: whiteColor,
                fontSize: 10,
                fontFamily: 'Inter-Medium'),
          ),
        ),
      ],
    );
  }

  Widget _buildRowPattern(String label, String value) {
    return SizedBox(
      width: 140,
      height: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xffffffff),
              fontFamily: 'Inter-Medium',
              fontWeight: FontWeight.normal,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 14,
              color: Color(0xffffffff),
              fontFamily: 'Inter-Medium',
              fontWeight: FontWeight.normal,
            ),

            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

}

// old

//Positioned(
//                     right: 20,
//                     top: 63,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text(
//                                 'Umumiy ball:',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontFamily: 'Poppins',
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.normal,
//                                 ),
//                               ),
//                               SizedBox(height: 4),
//                               Align(
//                                 alignment: Alignment.center,
//                                 child: SizedBox(
//                                   width: 73,
//                                   height: 28,
//                                   child: DecoratedBox(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(8),
//                                       border: Border.all(
//                                         color: Colors.white,
//                                         width: 1,
//                                       ),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
//                                       child: Center(
//                                         child: Text(
//                                           '100',
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontFamily: 'Poppins',
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.normal,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   )
