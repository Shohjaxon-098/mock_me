import 'package:flutter/material.dart';

import '../swipe_button/swipe_button.dart';
import '../timer_widget.dart';

class PageNavigationWidget extends StatelessWidget {
  final PageController pageController;
  final int selectedIndex;
  final int totalSections;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const PageNavigationWidget({
    Key? key,
    required this.pageController,
    required this.selectedIndex,
    required this.totalSections,
    required this.onNext,
    required this.onPrevious,
  }) : super(key: key);

  void _goToNextPage() {
    if (selectedIndex < totalSections - 1) {
      onNext();
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (selectedIndex > 0) {
      onPrevious();
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SwipeButton(
          activeIconPath: 'assets/icons/swipe_active_left.svg',
          inActiveIconPath: 'assets/icons/swipe_noactive_left.svg',
          isActive: selectedIndex > 0,
          onTap: _goToPreviousPage,
        ),
        const Expanded(child: TimerWidget()),  // Keep this as it was in your previous code
        SwipeButton(
          activeIconPath: 'assets/icons/swipe_active_right.svg',
          inActiveIconPath: 'assets/icons/swipe_noactive_right.svg',
          isActive: selectedIndex < totalSections - 1,
          onTap: _goToNextPage,
        ),
      ],
    );
  }
}

// new updated