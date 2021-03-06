import 'package:efk_test_app/src/models/person.dart';
import 'package:json_annotation/json_annotation.dart';

part 'staff.g.dart';

@JsonSerializable()
class Staff extends Person {
  /// Модель сотрудника
  List<Person>? children;
  String? post;

  Staff({String? firstName, String? lastName, String? middleName, DateTime? birthday, this.children, this.post})
      : super(firstName: firstName, lastName: lastName, middleName: middleName, birthday: birthday);

  factory Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);

  Map<String, dynamic> toJson() => _$StaffToJson(this);
}
