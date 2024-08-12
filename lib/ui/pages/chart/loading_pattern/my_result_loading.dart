import '../../../../utils/tools/file_important.dart';

class MyResultLoading extends StatelessWidget {
  const MyResultLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
              baseColor: whiteColor,
              highlightColor: Colors.grey[200]!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: width(context) * 0.89,
                  height: height(context) * 0.21,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ),
          SizedBox(height: 67,),
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.5,
            child: Shimmer.fromColors(
              baseColor: whiteColor,
              highlightColor: Colors.grey[200]!,
              child: ListView.separated(
                  itemCount: 2,
                  itemBuilder: (context, index){
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                     width: width(context) * 0.89,
                     height: height(context) * 0.18,
                     child: DecoratedBox(
                       decoration: BoxDecoration(
                         color: Colors.white,
                       ),
                     ),
                    ),
                  );
                  },
                separatorBuilder: (context, index) => SizedBox(height: 12,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
