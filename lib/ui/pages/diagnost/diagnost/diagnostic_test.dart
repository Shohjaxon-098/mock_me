import 'package:talaba_uz/services/model/responses/dtm_test_code.dart';
import 'package:talaba_uz/ui/pages/diagnost/diagnost/loading_patterns/test_loading_pattern.dart';
import 'package:talaba_uz/ui/pages/diagnost/diagnost/page_navigation/page_navigation_widget.dart';

import '../../../../utils/tools/file_important.dart';
import 'package:intl/intl.dart';

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

  String currentLocalDate = "";

  @override
  void initState() {
    super.initState();
    _fetchTests();
    _updateCurrentDate();
    _cacheSubjectQuestionCounts();
    _calculateMostSolvedSubject();
    _calculateAndCacheSpSubjectTestAnswers();
    _calculateAndCacheMathAnswers();
    _calculateAndCacheEnglishAnswers();
  }

  void _updateCurrentDate() async {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    var box = await Hive.openBox('date');
    setState(() {
      currentLocalDate = formatter.format(now);
      print('Current Date: $currentLocalDate');
      box.put('date', currentLocalDate);
    });
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

  String _calculateMostSolvedSubject(){
    Map<String, int> subjectQuestionCount = {};

    // Count the number of questions solved for each subject in specialTests
    for(var test in specialTests){
      String subject = test.specialQuestion.subjectCode;
      subjectQuestionCount[subject] = (subjectQuestionCount[subject] ?? 0) + 1;
    }

    // Count the number of questions solved for each subject in subjectTests
    for(var test in subjectTests){
      String subject = test.question.subjectCode;
      subjectQuestionCount[subject] = (subjectQuestionCount[subject] ?? 0) + 1;
    }

    String mostSolvedSubject = '';
    int maxQuestions = 0;
    subjectQuestionCount.forEach((subject, count){
      if(count > maxQuestions) {
        maxQuestions = count;
        mostSolvedSubject = subject;
      }

    });

    var box = Hive.box('auth');
    box.put('mostSolvedSubject', mostSolvedSubject);

    return mostSolvedSubject;
  }


  Future<void> _calculateAndCacheSpSubjectTestAnswers() async {
    int correctAnswers = _calculateSpSubjectTestAnswers();


    // Get the current date
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    String currentLocalDate = formatter.format(now);

    // Open Hive box for storing results
    var box = await Hive.box('auth');

    await box.put('spSubjectTestAnswers_$currentLocalDate', correctAnswers);
    print('Special Subject Test Answers for $currentLocalDate: $correctAnswers');
  }

  Future<void> _calculateAndCacheMathAnswers() async {
    int correctAnswers = _calculateMathAnswers();

    // Get the current date
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    String currentLocalDate = formatter.format(now);

    // Open Hive box for storing results
    var box = await Hive.box('auth');

    // Cache the correct answers with date as part of the key
    await box.put('mathAnswers_$currentLocalDate', correctAnswers);
    print('Math Answers for $currentLocalDate: $correctAnswers');
  }

  Future<void> _calculateAndCacheEnglishAnswers() async {
    int correctAnswers = _calculateEnglishAnswers();

    // Get the current date
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    String currentLocalDate = formatter.format(now);

    // Open Hive box for storing results
    var box = await Hive.box('auth');

    // Cache the correct answers with date as part of the key
    await box.put('englishAnswers_$currentLocalDate', correctAnswers);

    print('English Answers for $currentLocalDate: $correctAnswers');
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
            ? TestLoadingPattern()
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
          int totalCorrectAnswers = _calculateTotalCorrectAnswers();
          int totalFalseAnswers = _calculateTotalInCorrectAnswers();
          var box = await Hive.box('auth');

          await box.put('point', point);
          await box.put('test_code', widget.dtmTestCode);
          await box.put('O\'zbekiston tarixi', spHistoryPoints);
          await box.put('Matematika Majburiy', spMathPoints);
          await box.put('Ona tili', spMotherLangPoints);
          await box.put('Matematika', mathPoints);
          await box.put('Xorijiy Til', englishPoints);
          await box.put('Majburiy Fanlar', subjectSpPoints);
          await box.put('To\'g\'ri javoblar', totalCorrectAnswers);
          await box.put('Noto\'g\'ri javoblar', totalFalseAnswers);
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


  int _calculateTotalCorrectAnswers(){
    int correctAnswers = 0;

    // Calculate correct answers in specialTests
    for(var entry in _selectedAnswerIndices.entries){
      String section = entry.key;
      Map<int, int> questionIndices = entry.value;

      for(var questionEntry in questionIndices.entries){
        int selectedIndex = questionEntry.value;
        if(specialTests.any((test) =>
        test.specialQuestion.subjectCode == section &&
            test.options[selectedIndex].isAnswer)){
          correctAnswers++;
        }
      }
    }

    // Calculate correct answers in subjectTests
    for(var entry in _selectedAnswerIndices.entries){
      String section = entry.key;
      Map<int, int> questionIndices = entry.value;


      for(var questionEntry in questionIndices.entries){
        int selectedIndex = questionEntry.value;

        if(subjectTests.any((test) =>
        test.question.subjectCode == section &&
            test.options[selectedIndex].isAnswer)){
          correctAnswers++;
        }
      }
    }

    return correctAnswers;
  }


  int _calculateTotalInCorrectAnswers(){
    int inCorrectAnswers = 0;

    // Calculate incorrect answers in specialTests
    for(var entry in _selectedAnswerIndices.entries){
      String section = entry.key;
      Map<int, int> questionIndices = entry.value;

      for(var questionEntry in questionIndices.entries){
        int selectedIndex = questionEntry.value;

        if(specialTests.any((test) =>
        test.specialQuestion.subjectCode == section &&
            !test.options[selectedIndex].isAnswer)){
          inCorrectAnswers++;
        }
      }
    }

    // Calculate incorrect answers in subjectTests
    for(var entry in _selectedAnswerIndices.entries){
      String section = entry.key;
      Map<int, int> questionIndices = entry.value;

      for(var questionEntry in questionIndices.entries){
        int selectedIndex = questionEntry.value;

        if(subjectTests.any((test) =>
        test.question.subjectCode == section &&
            !test.options[selectedIndex].isAnswer)){
          inCorrectAnswers++;
        }
      }
    }

    return inCorrectAnswers;
  }

  Future<void> _cacheSubjectQuestionCounts() async {
    Map<String, int> subjectQuestionCount = {};

    // Count the number of questions solved for each subject in specialTests
    for (var test in specialTests) {
      String subject = test.specialQuestion.subjectCode;
      if (test.options.any((option) => option.isAnswer)) {
        subjectQuestionCount[subject] = (subjectQuestionCount[subject] ?? 0) + 1;
      }
    }

    // Count the number of questions solved for each subject in subjectTests
    for (var test in subjectTests) {
      String subject = test.question.subjectCode;
      if (test.options.any((option) => option.isAnswer)) {
        subjectQuestionCount[subject] = (subjectQuestionCount[subject] ?? 0) + 1;
      }
    }

    // Determine the subject with the most questions solved
    String mostSolvedSubject = '';
    int maxQuestions = 0;
    subjectQuestionCount.forEach((subject, count) {
      if (count > maxQuestions) {
        maxQuestions = count;
        mostSolvedSubject = subject;
      }
    });

    // Cache the most solved subject and its count using Hive
    var box = await Hive.openBox('auth');
    await box.put('mostSolvedSubject', mostSolvedSubject);
    await box.put('mostSolvedSubjectCount', maxQuestions);

    // Cache the counts for all subjects
    await box.put('subjectQuestionCounts', subjectQuestionCount);

    print('Most Solved Subject: $mostSolvedSubject with count $maxQuestions');
    print('Subject Question Counts: $subjectQuestionCount');
  }

}

// new updated
// again updated