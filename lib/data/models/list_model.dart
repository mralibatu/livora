import 'package:json_annotation/json_annotation.dart';

part 'list_model.g.dart';

@JsonSerializable()
class WordList {
  final int id;
  @JsonKey(name: 'list_name')
  final String listName;
  @JsonKey(name: 'repeat_day')
  final int? repeatDay;
  @JsonKey(name: 'is_private')
  final bool isPrivate;
  @JsonKey(name: 'list_category_id')
  final int? listCategoryId;

  WordList({
    required this.id,
    required this.listName,
    this.repeatDay,
    required this.isPrivate,
    this.listCategoryId,
  });

  factory WordList.fromJson(Map<String, dynamic> json) =>
      _$WordListFromJson(json);
  Map<String, dynamic> toJson() => _$WordListToJson(this);
}
