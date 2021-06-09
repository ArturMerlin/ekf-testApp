import 'package:efk_test_app/src/models/person.dart';
import 'package:efk_test_app/src/models/staff.dart';
import 'package:efk_test_app/src/ui/screens/detailed_person_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  /// Краткая информация о сотруднике или ребёнке
  final Person person;

  const PersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(builder: (c) => DetailedPersonScreen(person: person,)));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${person.lastName!} ${person.firstName!.substring(0, 1)}. ${person.middleName!.substring(0, 1)}."),
            if (person is Staff) Text("${(person as Staff).post}"),
            Text(
              "${person.birthday!.day}.${person.birthday!.month}.${person.birthday!.year}",
            ),
            if (person is Staff) Text("${(person as Staff).children?.length ?? 0}")
          ],
        ),
      ),
    );
  }
}
