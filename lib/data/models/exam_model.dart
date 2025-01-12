import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'exam_model.g.dart';

@JsonSerializable()
class Exam {
  final int id;
  @JsonKey(name: 'exam_name')
  final String examName;
  @JsonKey(name: 'timer_seconds')
  final int? timerSeconds;
  @JsonKey(name: 'is_private')
  final bool isPrivate;
  @JsonKey(name: 'created_by_id')
  final int createdById;
  @JsonKey(name: 'is_matching')
  final bool isMatching;
  @JsonKey(name: 'examxuserexam')
  final String username;

  Exam({
    required this.id,
    required this.examName,
    this.timerSeconds,
    required this.isPrivate,
    required this.createdById,
    required this.isMatching,
    required this.username,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => _$ExamFromJson(json);

  Map<String, dynamic> toJson() => _$ExamToJson(this);
}

class ExamStats {
  String userId;
  int totalExams;
  int completedExams;
  int successfulExams;
  String averageScore;
  List<ExamStat> examStats;

  ExamStats({
    required this.userId,
    required this.totalExams,
    required this.completedExams,
    required this.successfulExams,
    required this.averageScore,
    required this.examStats,
  });

  factory ExamStats.fromRawJson(String str) => ExamStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExamStats.fromJson(Map<String, dynamic> json) => ExamStats(
    userId: json["userId"],
    totalExams: json["totalExams"],
    completedExams: json["completedExams"],
    successfulExams: json["successfulExams"],
    averageScore: json["averageScore"],
    examStats: List<ExamStat>.from(json["examStats"].map((x) => ExamStat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "totalExams": totalExams,
    "completedExams": completedExams,
    "successfulExams": successfulExams,
    "averageScore": averageScore,
    "examStats": List<dynamic>.from(examStats.map((x) => x.toJson())),
  };
}

class ExamStat {
  int examId;
  String examName;
  bool isCompleted;
  int point;
  bool isSuccessful;

  ExamStat({
    required this.examId,
    required this.examName,
    required this.isCompleted,
    required this.point,
    required this.isSuccessful,
  });

  factory ExamStat.fromRawJson(String str) => ExamStat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExamStat.fromJson(Map<String, dynamic> json) => ExamStat(
    examId: json["examId"],
    examName: json["exam_name"],
    isCompleted: json["isCompleted"],
    point: json["point"],
    isSuccessful: json["isSuccessful"],
  );

  Map<String, dynamic> toJson() => {
    "examId": examId,
    "exam_name": examName,
    "isCompleted": isCompleted,
    "point": point,
    "isSuccessful": isSuccessful,
  };
}
