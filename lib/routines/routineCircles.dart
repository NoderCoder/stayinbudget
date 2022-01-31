//Updating to see the changes in the remote
//Test 1 : Making chanes and pushnin gonline

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

//On clicking the circle
  actionCompleted() {
    setState(() {});
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
    double cRadius = 15;
    return CircleAvatar(
      radius: cRadius,
      backgroundColor: Colors.grey,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: cRadius - 2,
      ),
    );
  }
}

class StreakTable extends StatelessWidget {
  const StreakTable({Key key}) : super(key: key);
  static String id = "StreakTable";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Streakz"),
      ),
      body: Column(
        children: [
          CustomPaint(
            painter: DrawDottedhorizontalline(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StreakBoxHolder(),
              StreakBoxHolder(),
              StreakBoxHolder(),
              StreakBoxHolder(),
              StreakBoxHolder(),
              StreakBoxHolder(),
            ],
          ),
          CustomPaint(
            painter: DrawDottedhorizontalline(),
          ),
        ],
      ),
    );
  }
}

class StreakBoxHolder extends StatelessWidget {
  const StreakBoxHolder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomPaint(
          painter: DrawHorizontalline(),
        ),
        SizedBox(
          height: 52,
          width: 52,
          child: Center(
            key: UniqueKey(),
            //replace with button
            child: TappableCircle(),
          ),
        ),
        CustomPaint(
          painter: DrawHorizontalline(),
        ),
      ],
    );
  }
}

/// PAinter
/// class DrawDottedhorizontalline extends CustomPaint
class DrawDottedhorizontalline extends CustomPainter {
  Paint _paint;
  DrawDottedhorizontalline() {
    _paint = Paint();
    _paint.color = Colors.black; //dots color
    _paint.strokeWidth = 1; //dots thickness
    _paint.strokeCap = StrokeCap.square; //dots corner edges
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -300; i < 300; i = i + 15) {
      // 15 is space between dots
      if (i % 3 == 0)
        canvas.drawLine(Offset(i, 0.0), Offset(i + 1, 0.0), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

//Horizonatla line painter
class DrawHorizontalline extends CustomPainter {
  Paint _paint;
  DrawHorizontalline() {
    _paint = Paint();
    _paint.color = Colors.black; //dots color
    _paint.strokeWidth = 2; //dots thickness
    _paint.strokeCap = StrokeCap.square; //dots corner edges
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -26; i < 26; i = i + 1) {
      // 15 is space between dots
      if (i % 3 == 0) canvas.drawLine(Offset(0, i), Offset(0.0, i + 1), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
