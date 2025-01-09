import 'dart:convert';

class MultipleChoiceQuestion {
  Question question;
  List<Option> options;

  MultipleChoiceQuestion({
    required this.question,
    required this.options,
  });

  factory MultipleChoiceQuestion.fromRawJson(String str) => MultipleChoiceQuestion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MultipleChoiceQuestion.fromJson(Map<String, dynamic> json) => MultipleChoiceQuestion(
    question: Question.fromJson(json["question"]),
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "question": question.toJson(),
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
  };
}

class Option {
  int id;
  String optionText;
  bool isCorrect;

  Option({
    required this.id,
    required this.optionText,
    required this.isCorrect,
  });

  factory Option.fromRawJson(String str) => Option.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    optionText: json["option_text"],
    isCorrect: json["is_correct"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "option_text": optionText,
    "is_correct": isCorrect,
  };
}

class MatchingQuestion {
  Question question;
  List<MatchingPair> matchingPairs;

  MatchingQuestion({
    required this.question,
    required this.matchingPairs,
  });

  // fromJson: JSON'dan MatchingQuestion nesnesi oluşturur
  factory MatchingQuestion.fromJson(Map<String, dynamic> json) {
    return MatchingQuestion(
      question: Question.fromJson(json['question']),
      matchingPairs: (json['matchingPairs'] as List<dynamic>)
          .map((pair) => MatchingPair.fromJson(pair))
          .toList(),
    );
  }

  // toJson: MatchingQuestion nesnesini JSON'a çevirir
  Map<String, dynamic> toJson() {
    return {
      'question': question.toJson(),
      'matchingPairs': matchingPairs.map((pair) => pair.toJson()).toList(),
    };
  }
}

class MatchingPair {
  int id;
  String itemLeft;
  String itemRight;

  MatchingPair({
    required this.id,
    required this.itemLeft,
    required this.itemRight,
  });

  // fromJson: JSON'dan MatchingPair nesnesi oluşturur
  factory MatchingPair.fromJson(Map<String, dynamic> json) {
    return MatchingPair(
      id: json['id'],
      itemLeft: json['itemLeft'],
      itemRight: json['itemRight'],
    );
  }

  // toJson: MatchingPair nesnesini JSON'a çevirir
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemLeft': itemLeft,
      'itemRight': itemRight,
    };
  }
}

class Question {
  int id;
  int? examId;
  String questionText;
  bool isMatching;

  Question({
    required this.id,
    this.examId,
    required this.questionText,
    required this.isMatching,
  });

  factory Question.fromRawJson(String str) => Question.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    examId: json["exam_id"],
    questionText: json["question_text"],
    isMatching: json["is_matching"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "exam_id": examId,
    "question_text": questionText,
    "is_matching": isMatching,
  };
}
