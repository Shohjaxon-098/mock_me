import 'package:talaba_uz/ui/pages/diagnost/general_result/custom_button_pattern.dart';

import '../../../../services/model/responses/result_dtm_model.dart';
import '../../../../utils/tools/file_important.dart';
import 'build_section.dart';

class GeneralResult extends StatefulWidget {
  const GeneralResult({super.key});
  @override
  State<GeneralResult> createState() => _GeneralResultState();
}

class _GeneralResultState extends State<GeneralResult> {
  bool isExpanded = false;
  ResultDtmModel? resultDtmModel;
  final Dio _dio = Dio();
  bool isLoading = true;
  String errorMessage = '';

  Future<void> fetchResult() async {
    try {
      final response = await _dio.post('$baseUrl/api/v1/dtmtests/result/');

      //Log response status and data for debugging
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        setState(() {
          resultDtmModel = ResultDtmModel.fromJson(response.data);
          isLoading = false;
        });
        print(response.data);
      } else {
        // Handle unexpected status codes
        setState(() {
          errorMessage =
              'Failed to load data. Status code: ${response.statusCode}';
          isLoading = false;
        });
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEEFC),
      appBar: AppBar(
        backgroundColor: Color(0xFFEFEEFC),
        title: Text(
          "Umumiy natijalar",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: ListView(
                      children: [
                        Card(
                          color: Color(0xFFFFFFFF),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Test raqami: #${resultDtmModel?.testCode ?? ''}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF264CEC),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Text(
                                      'Yo’nalish:',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xCC1E1E1E),
                                        fontWeight: FontWeight.normal,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Aniq fanlar (iqtisod)',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF1E1E1E),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Text(
                                      'Ajratilgan vaqt:',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xCC1E1E1E),
                                        fontWeight: FontWeight.normal,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      '3 soat',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF1E1E1E),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Card(
                          color: Colors.white,
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                buildSection(
                                  title: 'Majburiy fanlar',
                                  count: '35 ta',
                                  iconClosed: Icons.chevron_right,
                                  iconOpened: Icons.expand_more,
                                  isExpanded: isExpanded,
                                  onTap: toggleExpanded,
                                ),
                                if (isExpanded) ...[
                                  buildSubject(
                                      title: 'Ona tili', count: '10 ta'),
                                  buildSubject(
                                      title: 'Matematika', count: '14 ta'),
                                  buildSubject(
                                      title: 'O\'zbekiston tarihi',
                                      count: '11 ta'),
                                ],
                                buildSection(
                                  title: 'Matematika',
                                  count: '28 ta',
                                  isExpanded: false,
                                ),
                                buildSection(
                                  title: 'Xorijiy til',
                                  count: '30 ta',
                                  isExpanded: false,
                                ),
                                SizedBox(height: 16),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xFF264CEB), width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Umumiy ball',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF264CEB),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '${resultDtmModel?.point ?? 0}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF264CEB),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomButtonPattern(onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false,
                  );
                }),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
    );
  }
}
