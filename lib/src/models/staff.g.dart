// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Staff _$StaffFromJson(Map<String, dynamic> json) {
  return Staff(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    middleName: json['middleName'] as String,
    birthday: DateTime.parse(json['birthday'] as String),
    children: json['children'],
    post: json['post'] as String,
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
