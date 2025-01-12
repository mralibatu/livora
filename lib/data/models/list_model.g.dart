// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordList _$WordListFromJson(Map<String, dynamic> json) => WordList(
      id: (json['id'] as num).toInt(),
      listName: json['list_name'] as String,
      repeatDay: (json['repeat_day'] as num?)?.toInt(),
      isPrivate: json['is_private'] as bool,
      listCategoryId: (json['list_category_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WordListToJson(WordList instance) => <String, dynamic>{
      'id': instance.id,
      'list_name': instance.listName,
      'repeat_day': instance.repeatDay,
      'is_private': instance.isPrivate,
      'list_category_id': instance.listCategoryId,
    };
