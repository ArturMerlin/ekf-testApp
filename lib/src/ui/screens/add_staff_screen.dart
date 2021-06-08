import 'package:efk_test_app/src/blocs/staff_bloc.dart';
import 'package:efk_test_app/src/models/staff.dart';
import 'package:efk_test_app/src/ui/ui_elements/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddStaffScreen extends StatefulWidget {
  @override
  _AddStaffScreenState createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  late StaffBloc staffBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    staffBloc = StaffProvider.of(context);
    staffBloc.staff = Staff();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: AppBar(),
        body: StreamBuilder<Staff>(
            stream: staffBloc.staffStream,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    _textField(
                      label: "Фамилия",
                      controllerText: staffBloc.staff.lastName,
                      onChanged: (value) {
                        staffBloc.staff.lastName = value;
                      },
                    ),
                    Container(
                      height: 8,
                    ),
                    _textField(
                      label: "Имя",
                      controllerText: staffBloc.staff.firstName,
                      onChanged: (value) {
                        staffBloc.staff.firstName = value;
                      },
                    ),
                    Container(
                      height: 8,
                    ),
                    _textField(
                      label: "Отчество",
                      controllerText: staffBloc.staff.middleName,
                      onChanged: (value) {
                        staffBloc.staff.middleName = value;
                      },
                    ),
                    Container(
                      height: 8,
                    ),
                    _birthdayField(context),
                    Container(
                      height: 8,
                    ),
                    _textField(
                      label: "Пост",
                      controllerText: staffBloc.staff.post,
                      onChanged: (value) {
                        staffBloc.staff.post = value;
                      },
                    ),
                    Container(
                      height: 8,
                    ),
                    UsualButton(
                        onTap: () async{
                          if (staffBloc.validateStaff()) {
                            await staffBloc.addStaff();
                            Navigator.of(context).pop();
                          } else
                            showDialog(
                                context: context,
                                builder: (_) =>
                                new AlertDialog(
                                  title: new Text("Заполнены не все поля"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Закрыть'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                ));
                        },
                        text: "Сохранить")
                  ],
                ),
              );
            }),
      ),
    );
  }

  _birthdayField(BuildContext context) {
    return Container(
      height: 68,
      padding: EdgeInsets.only(left: 16, right: 16, top: 14, bottom: 14),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey, width: 2)),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {
          var date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              lastDate: new DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: ThemeData(
                      accentColor: Colors.blue, primaryColor: Colors.blue, primaryColorBrightness: Brightness.dark),
                  child: child!,
                );
              },
              firstDate: DateTime(1900));

          if (date != null) {
            staffBloc.staff.birthday = date;
            staffBloc.staffSink.add(staffBloc.staff);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (staffBloc.staff.birthday == null)
              Text("День рождения",
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.7),
                  ).copyWith(fontSize: 16)),
            if (staffBloc.staff.birthday != null) ...[
              Text("День рождения",
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.7),
                  ).copyWith(fontSize: 12)),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                    "${staffBloc.staff.birthday!.day}.${staffBloc.staff.birthday!.month}.${staffBloc.staff.birthday!
                        .year}",
                    style: TextStyle()),
              ),
            ]
          ],
        ),
      ),
    );
  }

  _textField({required String label, String? controllerText, ValueChanged<String>? onChanged}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey, width: 2)),
      child: TextField(
        controller: TextEditingController(text: controllerText ?? ""),
        onChanged: (value) {
          onChanged!(value);
        },
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          alignLabelWithHint: false,
          contentPadding: EdgeInsets.only(left: 16, right: 16, top: 14, bottom: 14),
          border: InputBorder.none,
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
