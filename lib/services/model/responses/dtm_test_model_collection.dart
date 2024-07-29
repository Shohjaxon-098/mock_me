import '../dtm_collection_response.dart';

class DtmTestModelCollection {
  final Test test;
  final List<SpecialTests> specialTests;
  final List<SubjectTests> subjectTests;

  DtmTestModelCollection({
    required this.test,
    required this.specialTests,
    required this.subjectTests,
  });

  factory DtmTestModelCollection.fromJson(Map<String, dynamic> json) {
    return DtmTestModelCollection(
      test: Test.fromJson(json['test']),
      specialTests: (json['special_tests'] as List)
          .map((e) => SpecialTests.fromJson(e))
          .toList(),
      subjectTests: (json['subject_tests'] as List)
          .map((e) => SubjectTests.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'test': test.toJson(),
      'special_tests': specialTests.map((e) => e.toJson()).toList(),
      'subject_tests': subjectTests.map((e) => e.toJson()).toList(),
    };
  }

  List<String> extractSubjectCodes() {
    return specialTests
        .map((specialTest) => specialTest.specialQuestion.subjectCode)
        .toList();
  }
}




class SpecialTests {
  final SpecialQuestion specialQuestion;
  final List<Options> options;

  SpecialTests({
    required this.specialQuestion,
    required this.options,
  });

  factory SpecialTests.fromJson(Map<String, dynamic> json) {
    return SpecialTests(
      specialQuestion: SpecialQuestion.fromJson(json['special_question']),
      options: (json['options'] as List)
          .map((e) => Options.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'special_question': specialQuestion.toJson(),
      'options': options.map((e) => e.toJson()).toList(),
    };
  }
}

class SpecialQuestion {
  final int id;
  final int questionNo;
  final String text;
  final String subjectCode;

  SpecialQuestion({
    required this.id,
    required this.questionNo,
    required this.text,
    required this.subjectCode,
  });

  factory SpecialQuestion.fromJson(Map<String, dynamic> json) {
    return SpecialQuestion(
      id: json['id'],
      questionNo: json['question_no'],
      text: json['text'],
      subjectCode: json['subject_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_no': questionNo,
      'text': text,
      'subject_code': subjectCode,
    };
  }
}

class Options {
  final int id;
  final bool isAnswer;
  final String text;
  final int questionNo;

  Options({
    required this.id,
    required this.isAnswer,
    required this.text,
    required this.questionNo,
  });

  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      id: json['id'],
      isAnswer: json['is_answer'],
      text: json['text'],
      questionNo: json['question_no'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_answer': isAnswer,
      'text': text,
      'question_no': questionNo,
    };
  }
}

class SubjectTests {
  final SpecialQuestion question;
  final List<Options> options;

  SubjectTests({
    required this.question,
    required this.options,
  });

  factory SubjectTests.fromJson(Map<String, dynamic> json) {
    return SubjectTests(
      question: SpecialQuestion.fromJson(json['question']),
      options: (json['options'] as List)
          .map((e) => Options.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question.toJson(),
      'options': options.map((e) => e.toJson()).toList(),
    };
  }



}

