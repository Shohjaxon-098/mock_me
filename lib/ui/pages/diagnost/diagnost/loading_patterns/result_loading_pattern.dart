import '../../../../../utils/tools/file_important.dart';

class ResultLoadingPattern extends StatelessWidget {
  const ResultLoadingPattern({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            Shimmer.fromColors(
              baseColor: whiteColor,
              highlightColor: Colors.grey[200]!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 327,
                  height: 105,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Shimmer.fromColors(
              baseColor: whiteColor,
              highlightColor: Colors.grey[200]!,
              child: SizedBox(
                width: 327,
                height: 187,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
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
