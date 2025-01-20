import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  int id;
  String name;
  String surname;
  String username;
  String photo;
  String password;
  @JsonKey(name: 'daily_goal')
  int? dailyGoal;
  @JsonKey(name: 'streak_count')
  int streakCount;
  @JsonKey(name: 'device_id')
  String deviceId;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.username,
    required this.photo,
    required this.password,
    this.dailyGoal,
    required this.streakCount,
    required this.deviceId,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
