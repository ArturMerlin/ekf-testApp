import 'package:efk_test_app/src/blocs/staff_bloc.dart';
import 'package:efk_test_app/src/models/staff.dart';
import 'package:efk_test_app/src/ui/screens/add_person_screen.dart';
import 'package:efk_test_app/src/ui/ui_elements/buttons.dart';
import 'package:efk_test_app/src/ui/ui_elements/person_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StaffListScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final StaffBloc staffBloc = StaffProvider.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<List<Staff>>(
        stream: staffBloc.staffListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Staff>? staffList = snapshot.data;
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UsualButton(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (c) => AddPersonScreen()));
                        },
                        text: "Добавить сотрудника",
                      ),
                      if (staffList!.length == 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text("В базе нет ни одного сотрудника :("),
                        ),
                      if (staffList.length > 0) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: ListView.separated(
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (c, i) {
                                Staff staff = staffList[i];
                                return PersonCard(person: staff);
                              },
                              separatorBuilder: (c, i) => Container(
                                    height: 8,
                                  ),
                              itemCount: staffList.length),
                        )
                      ]
                    ],
                  ),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
