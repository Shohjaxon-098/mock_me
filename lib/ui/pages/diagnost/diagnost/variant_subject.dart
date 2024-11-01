import 'package:talaba_uz/ui/pages/diagnost/diagnost/loading_patterns/variant_loading.dart';

import '../../../../utils/tools/file_important.dart';

class VariantSubject extends StatefulWidget {
  final String directionCode;
  final String name;
  const VariantSubject({super.key, required this.directionCode, required this.name});

  @override
  State<VariantSubject> createState() => _VariantSubjectState();
}

class _VariantSubjectState extends State<VariantSubject> {
  List<DtmTestModelOriginal> _subjects = [];

  final Dio _dio = Dio();

  Future<void> testFetching(String directionCode) async {
    try {
      final response = await _dio.get("$baseUrl/api/v1/dtmtests/tests/$directionCode");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<DtmTestModelOriginal> subjects = data.map((item) =>
            DtmTestModelOriginal.fromJson(item)).toList();
        setState(() {
          _subjects = subjects;
        });



      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    testFetching(widget.directionCode);
  }






  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEEFC),
      appBar: AppBar(
        backgroundColor: Color(0xFFEFEEFC),
        centerTitle: true,
        title: Text(
          '${widget.name}',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter-SemiBold',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _subjects.isEmpty
            ? VariantLoading()
            : ListView.separated(
          itemCount: _subjects.length,
          itemBuilder: (BuildContext context, int index) {
            final test = _subjects[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Color(0xFFFFFFFF),
              elevation: 5,
              child: SizedBox(
                width: 327,
                height: 197,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Variant: ${test.dtmtestCode}',// here
                            style: TextStyle(
                              color: Color(0xFF264CEC),
                              fontSize: 16,
                         //     fontWeight: FontWeight.bold,
                              fontFamily: 'Inter-SemiBold',
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.schedule, color: Color(0xFF080317)),
                              SizedBox(width: 2),
                              Text(
                                '3 soat',
                                style: TextStyle(
                                  color: Color(0xFF080317),
                                  fontSize: 14,
                           //       fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter-SemiBold',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 11),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${test.spSubjeccttest} - 30 ta',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Color(0xFF080317),
                            fontSize: 12,
                            fontFamily: 'Inter-Bold',
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${test.subjecttest.first} - 30 ta',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Color(0xFF080317),
                            fontSize: 12,
                            fontFamily: 'Inter-Bold',
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${test.subjecttest.last} - 30 ta',
                          style: TextStyle(
                            color: Color(0xFF080317),
                            fontSize: 12,
                            fontFamily: 'Inter-Bold',
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: StartButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DiagnosticTest(dtmTestCode: test.dtmtestCode),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 16);
          },
        ),
      ),
    );
  }

}
