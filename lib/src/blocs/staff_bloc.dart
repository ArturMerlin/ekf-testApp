import 'dart:convert';

import 'package:efk_test_app/src/models/person.dart';
import 'package:efk_test_app/src/models/staff.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffBloc {
  /// Блок с логикой для сотрудников

  Subject<List<Staff>> _staffListSubj = BehaviorSubject();
  Subject<Person> _personSubj = BehaviorSubject();

  StaffBloc() {
    getStaffList();
  }

  Stream<List<Staff>> get staffListStream => _staffListSubj.stream;

  Stream<Person> get staffStream => _personSubj.stream;

  Sink<Person> get staffSink => _personSubj.sink;

  Future<void> getStaffList() async {
    /// Получение списка сотрудников из внутреннего хранилища устрайства
    SharedPreferences _preferences = await SharedPreferences.getInstance(); // получаем инстанс
    if (_preferences.containsKey("staff_list")) {
      // получаем список из  json строк сотрудников.
      List<String>? staffListEncoded = _preferences.getStringList("staff_list");
      // конвертируем json строку в json объект, а потом из него получаем объект сотрудника. Формируем список
      List<Staff> staffList = staffListEncoded!.map((e) => Staff.fromJson(json.decode(e))).toList();
      _staffListSubj.add(staffList);
    } else
      _staffListSubj.add([]);
  }

  bool validateStaff({required Staff staff}) {
    if (staff.firstName != null &&
        staff.lastName != null &&
        staff.middleName != null &&
        staff.birthday != null &&
        staff.post != null) return true;
    return false;
  }

  addStaff({required Staff staff}) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    List<Staff> staffList = await _staffListSubj.first;
    staffList.add(staff);
    _staffListSubj.add(staffList);
    List<String> staffListEncoded = staffList.map((e) => json.encode(e.toJson())).toList();
    _preferences.setStringList("staff_list", staffListEncoded);
  }

  bool validateChild({required Person child}) {
    if (child.firstName != null && child.lastName != null && child.middleName != null && child.birthday != null)
      return true;
    return false;
  }

  addChild({required Staff staff, required Person child}) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    List<Staff> staffList = await _staffListSubj.first;
    Staff _staff = staffList.singleWhere((element) => element == staff);
    if (_staff.children == null) _staff.children = [];
    _staff.children!.add(child);
    staffList[staffList.indexOf(_staff)] = _staff;
    _staffListSubj.add(staffList);
    List<String> staffListEncoded = staffList.map((e) => json.encode(e.toJson())).toList();
    _preferences.setStringList("staff_list", staffListEncoded);
  }

  dispose() {
    _staffListSubj.close();
    _personSubj.close();
  }
}

class StaffProvider extends InheritedWidget {
  final StaffBloc staffBloc;

  StaffProvider({
    Key? key,
    StaffBloc? staffBloc,
    required Widget child,
  })  : staffBloc = staffBloc ?? StaffBloc(),
        super(key: key, child: child);

  static StaffBloc of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<StaffProvider>()!.staffBloc;

  @override
  bool updateShouldNotify(StaffProvider old) {
    return true;
  }
}
