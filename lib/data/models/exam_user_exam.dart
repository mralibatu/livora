import 'dart:convert';

class Examxuserexam {
  int id;
  int examId;
  int userId;
  bool isCompleted;
  int point;
  String username;

  Examxuserexam({
    required this.id,
    required this.examId,
    required this.userId,
    required this.isCompleted,
    required this.point,
    required this.username,
  });

  factory Examxuserexam.fromRawJson(String str) => Examxuserexam.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Examxuserexam.fromJson(Map<String, dynamic> json) => Examxuserexam(
    id: json["id"],
    examId: json["exam_id"],
    userId: json["user_id"],
    isCompleted: json["is_completed"],
    point: json["point"],
    username: json["userexamxuser"]["username"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "exam_id": examId,
    "user_id": userId,
    "is_completed": isCompleted,
    "point": point,
    "userexamxuser": username,
  };
}
