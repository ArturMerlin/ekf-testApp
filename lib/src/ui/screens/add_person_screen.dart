import 'package:efk_test_app/src/blocs/staff_bloc.dart';
import 'package:efk_test_app/src/models/person.dart';
import 'package:efk_test_app/src/models/staff.dart';
import 'package:efk_test_app/src/ui/ui_elements/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPersonScreen extends StatefulWidget {
  final Staff? parent;

  const AddPersonScreen({Key? key, this.parent}) : super(key: key);

  @override
  _AddPersonScreenState createState() => _AddPersonScreenState();
}

class _AddPersonScreenState extends State<AddPersonScreen> {
  late StaffBloc staffBloc;
  late Person person;

  @override
  void initState() {
    super.initState();
    person = widget.parent == null ? Staff() : Person();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    staffBloc = StaffProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: AppBar(),
        body: StreamBuilder<Person>(
            stream: staffBloc.staffStream,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    _textField(
                      label: "Фамилия",
                      controllerText: person.lastName,
                      onChanged: (value) {
                        person.lastName = value;
                      },
                    ),
                    Container(
                      height: 8,
                    ),
                    _textField(
                      label: "Имя",
                      controllerText: person.firstName,
                      onChanged: (value) {
                        person.firstName = value;
                      },
                    ),
                    Container(
                      height: 8,
                    ),
                    _textField(
                      label: "Отчество",
                      controllerText: person.middleName,
                      onChanged: (value) {
                        person.middleName = value;
                      },
                    ),
                    Container(
                      height: 8,
                    ),
                    _birthdayField(context),
                    Container(
                      height: 8,
                    ),
                    if (person is Staff)
                      _textField(
                        label: "Пост",
                        controllerText: (person as Staff).post,
                        onChanged: (value) {
                          (person as Staff).post = value;
                        },
                      ),
                    Container(
                      height: 8,
                    ),
                    UsualButton(
                        onTap: () async {
                          if (person is Staff) {
                            if (staffBloc.validateStaff(staff: (person as Staff))) {
                              await staffBloc.addStaff(staff: (person as Staff));
                              Navigator.of(context).pop();
                            } else
                              showDialog(
                                  context: context,
                                  builder: (_) => new AlertDialog(
                                        title: new Text("Заполнены не все поля"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Закрыть'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ));
                          } else {
                            if (staffBloc.validateChild(child: person)) {
                              await staffBloc.addChild(staff: widget.parent!, child: person);
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            } else
                              showDialog(
                                  context: context,
                                  builder: (_) => new AlertDialog(
                                        title: new Text("Заполнены не все поля"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Закрыть'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ));
                          }
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
            person.birthday = date;
            staffBloc.staffSink.add(person);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (person.birthday == null)
              Text("День рождения",
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.7),
                  ).copyWith(fontSize: 16)),
            if (person.birthday != null) ...[
              Text("День рождения",
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.7),
                  ).copyWith(fontSize: 12)),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                    "${person.birthday!.day}.${person.birthday!.month}.${person.birthday!.year}",
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
