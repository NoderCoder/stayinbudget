import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/main.dart';
import 'routinemodel.dart';
import '../models/quotesbank.dart';
import 'package:hive/hive.dart';

List<Routine> dailyRoutines = [
  Routine(
      title: "Morning Workout", checked: false, checkedDate: DateTime.now()),
  Routine(title: "Vocab review", checked: false, checkedDate: DateTime.now()),
  Routine(title: "Goal", checked: false, checkedDate: DateTime.now()),
  Routine(title: "Meditate", checked: false, checkedDate: DateTime.now()),
  Routine(title: "Code", checked: false, checkedDate: DateTime.now()),
];
List<Quote> stoicQuotesList = QuotesBank().makeStoicQuotesList();

class RoutinesPage extends StatefulWidget {
  static String id = "RoutinesPage";
  final int streakDay = 1;
  final int totalDays = 30;
  final DateTime dateTime = DateTime.now();

  // RoutinesPage(this.streakDay, this.totalDays, this.dateTime);

  @override
  _RoutinesPageState createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> {
  final bool _checked = false;
  List<Routine> singleDayRoutineList = dailyRoutines;

  void saveTheRoutine(List<Routine> routineList) async {
    var dailyRoutineBox = await Hive.openBox<List<Routine>>("Routines_Box");
    dailyRoutineBox.add(routineList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" My Routines"),
      ),
      body: ListView(
        children: [
          ExpansionTile(
              title: Text(
                " Day ${widget.totalDays} of ${widget.totalDays} ",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              subtitle: Text("12/27/2021",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 12,
                      )),
              children: [
                Text(stoicQuotesList[1].quoteText),
                ...singleDayRoutineList.map<Widget>((routine) {
                  return CheckboxListTile(
                      title: Text(
                        routine.title,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            decoration: routine.checked
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      value: routine.checked,
                      onChanged: (bool value) {
                        setState(() {
                          routine.checked = value;
                          routine.checkedDate = DateTime.now();
                        });
                      });
                })
              ]),

          //Another tile to test
          ExpansionTile(
              title: Text(
                " Day ${widget.streakDay} of ${widget.totalDays} ",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              subtitle: Text("12/27/2021",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 12,
                      )),
              children: [
                Text(stoicQuotesList[1].quoteText),
                ...singleDayRoutineList.map<Widget>((routine) {
                  return CheckboxListTile(
                      title: Text(
                        routine.title,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            decoration: routine.checked
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      value: routine.checked,
                      onChanged: (bool value) {
                        setState(() {
                          routine.checked = value;
                          routine.checkedDate = DateTime.now();
                          // saveTheRoutine(singleDayRoutineList);
                        });
                      });
                })
              ]),
        ],
      ),
    );
  }
}

// Snapshot of dailyroutine list is stored for each day e n 6yfxec3edwb