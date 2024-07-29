import 'test.dart';

class DtmCollectionResponse {
  final int id;
  final String code;
  final String subject;
  final bool isFree;
  final List<Test> tests;

  DtmCollectionResponse({
    required this.id,
    required this.code,
    required this.subject,
    required this.isFree,
    required this.tests,
  });

  factory DtmCollectionResponse.fromJson(Map<String, dynamic> json) {
    var testList = json["tests"] as List;
    List<Test> tests = testList.map((i) => Test.fromJson(i)).toList();

    return DtmCollectionResponse(
      id: json["id"],
      code: json["code"],
      subject: json["subject"],
      isFree: json["is_free"],
      tests: tests,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> tests = this.tests.map((i) => i.toJson()).toList();

    return {
      'id': id,
      'code': code,
      'subject': subject,
      'is_free': isFree,
      'tests': tests,
    };
  }
}
