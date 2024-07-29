class Test {
  final int id;
  final String code;
  final String question;
  final String image;
  final String answerA;
  final String answerB;
  final String answerC;
  final String answerD;
  final String answerCorrect;

  Test({
    required this.id,
    required this.code,
    required this.question,
    required this.image,
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
    required this.answerCorrect,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json["id"],
      code: json["code"],
      question: json["question"],
      image: json["image"],
      answerA: json["answerA"],
      answerB: json["answerB"],
      answerC: json["answerC"],
      answerD: json["answerD"],
      answerCorrect: json["answer_correct"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'question': question,
      'image': image,
      'answerA': answerA,
      'answerB': answerB,
      'answerC': answerC,
      'answerD': answerD,
      'answer_correct': answerCorrect,
    };
  }
}