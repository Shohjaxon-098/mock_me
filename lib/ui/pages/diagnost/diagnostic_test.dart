import 'package:flutter/material.dart';
import 'package:talaba_uz/services/apis/api_service.dart';

import 'package:talaba_uz/ui/pages/diagnost/finish_button/finish_button.dart';
import 'package:talaba_uz/ui/pages/diagnost/general_result/general_result.dart';
import 'package:talaba_uz/ui/pages/diagnost/menu_widget/menu_widget.dart';
import 'package:talaba_uz/ui/pages/diagnost/page_navigation/page_navigation_widget.dart';
import 'package:talaba_uz/ui/pages/diagnost/test_card/test_card.dart';

import '../../../services/model/responses/dtm_test_code.dart';


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
        specialTests = data.specialTests;
        subjectTests = data.subjectTests;
        totalSections = specialTests.length + subjectTests.length;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onNextPage(){
    setState(() {
      _selectedIndex++;
    });
  }

  void _onPreviousPage(){
    _selectedIndex--;
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

  void _onAnswerSelected(String section, int questionIndex, int selectedIndex, bool isAnswer) {
    setState(() {
      if (!_selectedAnswerIndices.containsKey(section)) {
        _selectedAnswerIndices[section] = {};
      }
      _selectedAnswerIndices[section]![questionIndex] = selectedIndex;
      // Check if the selected answer is correct
      if(isAnswer){
        print('true $questionIndex $section');
      } else {
        print('false $questionIndex $section');
      }
    });
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
    String currentSubject = (subjects.isNotEmpty && _selectedIndex < subjects.length)
        ? subjects[_selectedIndex]
        : '';

    // Filter tests based on current subject
    List<dynamic> currentTests = [
      ...specialTests.where((test) => test.specialQuestion.subjectCode == currentSubject),
      ...subjectTests.where((test) => test.question.subjectCode == currentSubject),
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
              fontWeight: FontWeight.bold,
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
                    totalSections: totalSections,
                    onNext: _onNextPage,
                    onPrevious: _onPreviousPage,
                  )
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
                      itemCount: currentTests.length,
                      itemBuilder: (context, index) {
                        final test = currentTests[index];
                        final isSpecialTest = test is SpecialTests;
                        final options = isSpecialTest ? (test as SpecialTests).options : (test as SubjectTests).options;
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 12.0,
                            left: 18.0,
                            right: 10,
                          ),
                          child: TestCard(
                            question: '${index + 1}. ${isSpecialTest ? (test as SpecialTests).specialQuestion.text : (test as SubjectTests).question.text}',
                            answers: options.map((e) => e.text).toList(),
                            onAnswerSelected: (selectedIndex) {
                              setState(() {
                                final selectedOption = options[selectedIndex];
                                _onAnswerSelected(
                                  isSpecialTest ? (test as SpecialTests).specialQuestion.subjectCode : (test as SubjectTests).question.subjectCode,
                                  index,
                                  selectedIndex,
                                  selectedOption.isAnswer,
                                );
                              });
                            },
                            selectedIndex: _selectedAnswerIndices[
                            isSpecialTest ? (test as SpecialTests).specialQuestion.subjectCode : (test as SubjectTests).question.subjectCode
                            ]?[index] ?? -1,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              if (_selectedIndex == subjects.length - 1)
                FinishButton(
                  onPressed: () async {
                    try {
                      final apiService = ApiService();
                      await apiService.dtmTestCollection(widget.dtmTestCode);

                      // Ensure the widget is still mounted before navigating
                      if (mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GeneralResult(),
                          ),
                              (route) => false,
                        );
                      }
                    } catch (e) {
                      // Handle any errors
                      print('Error: $e');
                    }
                  },


                ),
            ],
          ),
        ),
      ),
    );
  }
}

// new updated