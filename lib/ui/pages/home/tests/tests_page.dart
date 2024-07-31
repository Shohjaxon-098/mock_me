import '../../../../utils/tools/file_important.dart';

class Tests extends StatefulWidget {
  const Tests({super.key});

  @override
  State<Tests> createState() => TestsState();
}

class TestsState extends State<Tests> {
  List<DtmDirection> dtmDirections = [];
  final Dio _dio = Dio();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAndSetTests();
  }

  Future<void> fetchAndSetTests() async {
    try {
      List<DtmDirection> directions = await fetchTests();
      setState(() {
        dtmDirections = directions;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List<DtmDirection>> fetchTests() async {
    Response response = await _dio.get("$baseUrl/api/v1/dtmtests/directions/");

    if (response.statusCode == 200) {
      List<dynamic> jsonList = response.data;
      return jsonList.map((json) => DtmDirection.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEEFC),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "DTM testlar",
          style: TextStyle(
            fontSize: 6 * devisePixel(context),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: isLoading
          ? Padding(
              padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
              child: SizedBox(
                height: double.maxFinite,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1 / 1,
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15),
                  itemBuilder: (context, index) => Shimmer.fromColors(
                    baseColor: whiteColor,
                    highlightColor: Colors.grey[200]!,
                    child: const Card(),
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
              child: SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: GridView.builder(
                  itemCount: dtmDirections.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1 / 1,
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15),
                  itemBuilder: (context, index) {
                    final direction = dtmDirections[index];
                    return TestWidget(direction.name ?? "Nomalum fan", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VariantSubject(
                                  directionCode: direction.id.toString(),
                                  name: direction.name,
                                )),
                      );
                    });
                  },
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
            ),
    );
  }
}
