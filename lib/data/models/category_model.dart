import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class Category {
  final int id;
  @JsonKey(name: 'category_name')
  final String categoryName;
  @JsonKey(name: 'difficulty_level')
  final int difficultyLevel;
  @JsonKey(name: 'wordCount')
  final int wordCount;
  final bool isWordCategory;

  Category({
    required this.id,
    required this.categoryName,
    required this.difficultyLevel,
    required this.wordCount,
    required this.isWordCategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
