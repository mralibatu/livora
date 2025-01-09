import 'dart:convert';

class WordList {
  int id;
  String listName;
  int repeatDay;
  bool isPrivate;
  int listCategoryId;
  Listxcategory? listxcategory;
  List<Listxwordlist>? listxwordlist;

  WordList({
    required this.id,
    required this.listName,
    required this.repeatDay,
    required this.isPrivate,
    required this.listCategoryId,
    this.listxcategory,
    this.listxwordlist,
  });

  factory WordList.fromRawJson(String str) => WordList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WordList.fromJson(Map<String, dynamic> json) => WordList(
    id: json["id"],
    listName: json["list_name"],
    repeatDay: json["repeat_day"],
    isPrivate: json["is_private"],
    listCategoryId: json["list_category_id"],
    listxcategory: Listxcategory.fromJson(json["listxcategory"]),
    listxwordlist: List<Listxwordlist>.from(json["listxwordlist"].map((x) => Listxwordlist?.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "list_name": listName,
    "repeat_day": repeatDay,
    "is_private": isPrivate,
    "list_category_id": listCategoryId,
    "listxcategory": listxcategory?.toJson(),
    "listxwordlist": listxwordlist != null ? List<dynamic>.from(listxwordlist!.map((x) => x.toJson())) : null,
  };
}

class Listxcategory {
  String categoryName;
  int difficultyLevel;
  bool isWordCategory;

  Listxcategory({
    required this.categoryName,
    required this.difficultyLevel,
    required this.isWordCategory,
  });

  factory Listxcategory.fromRawJson(String str) => Listxcategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Listxcategory.fromJson(Map<String, dynamic> json) => Listxcategory(
    categoryName: json["category_name"],
    difficultyLevel: json["difficulty_level"],
    isWordCategory: json["isWordCategory"],
  );

  Map<String, dynamic> toJson() => {
    "category_name": categoryName,
    "difficulty_level": difficultyLevel,
    "isWordCategory": isWordCategory,
  };
}


class Listxwordlist {
  int id;
  int wordId;
  int listId;
  Wordlistxword wordlistxword;

  Listxwordlist({
    required this.id,
    required this.wordId,
    required this.listId,
    required this.wordlistxword,
  });

  factory Listxwordlist.fromRawJson(String str) => Listxwordlist.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Listxwordlist.fromJson(Map<String, dynamic> json) => Listxwordlist(
    id: json["id"],
    wordId: json["word_id"],
    listId: json["list_id"],
    wordlistxword: Wordlistxword.fromJson(json["wordlistxword"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "word_id": wordId,
    "list_id": listId,
    "wordlistxword": wordlistxword.toJson(),
  };
}

class Wordlistxword {
  String foreignWord;
  String mainLangWord;
  String hintText;
  int levelId;
  int? partOfSpeechId;
  int categoryId;

  Wordlistxword({
    required this.foreignWord,
    required this.mainLangWord,
    required this.hintText,
    required this.levelId,
    required this.partOfSpeechId,
    required this.categoryId,
  });

  factory Wordlistxword.fromRawJson(String str) => Wordlistxword.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Wordlistxword.fromJson(Map<String, dynamic> json) => Wordlistxword(
    foreignWord: json["foreign_word"],
    mainLangWord: json["main_lang_word"],
    hintText: json["hint_text"],
    levelId: json["level_id"],
    partOfSpeechId: json["part_of_speech_id"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "foreign_word": foreignWord,
    "main_lang_word": mainLangWord,
    "hint_text": hintText,
    "level_id": levelId,
    "part_of_speech_id": partOfSpeechId,
    "category_id": categoryId,
  };
}