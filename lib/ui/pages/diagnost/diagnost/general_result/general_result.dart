
import 'package:talaba_uz/ui/pages/diagnost/diagnost/loading_patterns/result_loading_pattern.dart';

import '../../../../../utils/tools/file_important.dart';
import 'build_section.dart';

class GeneralResult extends StatefulWidget {
  const GeneralResult({super.key});
  @override
  State<GeneralResult> createState() => _GeneralResultState();
}

class _GeneralResultState extends State<GeneralResult> {
  bool isExpanded = false;
  ResultDtmModel? resultDtmModel;
  bool isLoading = true;
  String errorMessage = '';

  int? studentId;
  String? testCode;
  double? points;
  String? currentLocalDate;

  final ApiService apiService = ApiService();

  int? remainingTime;
  int nationalHistory = 0;
  int mathSpSubject = 0;
  int motherLangSubject = 0;
  int mathSubject = 0;
  int englishSubject = 0;
  int spSubjectPoints = 0;


  Future<void> _fetchData() async {
    var box = Hive.box('auth');
    studentId = box.get('student_id');
    testCode = box.get('test_code');
    points = box.get('point');
    currentLocalDate = box.get('date');

    // Retrieve subject points from Hive
    nationalHistory = box.get('O\'zbekiston tarixi', defaultValue: 0);
    mathSpSubject = box.get('Matematika Majburiy', defaultValue: 0);
    motherLangSubject = box.get('Ona tili', defaultValue: 0);
    mathSubject = box.get('Matematika', defaultValue: 0);
    englishSubject = box.get('Xorijiy Til', defaultValue: 0);
    spSubjectPoints = box.get('Majburiy Fanlar', defaultValue: 0);

    // Fetch results from API
    // Ensure no null values are passed to the API
    if (studentId != null && testCode != null && points != null && currentLocalDate != null) {
      print('One or more values are null: studentId=$studentId, testCode=$testCode, points=$points, currentLocalDate=$currentLocalDate');
      print('Retrieved studentId: $studentId');
      // Fetch results from API
      final result = await apiService.resultOfTest(
        studentId!,
        testCode!,
        points!,
        currentLocalDate!,
      );

      if (result != null) {
        setState(() {
          studentId = result['student_id'];
          testCode = result['test_code'];
          points = result['point'];
          currentLocalDate = result['date'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // Handle the case where one or more values are null
      print('One or more values are null: studentId=$studentId, testCode=$testCode, points=$points, currentLocalDate=$currentLocalDate');
      setState(() {
        isLoading = false;
      });
    }
  }





  @override
  void initState() {
    super.initState();
    _fetchData();
    loadRemainingTime();
  }


  Future<void> loadRemainingTime() async {
    final prefs = await SharedPreferences.getInstance();
    final time = prefs.getInt('remainingTime'); // Get the saved remaining time
    setState(() {
      remainingTime = time ?? 0; // Provide a default value if null
    });
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    return "$hours soat ${minutes} minut";
  }

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
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
          ? ResultLoadingPattern()
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
                            'Test raqami: #${testCode}',
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
                                'Sarflangan vaqt:',
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
                                '${formatTime(remainingTime ?? 0)}', // Use default value if null
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
                            title: 'Majburiy Fanlar',
                            count: '$spSubjectPoints ta',
                            iconClosed: Icons.chevron_right,
                            iconOpened: Icons.expand_more,
                            isExpanded: isExpanded,
                            onTap: toggleExpanded,
                          ),
                          if (isExpanded) ...[
                            buildSubject(title: 'O\'zbekiston tarihi', count: '$nationalHistory ta'),
                            buildSubject(title: 'Matematika', count: '$mathSpSubject ta'),
                            buildSubject(title: 'Ona tili', count: '$motherLangSubject ta'),
                          ],
                          buildSecondSection(
                            title: 'Matematika',
                            count: '$mathSubject ta',
                          ),
                          buildSecondSection(
                            title: 'Xorijiy til',
                            count: '$englishSubject ta',
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
                                    '${points}',
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

// need to send them