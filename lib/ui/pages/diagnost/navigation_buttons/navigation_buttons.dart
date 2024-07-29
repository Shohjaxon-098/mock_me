import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationButtons extends StatelessWidget {
  final int selectedIndex;
  final int totalSections;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  const NavigationButtons({super.key,
  required this.selectedIndex,
  required this.totalSections,
  required this.onPrevious,
  required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 269,
      height: 32,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            width: 269,
            top: 0,
            height: 32,
            child: Stack(
              children: [
                Positioned(
                  left: 52,
                  width: 165,
                  top: 0,
                  height: 32,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xFF264CEB),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0a000000),
                          offset: Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onHorizontalDragEnd: (details){
                        if(details.primaryVelocity! < 0){
                          // Swiped left
                          if(selectedIndex != totalSections -1){
                            onNext();
                          }
                        } else if(details.primaryVelocity! > 0){
                          // Swiped right
                          if(selectedIndex != 0){
                            onPrevious();
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(totalSections, (index){
                          final isSelected = index == selectedIndex;
                          return SizedBox(
                            width: 24,
                            height: 24,
                            child: DecoratedBox(
                              decoration: isSelected
                                  ? const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              )
                                  : const BoxDecoration(),
                              child: Center(
                                child: Text('${index + 1}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isSelected
                                        ? const Color(0xff264ceb)
                                        : Colors.white,
                                    fontFamily: 'Inter-SemiBold',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  width: 28,
                  top: 2,
                  height: 28,
                  child: GestureDetector(
                    onTap: selectedIndex == 0 ? null : onPrevious,
                    child: SvgPicture.asset(
                      selectedIndex == 0
                          ? 'assets/icons/arrow_circle_left_unactive.svg'
                          : 'assets/icons/arrow_circle_left.svg',
                      width: 28,
                      height: 28,
                    ),
                  ),
                ),
                Positioned(
                    left: 241,
                    width: 28,
                    top: 2,
                    height: 28,
                    child: GestureDetector(
                      onTap: selectedIndex == totalSections - 1 ? null : onNext,
                      child: SvgPicture.asset(
                          width: 28,
                          height: 28,
                          selectedIndex == totalSections - 1
                              ? 'assets/icons/arrow_circle_right_unactive.svg'
                              : 'assets/icons/arrow_circle_right.svg'
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}



// SizedBox(
// width: 269,
// height: 32,
// child: Row(
// children: [
// GestureDetector(
// onTap: selectedIndex == 0 ? null : onPrevious,
// child: SvgPicture.asset(
// selectedIndex == 0
// ? 'assets/icons/arrow_circle_left_unactive.svg'
//     : 'assets/icons/arrow_circle_left.svg',
// width: 28,
// height: 28,
// ),
// ),
// const SizedBox(width: 24,),
// Expanded(child: DecoratedBox(
// decoration: BoxDecoration(
// color: const Color(0xFF264CEB),
// borderRadius: BorderRadius.circular(6),
// boxShadow: const [
// BoxShadow(
// color: Color(0x0a000000),
// offset: Offset(0, 4),
// blurRadius: 8,
// ),
// ],
// ),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: List.generate(totalSections, (index){
// final isSelected = index == selectedIndex;
// return SizedBox(
// width: 24,
// height: 24,
// child: DecoratedBox(
// decoration: isSelected
// ? const BoxDecoration(
// color: Colors.white,
// shape: BoxShape.circle,
// )
//     : const BoxDecoration(),
// child: Center(
// child: Text(
// '${index + 1}',
// style: TextStyle(
// fontSize: 16,
// color: isSelected
// ? const Color(0xFF264ceb)
//     : Colors.white,
// fontFamily: 'Inter-SemiBold',
// fontWeight: FontWeight.normal
// ),
// ),
// ),
// ),
// );
// }),
// ),
// ),
// ),
// const SizedBox(width: 24,),
// GestureDetector(
// onTap: selectedIndex == totalSections - 1 ? null : onNext,
// child: SvgPicture.asset(
// selectedIndex == totalSections - 1
// ? 'assets/icons/arrow_circle_right_unactive.svg'
//     : 'assets/icons/arrow_circle_right.svg',
// width: 28,
// height: 28,
// ),
// )
// ],
// ),
// );