import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onMenuItemTap;
  final List<String> subjects;
  const MenuWidget({
        super.key,
        required this.selectedIndex,
        required this.onMenuItemTap,
        required this.subjects,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            subjects.length,
            (index) => GestureDetector(
              onTap: () => onMenuItemTap(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: selectedIndex == index ? const Color(0xFF264CEC) : const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Text(
                      subjects[index],
                      style: TextStyle(
                        color: selectedIndex == index ? const Color(0xFFFFFFFF) : const Color(0xFF1E1E1E),
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Inter-Medium',
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}


// SizedBox(
// width: 327,
// height: 28,
// child: Stack(
// children: List.generate(subjects.length, (index){
// final isSelected = selectedIndex == index;
// const totalWidth = 327;
// const itemCount = 3;
// const spacing = 6;
// const itemWidth = (totalWidth - (itemCount - 1) * spacing) / itemCount;
// final baseLeftPosition = index * (itemWidth + spacing);
// final backgroundColor = isSelected ? const Color(0xFF264CEC) : Colors.white;
// final title = index == 0 ? 'Majburiy fanlar' : index == 1 ? 'Birinchi fan' : 'Ikkinchi fan';
// final colorOfTitle = isSelected ? Colors.white : const Color(0xFF1E1E1E);
// return Positioned(
// left: baseLeftPosition.toDouble(),
// width: itemWidth.toDouble(),
// height: 28,
// child: GestureDetector(
// onTap: () => onMenuItemTap(index),
// child: DecoratedBox(
// decoration: BoxDecoration(
// color: backgroundColor,
// borderRadius: BorderRadius.circular(5),
// border: Border.all(
// color: isSelected ? Colors.transparent : Colors.grey.shade300,
// width: 1
// )
// ),
// child: Center(
// child: Text(
// title,
// textAlign: TextAlign.left,
// style: TextStyle(
// fontSize: 12,
// color: colorOfTitle,
// ),
// ),
// ),
// ),
// ));
// }),
// ),
// );