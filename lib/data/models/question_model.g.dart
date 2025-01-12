// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: (json['id'] as num).toInt(),
      questionText: json['question_text'] as String,
      isMatching: json['is_matching'] as bool,
      matchingPairs: (json['matchingPairs'] as List<dynamic>?)
          ?.map((e) => MatchingPair.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'question_text': instance.questionText,
      'is_matching': instance.isMatching,
      'matchingPairs': instance.matchingPairs,
    };

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      id: (json['id'] as num).toInt(),
      optionText: json['option_text'] as String,
      isCorrect: json['is_correct'] as bool,
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'id': instance.id,
      'option_text': instance.optionText,
      'is_correct': instance.isCorrect,
    };

MatchingPair _$MatchingPairFromJson(Map<String, dynamic> json) => MatchingPair(
      id: (json['id'] as num).toInt(),
      itemLeft: json['itemLeft'] as String,
      itemRight: json['itemRight'] as String,
    );

Map<String, dynamic> _$MatchingPairToJson(MatchingPair instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemLeft': instance.itemLeft,
      'itemRight': instance.itemRight,
    };
