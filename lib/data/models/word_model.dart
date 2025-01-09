import 'dart:convert';

class Word {
  int id;
  String foreignWord;
  String mainLangWord;
  String hintText;
  int levelId;
  dynamic partOfSpeechId;
  int categoryId;
  Wordxlevel wordxlevel;
  dynamic wordxpartofspeech;
  Wordxcategory wordxcategory;

  Word({
    required this.id,
    required this.foreignWord,
    required this.mainLangWord,
    required this.hintText,
    required this.levelId,
    required this.partOfSpeechId,
    required this.categoryId,
    required this.wordxlevel,
    required this.wordxpartofspeech,
    required this.wordxcategory,
  });

  factory Word.fromRawJson(String str) => Word.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Word.fromJson(Map<String, dynamic> json) => Word(
    id: json["id"],
    foreignWord: json["foreign_word"],
    mainLangWord: json["main_lang_word"],
    hintText: json["hint_text"],
    levelId: json["level_id"],
    partOfSpeechId: json["part_of_speech_id"],
    categoryId: json["category_id"],
    wordxlevel: Wordxlevel.fromJson(json["wordxlevel"]),
    wordxpartofspeech: json["wordxpartofspeech"],
    wordxcategory: Wordxcategory.fromJson(json["wordxcategory"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "foreign_word": foreignWord,
    "main_lang_word": mainLangWord,
    "hint_text": hintText,
    "level_id": levelId,
    "part_of_speech_id": partOfSpeechId,
    "category_id": categoryId,
    "wordxlevel": wordxlevel.toJson(),
    "wordxpartofspeech": wordxpartofspeech,
    "wordxcategory": wordxcategory.toJson(),
  };
}

class Wordxcategory {
  String categoryName;
  int difficultyLevel;

  Wordxcategory({
    required this.categoryName,
    required this.difficultyLevel,
  });

  factory Wordxcategory.fromRawJson(String str) => Wordxcategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Wordxcategory.fromJson(Map<String, dynamic> json) => Wordxcategory(
    categoryName: json["category_name"],
    difficultyLevel: json["difficulty_level"],
  );

  Map<String, dynamic> toJson() => {
    "category_name": categoryName,
    "difficulty_level": difficultyLevel,
  };
}

class Wordxlevel {
  String levelName;
  String levelCefr;
  int levelNumber;

  Wordxlevel({
    required this.levelName,
    required this.levelCefr,
    required this.levelNumber,
  });

  factory Wordxlevel.fromRawJson(String str) => Wordxlevel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Wordxlevel.fromJson(Map<String, dynamic> json) => Wordxlevel(
    levelName: json["level_name"],
    levelCefr: json["level_cefr"],
    levelNumber: json["level_number"],
  );

  Map<String, dynamic> toJson() => {
    "level_name": levelName,
    "level_cefr": levelCefr,
    "level_number": levelNumber,
  };
}
