import 'package:flutter/material.dart';

class StreakCircles extends StatefulWidget {
  static String id = "StreakCircles";

  @override
  _StreakCirclesState createState() => _StreakCirclesState();
}

class _StreakCirclesState extends State<StreakCircles> {
  List days = List.generate(10, (index) {
    return DateTime.now().day + index;
  });

  Color changeColor(Color color) {
    if (color == Colors.white) {
      return Colors.amber;
    } else
      return Colors.white;
  }

  Color streakColor = Colors.amber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: DataTable(
            dataRowHeight: 16,
            columns: [
              DataColumn(
                  label: Icon(
                Icons.monitor_weight,
                size: 18,
              )),
              DataColumn(
                  label: Icon(
                Icons.access_alarm,
                size: 18,
              )),
              DataColumn(
                  label: Icon(
                Icons.battery_alert_rounded,
                size: 18,
              )),
            ],
            rows: [
              DataRow(
                  cells: List.generate(3, (index) {
                return DataCell(
                  TappableCircle(),
                );
              })),
              DataRow(
                  cells: List.generate(3, (index) {
                return DataCell(
                    Container(
                      key: ValueKey(index),
                      height: 16,
                      width: 16,
                      color: Colors.grey,
                      child: Text("S$index"),
                    ),
                    onTap: () => setState(() {
                          Container(
                            key: ValueKey(index),
                            color: Colors.amber,
                          );
                          streakColor = changeColor(streakColor);
                        }));
              })),
            ],
          ),
        ),
      ),
    );
  }
}

class TappableCircle extends StatefulWidget {
  TappableCircle({Key key}) : super(key: key);
  @override
  _TappableCircleState createState() => _TappableCircleState();
}

class _TappableCircleState extends State<TappableCircle> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black12,
      radius: 20,
    );
  }
}
