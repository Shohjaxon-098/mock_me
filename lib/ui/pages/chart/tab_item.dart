import '../../../utils/tools/file_important.dart';

class TabItem extends StatelessWidget {
  final String title;

  const TabItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style:  TextStyle(
              fontWeight: FontWeight.w500,
             fontSize: 4.5 * devisePixel(context),
            ),
          ),
        ],
      ),
    );
  }
}
