// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      id: (json['id'] as num).toInt(),
      foreignWord: json['foreign_word'] as String,
      mainLangWord: json['main_lang_word'] as String,
      hintText: json['hint_text'] as String,
      levelId: (json['level_id'] as num).toInt(),
      partOfSpeechId: (json['part_of_speech_id'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num).toInt(),
      category: json['wordxcategory'] == null
          ? null
          : Category.fromJson(json['wordxcategory'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'id': instance.id,
      'foreign_word': instance.foreignWord,
      'main_lang_word': instance.mainLangWord,
      'hint_text': instance.hintText,
      'level_id': instance.levelId,
      'part_of_speech_id': instance.partOfSpeechId,
      'category_id': instance.categoryId,
      'wordxcategory': instance.category,
    };
