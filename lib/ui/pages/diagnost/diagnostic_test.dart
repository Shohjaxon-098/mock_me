import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talaba_uz/services/apis/api_service.dart';

import 'package:talaba_uz/ui/pages/diagnost/finish_button/finish_button.dart';
import 'package:talaba_uz/ui/pages/diagnost/general_result/general_result.dart';
import 'package:talaba_uz/ui/pages/diagnost/menu_widget/menu_widget.dart';
import 'package:talaba_uz/ui/pages/diagnost/test_card/test_card.dart';

import '../../../services/model/responses/dtm_test_code.dart';
import 'timer_widget.dart';

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

  DtmTestCode? _testCode;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTests();
  }

  Future<void> _fetchTests() async {
    final apiService = ApiService();
    final data = await apiService.dtmTestCollection(widget.dtmTestCode);

    if (data != null) {
      debugPrint('Data fetched successfully: ${data.toJson()}');
      setState(() {
        _testCode = data;
        totalSections = data.specialTests.length + data.subjectTests.length;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _goToNextQuestion() {
    if (_selectedIndex < totalSections - 1) {
      setState(() {
        _selectedIndex++;
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void _goToPreviousQuestion() {
    if (_selectedIndex > 0) {
      setState(() {
        _selectedIndex--;
        _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
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

  void _onAnswerSelected(String section, int questionIndex, int selectedIndex) {
    setState(() {
      if (!_selectedAnswerIndices.containsKey(section)) {
        _selectedAnswerIndices[section] = {};
      }
      _selectedAnswerIndices[section]![questionIndex] = selectedIndex;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<SpecialTests> specialTests = _testCode?.specialTests ?? [];
    List<SubjectTests> subjectTests = _testCode?.subjectTests ?? [];

    // Extract unique subjects from both specialTests and subjectTests
    List<String> subjects = [
      ...specialTests.map((test) => test.specialQuestion.subjectCode),
      ...subjectTests.map((test) => test.question.subjectCode),
    ].toSet().toList();

    // Ensure the subjects are properly mapped
    if (subjects.isEmpty) {
      debugPrint('No subjects found.');
    } else {
      debugPrint('Subjects: $subjects');
    }

    // Determine current subject based on selected index
    String currentSubject =
    (subjects.isNotEmpty && _selectedIndex < subjects.length)
        ? subjects[_selectedIndex]
        : '';

    // Filter tests based on current subject
    List<SpecialTests> currentSpecialTests = specialTests
        .where((test) => test.specialQuestion.subjectCode == currentSubject)
        .toList();

    List<SubjectTests> currentSubjectTests = subjectTests
        .where((test) => test.question.subjectCode == currentSubject)
        .toList();

    // Debug output for filtered tests
    debugPrint('Current Subject: $currentSubject');
    debugPrint('Special Tests for current subject: $currentSpecialTests');
    debugPrint('Subject Tests for current subject: $currentSubjectTests');

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEEEDFB),
        appBar: AppBar(
          backgroundColor: const Color(0xFFEEEDFB),
          title: const Text(
            "Diagnostik test",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: _isLoading
            ? const Center(
          child: CircularProgressIndicator.adaptive(),
        )
            : Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 54, left: 53),
                child: SizedBox(
                  height: 34,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            _goToPreviousQuestion();
                          },
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: SvgPicture.asset(
                              _selectedIndex == 0
                                  ? 'assets/icons/swipe_noactive_left.svg'
                                  : 'assets/icons/swipe_active_left.svg',
                              semanticsLabel: 'Swipe Left',
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: TimerWidget(),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            _goToNextQuestion();
                          },
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: SvgPicture.asset(
                              _selectedIndex == totalSections - 1
                                  ? 'assets/icons/swipe_noactive_right.svg'
                                  : 'assets/icons/swipe_active_right.svg',
                              semanticsLabel: 'Swipe Right',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                      ),
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
                      itemCount: currentSpecialTests.length,
                      itemBuilder: (context, index) {
                        final test = currentSpecialTests[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 12.0, left: 18.0, right: 10),
                          child: TestCard(
                            question:
                            '${index + 1}. ${test.specialQuestion.text}',
                            answers:
                            test.options.map((e) => e.text).toList(),
                            onAnswerSelected: (selectedIndex) {
                              setState(() {
                                _onAnswerSelected(
                                    test.specialQuestion.subjectCode,
                                    index,
                                    selectedIndex);
                              });
                            },
                            selectedIndex: _selectedAnswerIndices[test
                                .specialQuestion
                                .subjectCode]?[index] ??
                                -1,
                          ),
                        );
                      },
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: currentSubjectTests.length,
                      itemBuilder: (context, index) {
                        final test = currentSubjectTests[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 12.0, left: 18.0, right: 10),
                          child: TestCard(
                            question:
                            '${index + 1}. ${test.question.text}',
                            answers:
                            test.options.map((e) => e.text).toList(),
                            onAnswerSelected: (selectedIndex) {
                              _onAnswerSelected(test.question.subjectCode,
                                  index, selectedIndex);
                            },
                            selectedIndex: _selectedAnswerIndices[
                            test.question.subjectCode]?[index] ??
                                -1,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              if (_selectedIndex == totalSections - 1)
                FinishButton(
                  onPressed: () async {
                    final apiService = ApiService();
                    await apiService.dtmTestCollection(widget.dtmTestCode);

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GeneralResult()),
                            (route) => false);

                    },
                ),
            ],
          ),
        ),
      ),
    );
  }
}