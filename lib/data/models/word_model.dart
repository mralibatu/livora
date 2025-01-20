import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:livora/data/models/category_model.dart';

part 'word_model.g.dart';

@JsonSerializable()
class Word {
  final int id;
  @JsonKey(name: 'foreign_word')
  final String foreignWord;
  @JsonKey(name: 'main_lang_word')
  final String mainLangWord;
  @JsonKey(name: 'hint_text')
  final String hintText;
  @JsonKey(name: 'level_id')
  final int levelId;
  @JsonKey(name: 'part_of_speech_id')
  final int? partOfSpeechId;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'wordxcategory')
  final Category? category;
  bool? isLearned;
  bool? isFavorite;

  Word({
    required this.id,
    required this.foreignWord,
    required this.mainLangWord,
    required this.hintText,
    required this.levelId,
    this.partOfSpeechId,
    required this.categoryId,
    this.category,
    this.isLearned,
    this.isFavorite,
  });

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
  Map<String, dynamic> toJson() => _$WordToJson(this);
}

class WordStats {
  int totalWords;
  int totalLearnedWords;
  int totalFavoriteWords;
  int totalReviewCount;
  DateTime lastReviewed;
  int streakCount;

  WordStats({
    required this.totalWords,
    required this.totalLearnedWords,
    required this.totalFavoriteWords,
    required this.totalReviewCount,
    required this.lastReviewed,
    required this.streakCount,
  });

  factory WordStats.fromRawJson(String str) => WordStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WordStats.fromJson(Map<String, dynamic> json) => WordStats(
    totalWords: json["totalWords"],
    totalLearnedWords: json["totalLearnedWords"],
    totalFavoriteWords: json["totalFavoriteWords"],
    totalReviewCount: json["totalReviewCount"],
    lastReviewed: DateTime.parse(json["lastReviewed"]),
    streakCount: json["streakCount"],
  );

  Map<String, dynamic> toJson() => {
    "totalWords": totalWords,
    "totalLearnedWords": totalLearnedWords,
    "totalFavoriteWords": totalFavoriteWords,
    "totalReviewCount": totalReviewCount,
    "lastReviewed": lastReviewed.toIso8601String(),
    "streakCount": streakCount,
  };
}


