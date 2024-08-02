import 'package:talaba_uz/services/model/responses/dtm_test_code.dart';
import 'package:talaba_uz/ui/pages/diagnost/diagnost/page_navigation/page_navigation_widget.dart';

import '../../../../utils/tools/file_important.dart';

class DiagnosticTest extends StatefulWidget {
  final String dtmTestCode;

  const DiagnosticTest({super.key, required this.dtmTestCode});

  @override
  State<DiagnosticTest> createState() => _DiagnosticTestState();
}

class _DiagnosticTestState extends State<DiagnosticTest> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;
  final Map<String, Map<int, int>> _selectedAnswerIndices = {};
  int totalSections = 0;
  List<SpecialTests> specialTests = [];
  List<SubjectTests> subjectTests = [];
  bool _isLoading = true;
  List<String> eachSubject = [];

  @override
  void initState() {
    super.initState();
    _fetchTests();
  }

  Future<void> _fetchTests() async {
    final apiService = ApiService();
    final data = await apiService.dtmTestCollection(widget.dtmTestCode);

    if (data != null) {
      setState(() {
        specialTests = data.specialTests.cast<SpecialTests>();
        subjectTests = data.subjectTests.cast<SubjectTests>();
        totalSections = specialTests.length + subjectTests.length;
        eachSubject = [
          ...specialTests.map((test) => test.specialQuestion.subjectCode),
          ...subjectTests.map((test) => test.question.subjectCode),
        ].toSet().toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onNextPage() {
    if (_selectedIndex < eachSubject.length - 1) {
      setState(() {
        _selectedIndex++;
      });
      _pageController.animateToPage(
        _selectedIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPreviousPage() {
    if (_selectedIndex > 0) {
      setState(() {
        _selectedIndex--;
      });
      _pageController.animateToPage(
        _selectedIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onMenuItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onAnswerSelected(
      String section, int questionIndex, int selectedIndex, bool isAnswer) {
    setState(() {
      if (!_selectedAnswerIndices.containsKey(section)) {
        _selectedAnswerIndices[section] = {};
      }
      _selectedAnswerIndices[section]![questionIndex] = selectedIndex;
      // Check if the selected answer is correct
      if (isAnswer) {
        print('true $questionIndex $section');
      } else {
        print('false $questionIndex $section');
      }
    });
  }

  double _calculateCorrectAnswers() {
    double correctAnswers = 0.0;

    for (var entry in _selectedAnswerIndices.entries) {
      String section = entry.key;
      Map<int, int> questionIndices = entry.value;

      for (var questionEntry in questionIndices.entries) {
        // int questionIndex = questionEntry.key;
        int selectedIndex = questionEntry.value;

        if (specialTests.any((test) =>
            test.specialQuestion.subjectCode == section &&
            test.options[selectedIndex].isAnswer)) {
          correctAnswers += 1.1;
        } else if (subjectTests.any((test) =>
            test.question.subjectCode == section &&
            test.question.subjectCode == 'math' &&
            test.options[selectedIndex].isAnswer)) {
          correctAnswers += 3.1;
        } else if (subjectTests.any((test) =>
            test.question.subjectCode == section &&
            test.question.subjectCode == 'english' &&
            test.options[selectedIndex].isAnswer)) {
          correctAnswers += 2.1;
        }
      }
    }

    return double.parse(correctAnswers.toStringAsFixed(2));
  }

  int _calculateCorrectAnswersForSpHistory() {
    int correctAnswers = 0;
    for (var entry in _selectedAnswerIndices.entries) {
      String section = entry.key;
      if (section == 'sp_history') {
        Map<int, int> questionIndices = entry.value;

        for (var questionEntry in questionIndices.entries) {
          int selectedIndex = questionEntry.value;
          if (specialTests.any((test) =>
              test.specialQuestion.subjectCode == 'sp_history' &&
              test.options[selectedIndex].isAnswer)) {
            correctAnswers++;
          }
        }
      }
    }
    return correctAnswers;
  }

  int _calculateCorrectAnswersForSpMath() {
    int correctAnswers = 0;
    for (var entry in _selectedAnswerIndices.entries) {
      String section = entry.key;
      if (section == 'sp_math') {
        Map<int, int> questionIndices = entry.value;

        for (var questionEntry in questionIndices.entries) {
          int selectedIndex = questionEntry.value;
          if (specialTests.any((test) =>
          test.specialQuestion.subjectCode == 'sp_math' &&
              test.options[selectedIndex].isAnswer)) {
            correctAnswers++;
          }
        }
      }
    }
    return correctAnswers;
  }

  int _calculateCorrectAnswersForSpMotherLang() {
    int correctAnswers = 0;
    for (var entry in _selectedAnswerIndices.entries) {
      String section = entry.key;
      if (section == 'sp_motherlang') {
        Map<int, int> questionIndices = entry.value;

        for (var questionEntry in questionIndices.entries) {
          int selectedIndex = questionEntry.value;
          if (specialTests.any((test) =>
              test.specialQuestion.subjectCode == 'sp_motherlang' &&
              test.options[selectedIndex].isAnswer)) {
            correctAnswers++;
          }
        }
      }
    }
    return correctAnswers;
  }

  int _calculateSpSubjectTestAnswers() {
    int correctAnswers = 0;

    for (var entry in _selectedAnswerIndices.entries) {
      String section = entry.key;
      Map<int, int> questionIndices = entry.value;

      for (var questionEntry in questionIndices.entries) {
        int selectedIndex = questionEntry.value;

        if (specialTests.any((test) =>
            test.specialQuestion.subjectCode == section &&
            test.options[selectedIndex].isAnswer)) {
          correctAnswers += 1; // Add 1 point for each correct answer
        }
      }
    }

    return correctAnswers;
  }

  // int _calculateCorrectAnswersForSpSubject(String subjectCode){
  //   int correctAnswers = 0;
  //   for(var entry in _selectedAnswerIndices.entries){
  //   String section = entry.key;
  //   if(section == subjectCode){
  //     Map<int, int> questionIndices = entry.value;
  //
  //     for(var questionEntry in questionIndices.entries){
  //       int selectedIndex = questionEntry.value;
  //       if(specialTests.any((test) =>
  //          test.specialQuestion.subjectCode == subjectCode &&
  //          test.options[selectedIndex].isAnswer)){
  //         correctAnswers++;
  //       }
  //     }
  //   }
  //   }
  //   return correctAnswers;
  // }


// Logic for math subjects
  int _calculateMathAnswers() {
    int correctAnswers = 0;

    for (var entry in _selectedAnswerIndices.entries) {
      String section = entry.key;
      Map<int, int> questionIndices = entry.value;

      for (var questionEntry in questionIndices.entries) {
        int selectedIndex = questionEntry.value;

        if (subjectTests.any((test) =>
            test.question.subjectCode == section &&
            test.question.subjectCode == 'math' &&
            test.options[selectedIndex].isAnswer)) {
          correctAnswers += 1; // Add 1 point for each correct answer
        }
      }
    }

    return correctAnswers;
  }

// Logic for english subjects
  int _calculateEnglishAnswers() {
    int correctAnswers = 0;

    for (var entry in _selectedAnswerIndices.entries) {
      String section = entry.key;
      Map<int, int> questionIndices = entry.value;

      for (var questionEntry in questionIndices.entries) {
        int selectedIndex = questionEntry.value;

        if (subjectTests.any((test) =>
            test.question.subjectCode == section &&
            test.question.subjectCode == 'english' &&
            test.options[selectedIndex].isAnswer)) {
          correctAnswers += 1; // Add 1 point for each correct answer
        }
      }
    }

    return correctAnswers;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Extract unique subjects from both specialTests and subjectTests
    List<String> subjects = [
      ...specialTests.map((test) => test.specialQuestion.subjectCode),
      ...subjectTests.map((test) => test.question.subjectCode),
    ].toSet().toList();

    // Determine current subject based on selected index
    String currentSubject =
        (subjects.isNotEmpty && _selectedIndex < subjects.length)
            ? subjects[_selectedIndex]
            : '';

    // Filter tests based on current subject
    List<dynamic> currentTests = [
      ...specialTests
          .where((test) => test.specialQuestion.subjectCode == currentSubject),
      ...subjectTests
          .where((test) => test.question.subjectCode == currentSubject),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEEEDFB),
        appBar: AppBar(
          backgroundColor: const Color(0xFFEEEDFB),
          title: const Text(
            "Diagnostik test",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Inter-Bold',
              color: Color(0xFF1E1E1E),
            ),
          ),
          centerTitle: true,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 54, left: 53),
                      child: SizedBox(
                          height: 34,
                          child: PageNavigationWidget(
                            pageController: _pageController,
                            selectedIndex: _selectedIndex,
                            subjects: subjects,
                            onNext: _onNextPage,
                            onPrevious: _onPreviousPage,
                          )),
                    ),
                    const SizedBox(height: 26),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: MenuWidget(
                        selectedIndex: _selectedIndex,
                        onMenuItemTap: _onMenuItemTap,
                        subjects: subjects,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            currentSubject.isNotEmpty
                                ? currentSubject[0].toUpperCase() +
                                    currentSubject.substring(1).toLowerCase()
                                : '',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins-Medium'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        children: [
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: currentTests.length,
                            itemBuilder: (context, index) {
                              final test = currentTests[index];
                              final isSpecialTest = test is SpecialTests;
                              final options = isSpecialTest
                                  ? (test as SpecialTests).options
                                  : (test as SubjectTests).options;
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 12.0,
                                  left: 18.0,
                                  right: 10,
                                ),
                                child: TestCard(
                                  question:
                                      '${index + 1}. ${isSpecialTest ? (test as SpecialTests).specialQuestion.text : (test as SubjectTests).question.text}',
                                  answers: options.map((e) => e.text).toList(),
                                  onAnswerSelected: (selectedIndex) {
                                    setState(() {
                                      final selectedOption =
                                          options[selectedIndex];
                                      _onAnswerSelected(
                                        isSpecialTest
                                            ? (test as SpecialTests)
                                                .specialQuestion
                                                .subjectCode
                                            : (test as SubjectTests)
                                                .question
                                                .subjectCode,
                                        index,
                                        selectedIndex,
                                        selectedOption.isAnswer,
                                      );
                                    });
                                  },
                                  selectedIndex: _selectedAnswerIndices[
                                          isSpecialTest
                                              ? (test as SpecialTests)
                                                  .specialQuestion
                                                  .subjectCode
                                              : (test as SubjectTests)
                                                  .question
                                                  .subjectCode]?[index] ??
                                      -1,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),
                    if (_selectedIndex == subjects.length - 1)
                      FinishButton(onPressed: () {
                        _handleFinishButtonPress();
                      }),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _handleFinishButtonPress() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final apiService = ApiService();
      DtmTestCode? result =
          await apiService.dtmTestCollection(widget.dtmTestCode);

      if (result != null) {
        if (mounted) {
          double point = _calculateCorrectAnswers(); // receive
          print('Total Correct Answers: $point');
          int subjectSpPoints = _calculateSpSubjectTestAnswers();
          int spHistoryPoints = _calculateCorrectAnswersForSpHistory();
          int spMathPoints = _calculateCorrectAnswersForSpMath();
          int spMotherLangPoints = _calculateCorrectAnswersForSpMotherLang();
          int mathPoints = _calculateMathAnswers();
          int englishPoints = _calculateEnglishAnswers();

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setDouble('point', point);
          await prefs.setString('test_code', widget.dtmTestCode);
          await prefs.setInt('O\'zbekiston tarixi', spHistoryPoints);
          await prefs.setInt('Matematika Majburiy', spMathPoints);
          await prefs.setInt('Ona tili', spMotherLangPoints);
          await prefs.setInt('Matematika', mathPoints);
          await prefs.setInt('Xorijiy Til', englishPoints);
          await prefs.setInt('Majburiy Fanlar', subjectSpPoints);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => GeneralResult(), // Remove const here
            ),
            (route) => false,
          );
        }
      } else {
        // Handle the case where the API result is null
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to finish the test. Please try again."),
          ),
        );
      }
    } catch (e) {
      // Handle any errors
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("An error occurred. Please try again."),
        ),
      );
    } finally {
      // Ensure loading state is reset
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

// new updated
