import 'dart:convert';

class Exam {
  int id;
  String examName;
  int? timerSeconds;
  bool isPrivate;
  int createdById;
  bool isMatching;
  List<Examxuserexam> examxuserexam;

  Exam({
    required this.id,
    required this.examName,
    this.timerSeconds,
    required this.isPrivate,
    required this.createdById,
    required this.isMatching,
    required this.examxuserexam,
  });

  factory Exam.fromRawJson(String str) => Exam.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
    id: json["id"],
    examName: json["exam_name"],
    timerSeconds: json["timer_seconds"],
    isPrivate: json["is_private"],
    createdById: json["created_by_id"],
    isMatching: json["is_matching"],
    examxuserexam: List<Examxuserexam>.from(json["examxuserexam"].map((x) => Examxuserexam.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "exam_name": examName,
    "timer_seconds": timerSeconds,
    "is_private": isPrivate,
    "created_by_id": createdById,
    "is_matching": isMatching,
    "examxuserexam": List<dynamic>.from(examxuserexam.map((x) => x.toJson())),
  };
}

class Examxuserexam {
  int id;
  int? examId;
  int? userId;
  bool? isCompleted;
  int? point;
  Userexamxuser userexamxuser;

  Examxuserexam({
    required this.id,
    this.examId,
    this.userId,
    this.isCompleted,
    this.point,
    required this.userexamxuser,
  });

  factory Examxuserexam.fromRawJson(String str) => Examxuserexam.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Examxuserexam.fromJson(Map<String, dynamic> json) => Examxuserexam(
    id: json["id"],
    examId: json["exam_id"],
    userId: json["user_id"],
    isCompleted: json["is_completed"],
    point: json["point"],
    userexamxuser: Userexamxuser.fromJson(json["userexamxuser"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "exam_id": examId,
    "user_id": userId,
    "is_completed": isCompleted,
    "point": point,
    "userexamxuser": userexamxuser.toJson(),
  };
}

class Userexamxuser {
  String username;

  Userexamxuser({
    required this.username,
  });

  factory Userexamxuser.fromRawJson(String str) => Userexamxuser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Userexamxuser.fromJson(Map<String, dynamic> json) => Userexamxuser(
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
  };
}
