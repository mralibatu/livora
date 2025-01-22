// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exam _$ExamFromJson(Map<String, dynamic> json) => Exam(
      id: (json['id'] as num).toInt(),
      examName: json['exam_name'] as String,
      timerSeconds: (json['timer_seconds'] as num?)?.toInt(),
      isPrivate: json['is_private'] as bool,
      createdById: (json['created_by_id'] as num).toInt(),
      isMatching: json['is_matching'] as bool,
      username: "mralibatu" //For testing,
    );

Map<String, dynamic> _$ExamToJson(Exam instance) => <String, dynamic>{
      'id': instance.id,
      'exam_name': instance.examName,
      'timer_seconds': instance.timerSeconds,
      'is_private': instance.isPrivate,
      'created_by_id': instance.createdById,
      'is_matching': instance.isMatching,
    };
