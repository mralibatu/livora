// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: (json['id'] as num).toInt(),
      categoryName: json['category_name'] as String,
      difficultyLevel: (json['difficulty_level'] as num).toInt(),
      wordCount: (json['wordCount'] as num).toInt(),
      isWordCategory: json['isWordCategory'] as bool,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'category_name': instance.categoryName,
      'difficulty_level': instance.difficultyLevel,
      'wordCount': instance.wordCount,
      'isWordCategory': instance.isWordCategory,
    };
