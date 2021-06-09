import 'package:efk_test_app/src/models/person.dart';
import 'package:efk_test_app/src/ui/ui_elements/detailed_person_card.dart';
import 'package:flutter/material.dart';

class DetailedPersonScreen extends StatelessWidget {
  /// Экран детальной информации по сотруднику или ребёнку
  final Person person;

  const DetailedPersonScreen({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DetailedPersonCard(
        person: person,
      ),
    );
  }
}
