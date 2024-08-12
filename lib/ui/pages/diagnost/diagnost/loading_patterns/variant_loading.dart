import '../../../../../utils/tools/file_important.dart';

class VariantLoading extends StatelessWidget {
  const VariantLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: whiteColor,
      highlightColor: Colors.grey[200]!,
      child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(5),
          itemCount: 3,
          itemBuilder: (context, index){
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 327,
              height: 194,
              child: DecoratedBox(

                decoration: BoxDecoration(
                  color: Colors.white,

                ),
              ),
            ),
          );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16,),
      ),
    );
  }
}
