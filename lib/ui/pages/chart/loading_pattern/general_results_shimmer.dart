import '../../../../utils/tools/file_important.dart';

class GeneralShimmerResult extends StatelessWidget {
  const GeneralShimmerResult({super.key});

  @override
  Widget build(BuildContext context) {
    final double shimmerWidth = 330; // Fixed width for shimmer widgets
    final double shimmerItemWidth = 107; // Width for shimmer items in the list
    final double shimmerItemHeight = 28; // Height for shimmer items in the list
    final double listViewHeight = shimmerItemHeight; // Height of the ListView item

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(3, (index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                    width: 105,
                    height: 28,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 8), // Vertical space between rectangle and ListView
            SizedBox(
              width: 327,
              height: 500,
              child: Shimmer.fromColors(
                baseColor: whiteColor,
                highlightColor: Colors.grey[200]!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      color: Colors.white,
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}