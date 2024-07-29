class ResultDtmModel {
  final int studentID;
  final String testCode;
  final int point;
  final String date;

  ResultDtmModel({
    required this.studentID,
    required this.testCode,
    required this.point,
    required this.date,
  });

  factory ResultDtmModel.fromJson(Map<String, dynamic> json) {
    return ResultDtmModel(
        studentID: json['student_id'],
        testCode: json['test_code'],
        point: json['point'],
        date: json['date']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'student_id': studentID,
      'test_code': testCode,
      'point': point,
      'date': date,
    };
  }
}