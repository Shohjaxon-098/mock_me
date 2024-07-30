class ResultDtmModel {
  final int studentId;
  final String testCode;
  final double point;
  final String date;

  ResultDtmModel({
    required this.studentId,
    required this.testCode,
    required this.point,
    required this.date,
  });

  // Factory method to create an instance from JSON
  factory ResultDtmModel.fromJson(Map<String, dynamic> json) {
    return ResultDtmModel(
      studentId: json['student_id'] as int,
      testCode: json['test_code'] as String,
      point: (json['point'] as num).toDouble(),
      date: json['date'] as String,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'test_code': testCode,
      'point': point,
      'date': date,
    };
  }
}