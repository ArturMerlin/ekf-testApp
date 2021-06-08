// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Staff _$StaffFromJson(Map<String, dynamic> json) {
  return Staff(
    json['firstName'] as String,
    json['lastName'] as String,
    json['middleName'] as String,
    DateTime.parse(json['birthday'] as String),
    json['children'],
    json['post'] as String,
  );
}

Map<String, dynamic> _$StaffToJson(Staff instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'middleName': instance.middleName,
      'birthday': instance.birthday.toIso8601String(),
      'children': instance.children,
      'post': instance.post,
    };
