
import '../../../../utils/tools/file_important.dart';

class SwipeButton extends StatelessWidget {
  final String activeIconPath;
  final String inActiveIconPath;
  final bool isActive;
  final VoidCallback onTap;
  const SwipeButton({super.key,
    required this.activeIconPath,
    required this.inActiveIconPath,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: isActive ? onTap : null,
        child: SizedBox(
          width: 30,
          height: 30,
          child: SvgPicture.asset(
            isActive ? activeIconPath : inActiveIconPath,
            semanticsLabel: isActive ? 'Active' : 'Inactive',
          ),
        ),
      ),
    );
  }
}
