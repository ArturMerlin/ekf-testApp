import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
  /// Класс человека с общими параметрами. Полностью соответствует модели ребёнка сотрудника
  String? firstName;
  String? lastName;
  String? middleName;
  DateTime? birthday;

  Person({this.firstName, this.lastName, this.middleName, this.birthday});

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}


