import 'dart:convert';

import 'package:livora/data/models/exam_question.dart';
import 'package:livora/data/models/exam_user_exam.dart';

class Exam {
  int id;
  String examName;
  dynamic timerSeconds;
  bool isPrivate;
  int createdById;
  dynamic isMatching;
  List<Examxuserexam> examxuserexam;
  List<Examxquestion> examxquestion;

  Exam({
    required this.id,
    required this.examName,
    required this.timerSeconds,
    required this.isPrivate,
    required this.createdById,
    required this.isMatching,
    required this.examxuserexam,
    required this.examxquestion,
  });

  factory Exam.fromRawJson(String str) => Exam.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  List<Exam> getExamsFromJson (String json) => List.from(jsonDecode(json)).map((exam) => Exam.fromJson(exam)).toList();

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
    id: json["id"],
    examName: json["exam_name"],
    timerSeconds: json["timer_seconds"],
    isPrivate: json["is_private"],
    createdById: json["created_by_id"],
    isMatching: json["is_matching"],
    examxuserexam: List<Examxuserexam>.from(json["examxuserexam"].map((x) => Examxuserexam.fromJson(x))),
    examxquestion: List<Examxquestion>.from(json["examxquestion"].map((x) => Examxquestion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "exam_name": examName,
    "timer_seconds": timerSeconds,
    "is_private": isPrivate,
    "created_by_id": createdById,
    "is_matching": isMatching,
    "examxuserexam": List<dynamic>.from(examxuserexam.map((x) => x.toJson())),
    "examxquestion": List<dynamic>.from(examxquestion.map((x) => x.toJson())),
  };
}