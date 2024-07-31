import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestCard extends StatelessWidget {
  final String question;
  final List<String> answers;
  final ValueChanged<int> onAnswerSelected;
  final int selectedIndex;

  const TestCard({
    super.key,
    required this.question,
    required this.answers,
    required this.onAnswerSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      //height: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff1e1e1e),
                  fontFamily: 'Poppins-Medium',
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: List.generate(answers.length, (index) {
                  return GestureDetector(
                    onTap: () => onAnswerSelected(index),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            selectedIndex == index
                                ? 'assets/icons/checked_answer.svg'
                                : 'assets/icons/unchecked_answer.svg',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              answers[index],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xff1e1e1e),
                                fontFamily: 'Poppins-Medium',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}