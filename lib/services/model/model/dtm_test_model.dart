class DtmTestModel {
  final int id;
  final String code;
  final String subject;
  final bool isFree;
  final List<int> tests;

  DtmTestModel({
    required this.id,
    required this.code,
    required this.subject,
    required this.isFree,
    required this.tests,
  });

  factory DtmTestModel.fromJson(Map<String, dynamic> json) {
    return DtmTestModel(
      id: json['id'],
      code: json['code'],
      subject: json['subject'],
      isFree: json['is_free'],
      tests: List<int>.from(json['tests']),
    );
  }
}
