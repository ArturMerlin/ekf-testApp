// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    middleName: json['middleName'] as String?,
    birthday: json['birthday'] == null
        ? null
        : DateTime.parse(json['birthday'] as String),
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'middleName': instance.middleName,
      'birthday': instance.birthday?.toIso8601String(),
    };
