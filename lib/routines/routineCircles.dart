import 'package:flutter/material.dart';
import './linepainters.dart';
import './dayroutinerows.dart';

class StreakTable extends StatelessWidget {
  const StreakTable({Key key}) : super(key: key);
  static String id = "StreakTable";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomPaint(
              painter: DrawHorizontallStraightLine(),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 100,
              child: ListView(
                  //TODO1: currebntly betwen some months will need to make ist dynamic
                  children: dayRoutineRowList(
                      DateTime.utc(2022, 03), DateTime.utc(2022, 05))),
            ),
          ],
        ),
      ),
    );
  }
}
