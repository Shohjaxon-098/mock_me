class SubjectTestModel {
  final List<String> subjectTest;

  SubjectTestModel({required this.subjectTest});

  // Factory method to create an instance from JSON
  factory SubjectTestModel.fromJson(Map<String, dynamic> json) {
    return SubjectTestModel(
      subjectTest: List<String>.from(json['subjecttest']),
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'subjecttest': subjectTest,
    };
  }
}
