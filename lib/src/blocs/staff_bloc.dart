import 'dart:convert';

import 'package:efk_test_app/src/models/staff.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffBloc {
  /// Блок с логикой для сотрудников

  Subject<List<Staff>> _staffListSubj = BehaviorSubject();
  Subject<Staff> _staffSubj = BehaviorSubject();
  Staff staff = Staff();

  StaffBloc() {
    getStaffList();
  }

  Stream<List<Staff>> get staffListStream => _staffListSubj.stream;

  Stream<Staff> get staffStream => _staffSubj.stream;

  Sink<Staff> get staffSink => _staffSubj.sink;

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

  bool validateStaff() {
    if (staff.firstName != null &&
        staff.lastName != null &&
        staff.middleName != null &&
        staff.birthday != null &&
        staff.post != null) return true;
    return false;
  }

  addStaff() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    List<Staff> staffList = await _staffListSubj.first;
    staffList.add(staff);
    _staffListSubj.add(staffList);
    List<String> staffListEncoded = staffList.map((e) => json.encode(e.toJson())).toList();
    _preferences.setStringList("staff_list", staffListEncoded);
  }

  dispose() {
    _staffListSubj.close();
    _staffSubj.close();
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
