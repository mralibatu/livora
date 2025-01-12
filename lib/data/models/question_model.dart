import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'question_model.g.dart';

@JsonSerializable()
class Question {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'question_text')
  final String questionText;
  @JsonKey(name: 'is_matching')
  final bool isMatching;
  @JsonKey(name: 'matchingPairs')
  final List<MatchingPair>? matchingPairs; // For matching questions

  Question({
    required this.id,
    required this.questionText,
    required this.isMatching,
    this.matchingPairs,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class Option {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'option_text')
  final String optionText;
  @JsonKey(name: 'is_correct')
  final bool isCorrect;

  Option({
    required this.id,
    required this.optionText,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}

@JsonSerializable()
class MatchingPair {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'itemLeft')
  final String itemLeft;
  @JsonKey(name: 'itemRight')
  final String itemRight;

  MatchingPair({
    required this.id,
    required this.itemLeft,
    required this.itemRight,
  });

  factory MatchingPair.fromJson(Map<String, dynamic> json) =>
      _$MatchingPairFromJson(json);

  Map<String, dynamic> toJson() => _$MatchingPairToJson(this);
}

class QuestionOption {
  Question question;
  List<Option> options;

  QuestionOption({
    required this.question,
    required this.options,
  });

  factory QuestionOption.fromRawJson(String str) => QuestionOption.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionOption.fromJson(Map<String, dynamic> json) => QuestionOption(
    question: Question.fromJson(json["question"]),
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "question": question.toJson(),
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
  };
}