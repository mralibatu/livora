import 'dart:convert';

class Questionxquestionoption {
  int id;
  String optionText;
  bool isCorrect;

  Questionxquestionoption({
    required this.id,
    required this.optionText,
    required this.isCorrect,
  });

  factory Questionxquestionoption.fromRawJson(String str) => Questionxquestionoption.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Questionxquestionoption.fromJson(Map<String, dynamic> json) => Questionxquestionoption(
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