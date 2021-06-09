import 'package:efk_test_app/src/models/person.dart';
import 'package:efk_test_app/src/models/staff.dart';
import 'package:efk_test_app/src/ui/screens/add_person_screen.dart';
import 'package:efk_test_app/src/ui/ui_elements/buttons.dart';
import 'package:efk_test_app/src/ui/ui_elements/person_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedPersonCard extends StatelessWidget {
  final Person person;

  const DetailedPersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _textDecoration("Фамилия", "${person.lastName!}"),
          _textDecoration("Имя", "${person.firstName!}"),
          _textDecoration("Отчество", "${person.middleName!}"),
          if (person is Staff) _textDecoration("Должность", "${(person as Staff).post}"),
          _textDecoration(
              "День Рождения", "${person.birthday!.day}.${person.birthday!.month}.${person.birthday!.year}"),
          if (person is Staff) _textDecoration("Количество детей","${(person as Staff).children?.length ?? 0}"),
          if (person is Staff)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: UsualButton(
              onTap: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (c) => AddPersonScreen(parent: (person as Staff),)));
              },
              text: "Добавить ребёнка",
            ),
          ),
          if (person is Staff && ((person as Staff).children?.length ?? 0) > 0)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (c, i) {
                    Person child = (person as Staff).children![i];
                    return PersonCard(person: child);
                  },
                  separatorBuilder: (c, i) => Container(
                        height: 8,
                      ),
                  itemCount: (person as Staff).children!.length),
            )
        ],
      ),
    );
  }

  _textDecoration(String label, String text) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 2,color: Colors.blue,style: BorderStyle.solid))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 200,
            child: Text(
              label,
              style: TextStyle().copyWith(fontSize: 16),
            ),
          ),
          Text(
            text,
            style: TextStyle().copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
