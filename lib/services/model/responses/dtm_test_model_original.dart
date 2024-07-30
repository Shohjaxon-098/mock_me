import 'dart:convert';

class DtmTestModelOriginal {
  final String dtmtestCode;
  final int directionCode;
  final List<String> spSubjeccttest;
  final List<String> subjecttest;

  DtmTestModelOriginal({
    required this.dtmtestCode,
    required this.directionCode,
    required this.spSubjeccttest,
    required this.subjecttest,
  });











  factory DtmTestModelOriginal.fromJson(Map<String, dynamic> json) {
    return DtmTestModelOriginal(
      dtmtestCode: json['dtmtest_code'] ?? '',
      directionCode: json['direction_code'] ?? 0,
      spSubjeccttest: json['sp_subjeccttest'] != null
          ? List<String>.from(json['sp_subjeccttest'])
          : [],
      subjecttest: json['subjecttest'] != null
          ? List<String>.from(json['subjecttest'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dtmtest_code': dtmtestCode,
      'direction_code': directionCode,
      'sp_subjeccttest': spSubjeccttest,
      'subjecttest': subjecttest,
    };
  }
}

List<DtmTestModelOriginal> dtmTestModelFromJson(String str) {
  final jsonData = json.decode(str) as List<dynamic>;
  return List<DtmTestModelOriginal>.from(
      jsonData.map((x) => DtmTestModelOriginal.fromJson(x as Map<String, dynamic>)));
}

String dtmTestModelToJson(List<DtmTestModelOriginal> data) {
  final jsonData = data.map((x) => x.toJson()).toList();
  return json.encode(jsonData);
}