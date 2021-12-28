import 'dart:ui';

import 'package:flutter/material.dart';
import 'routinemodel.dart';
import '../models/quotesbank.dart';

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
  bool _checked = false;
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
                RoutineTile("Day 1 of 30", "12/27/2022", '3'),
                Text(stoicQuotesList[1].quoteText),
                ...dailyRoutines.map<Widget>((routine) {
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
        ],
      ),
    );
  }
}

class RoutineTile extends StatelessWidget {
  final String transactionTitle;
  final String transactionDate;
  final String transactionAmount;

  RoutineTile(
      this.transactionTitle, this.transactionDate, this.transactionAmount);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        child: Container(
          width: double.infinity,
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        foregroundColor: Colors.grey[700],
                        child: const Icon(
                          Icons.import_export_rounded,
                          size: 32,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactionTitle,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(transactionDate,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 12,
                                  )),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        transactionAmount,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.amber[300],
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text("+3%",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
