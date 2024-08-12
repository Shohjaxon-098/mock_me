
import '../../../../../utils/tools/file_important.dart';

class DtmTestsLoading extends StatelessWidget {
  const DtmTestsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Shimmer.fromColors(
    baseColor: whiteColor,
    highlightColor: Colors.grey[200]!,
    child: GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 6 / 4,
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 16
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: 156,
            height: 103,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    ),
    ),
    );
  }
}
