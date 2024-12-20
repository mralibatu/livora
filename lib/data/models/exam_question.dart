import 'dart:convert';

import 'package:livora/data/models/question_question_option.dart';

class Examxquestion {
  int id;
  String questionText;
  List<Questionxquestionoption> questionxquestionoption;

  Examxquestion({
    required this.id,
    required this.questionText,
    required this.questionxquestionoption,
  });

  factory Examxquestion.fromRawJson(String str) => Examxquestion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Examxquestion.fromJson(Map<String, dynamic> json) => Examxquestion(
    id: json["id"],
    questionText: json["question_text"],
    questionxquestionoption: List<Questionxquestionoption>.from(json["questionxquestionoption"].map((x) => Questionxquestionoption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_text": questionText,
    "questionxquestionoption": List<dynamic>.from(questionxquestionoption.map((x) => x.toJson())),
  };
}