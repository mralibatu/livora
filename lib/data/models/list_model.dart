import 'package:json_annotation/json_annotation.dart';
import 'package:livora/data/models/category_model.dart';
import 'package:livora/data/repositories/category_repository.dart';

part 'list_model.g.dart';

@JsonSerializable()
class WordList {
  int id;
  @JsonKey(name: 'list_name')
  String listName;
  @JsonKey(name: 'repeat_day')
  int? repeatDay;
  @JsonKey(name: 'is_private')
  bool isPrivate;
  @JsonKey(name: 'list_category_id')
  int? listCategoryId;

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
