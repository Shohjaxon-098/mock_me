class ResultIdModel {
  final int studentId;
  final String testCode;
  final double point;
  final String date;

  // Constructor with required parameters
  ResultIdModel({
    required this.studentId,
    required this.testCode,
    required this.point,
    required this.date,
  });

  // Factory method to create an instance from JSON
  factory ResultIdModel.fromJson(Map<String, dynamic> json) {
    return ResultIdModel(
      studentId: json['student_id'],
      testCode: json['test_code'],
      point: json['point'].toDouble(),
      date: json['date'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'test_code': testCode,
      'point': point,
      'date': date,
    };
  }
}