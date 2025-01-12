// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      surname: json['surname'] as String,
      username: json['username'] as String,
      photo: json['photo'] as String,
      password: json['password'] as String,
      dailyGoal: (json['daily_goal'] as num?)?.toInt(),
      streakCount: (json['streak_count'] as num).toInt(),
      deviceId: json['device_id'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'username': instance.username,
      'photo': instance.photo,
      'password': instance.password,
      'daily_goal': instance.dailyGoal,
      'streak_count': instance.streakCount,
      'device_id': instance.deviceId,
    };
