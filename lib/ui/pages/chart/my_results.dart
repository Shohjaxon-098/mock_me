import 'package:talaba_uz/ui/pages/chart/decoration_chart/result_card_chart.dart';

import '../../../utils/tools/file_important.dart';
import 'model/result_id_model.dart';

class MyResults extends StatefulWidget {
  const MyResults({super.key});

  @override
  State<MyResults> createState() => _MyResultsState();
}

class _MyResultsState extends State<MyResults> {

  late Future<ResultIdModel?> _results;



  @override
  void initState() {
    super.initState();
//    _results = _fetchResults() ; // Initialize with the fetch method
  }

  // Future<ResultIdModel?> _fetchResults() async {
  //   try {
  //     final apiService = ApiService();
  //     final resultData = await apiService.resultId('5'); // Replace with actual ID
  //
  //     if (resultData != null) {
  //       return resultData;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     // Handle errors here
  //     print('Error fetching results: $e');
  //     return null;
  //   }
  // }
  //


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
                          'Variant: 1234556',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 16,
                            color: const Color(0xffffffff),
                            fontFamily: 'Inter-SemiBold',
                            fontWeight: FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '12.11.2024',
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
                        _buildInfoRow(
                            'Majburiy Fanlar', '25 ta', width(context) * 0.07),
                        const SizedBox(height: 5),
                        _buildInfoRow(
                            'Matematika', '27 ta', width(context) * 0.1),
                        const SizedBox(height: 5),
                        _buildInfoRow(
                            'Xorijiy til', '30 ta', width(context) * 0.07),
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
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: 4),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF264CEC), // Background color
                                    border: Border.all(
                                      color: Colors.white, // Border color
                                      width: 1, // Border width
                                    ),
                                    borderRadius: BorderRadius.circular(8), // Match border radius
                                  ),
                                  child: SizedBox(
                                    width: 88,
                                    height: 38,
                                    child: Center(
                                      child: Text(
                                        '100',
                                        style: TextStyle(
                                          color: Colors.white, // Text color
                                          fontSize: 12, // Font size
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
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ResultCard(),
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

  Widget _buildInfoRow(String label, String value, double padding) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 4.5 * devisePixel(context),
              color: whiteColor,
              fontFamily: 'Inter-Medium'),
        ),
        Padding(
          padding: EdgeInsets.only(left: padding),
          child: Text(
            value,
            style: TextStyle(
                color: whiteColor,
                fontSize: 4.5 * devisePixel(context),
                fontFamily: 'Inter-Medium'),
          ),
        ),
      ],
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
