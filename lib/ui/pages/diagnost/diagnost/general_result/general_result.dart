
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

  double _points = 0.0;
  String _testCode = '';
  int? remainingTime;
  int nationalHistory = 0;
  int mathSpSubject = 0;
  int motherLangSubject = 0;
  int mathSubject = 0;
  int englishSubject = 0;
  int spSubjectPoints = 0;
  @override
  void initState() {
    super.initState();
    fetchResult();
    _loadDtmTestCode(); // Initialize testCode and fetch result here
    _loadPoints();
    loadRemainingTime();
    _loadSpHistory();
    _loadSpMathPoints();
    _loadSpMotherPoints();
    _loadMathSubject();
    _loadEnglishSubject();
    _loadSpSubjectPoint();
  }

  Future<void> fetchResult() async {
    setState(() {
      isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int studentId = prefs.getInt('student_id') ?? 0;
      String testCode = prefs.getString('test_code') ?? '';
      double point = prefs.getDouble('point') ?? 0.0;
      String date = prefs.getString('date') ?? '';

      bool isResultFetched = await ApiService().resultTestDtm(
        studentId,
        testCode,
        point,
        date,
      );

      if (isResultFetched) {
        setState(() {
          _testCode = testCode;
          _points = point;
          resultDtmModel = ResultDtmModel(
            studentId: studentId,
            testCode: testCode,
            point: point,
            date: date,
          );
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Xatolik bor. Ko`rib chiqing"),
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Xatolik: $e"),
        ),
      );
    }
  }

  Future<void> _loadPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _points = prefs.getDouble('point') ?? 0.0;
    });
  }


  Future<void> _loadSpMotherPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      motherLangSubject = prefs.getInt('Ona tili') ?? 0;
    });
  }

  Future<void> _loadSpMathPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mathSpSubject = prefs.getInt('Matematika Majburiy') ?? 0;
    });
  }

  Future<void> _loadSpHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nationalHistory = prefs.getInt('O\'zbekiston tarixi') ?? 0;
    });
  }

  Future<void> _loadMathSubject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mathSubject = prefs.getInt('Matematika') ?? 0;
    });
  }

  Future<void> _loadEnglishSubject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      englishSubject = prefs.getInt('Xorijiy Til') ?? 0;
    });
  }

  Future<void> _loadSpSubjectPoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      spSubjectPoints = prefs.getInt('Majburiy Fanlar') ?? 0;

    });
  }



  Future<void> _loadDtmTestCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _testCode = prefs.getString('test_code') ?? '';
    });
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
          ? Center(child: CircularProgressIndicator.adaptive(),)
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
                            'Test raqami: #${_testCode}',
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
                                    '${_points.toStringAsFixed(2)}',
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