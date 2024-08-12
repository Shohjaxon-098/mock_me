import '../../../../utils/tools/file_important.dart';
import 'loading_patterns/dtm_tests_loading.dart';

class DtmTests extends StatefulWidget {
  const DtmTests({super.key});

  @override
  State<DtmTests> createState() => _DtmTestsState();
}

class _DtmTestsState extends State<DtmTests> {
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
              fontFamily: 'Inter-SemiBold'),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: isLoading
          ? DtmTestsLoading()
          : Padding(
              padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
              child: SizedBox(
                width: width(context),
                height: height(context),
                child: GridView.builder(
                  itemCount: dtmDirections.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 6 / 4,
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                  ),
                  itemBuilder: (context, index) {
                    final direction = dtmDirections[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, right: 21, left: 21),
                        child: Column(
                          children: [
                            Text(
                              direction.name ?? "Nomalum fan",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: devisePixel(context) * 4,
                                  fontFamily: 'Inter-SemiBold'),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: width(context) * 0.312,
                              height: 24,
                              child: WElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VariantSubject(
                                              directionCode:
                                                  direction.id.toString(),
                                              name: direction.name,
                                            )),
                                  );
                                },
                                text: Text(
                                  "Boshlash",
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: devisePixel(context) * 3.5,
                                    letterSpacing: 0.7,
                                    fontFamily: 'Inter-Medium',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
            ),
    );
  }
}
