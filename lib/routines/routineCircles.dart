//Updating to see the changes in the remote
//Test 1 : Making chanes and pushnin gonline

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          DayRoutineRow(
            day: "Act",
            boxRow: RoutineBoxHolderRow(),
          ),
          DayRoutineRow(
            boxRow: StreakBoxHolderRow(),
            day: "9",
          ),
        ],
      ),
    );
  }
}

class DayRoutineRow extends StatelessWidget {
  Widget boxRow;
  String day;
  DayRoutineRow({Key key, this.boxRow, this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          painter: DrawDottedhorizontalline(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Row(
                children: [
                  Center(
                    child: Text(
                      day,
                      style: GoogleFonts.allertaStencil(
                          textStyle: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            boxRow,
          ],
        ),
        CustomPaint(
          painter: DrawDottedhorizontalline(),
        ),
      ],
    );
  }
}

class RoutineBoxHolderRow extends StatelessWidget {
  const RoutineBoxHolderRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoutineIconHolderBox(
          routineIcon: Icons.access_alarm,
        ),
        RoutineIconHolderBox(
          routineIcon: Icons.access_alarm,
        ),
        RoutineIconHolderBox(
          routineIcon: Icons.access_alarm,
        ),
        RoutineIconHolderBox(
          routineIcon: Icons.access_alarm,
        ),
        RoutineIconHolderBox(
          routineIcon: Icons.access_alarm,
        ),
        RoutineIconHolderBox(
          routineIcon: Icons.access_alarm,
        ),
      ],
    );
  }
}

//widget to hold the RoutineBox
class RoutineIconHolderBox extends StatelessWidget {
  IconData routineIcon;
  RoutineIconHolderBox({Key key, this.routineIcon}) : super(key: key);

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
            child: Icon(routineIcon),
          ),
        ),
        CustomPaint(
          painter: DrawHorizontalline(),
        ),
      ],
    );
  }
}

//Hold set of streakboxes in a row
class StreakBoxHolderRow extends StatelessWidget {
  const StreakBoxHolderRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StreakBoxHolder(),
        StreakBoxHolder(),
        StreakBoxHolder(),
        StreakBoxHolder(),
        StreakBoxHolder(),
        StreakBoxHolder(),
      ],
    );
  }
}

//making the box for holding the tappabele circle or some other widget
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

//Horizonatla line painter fir the decoration
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

// the circle whic is tapped, lowesat in the widget tree
class TappableCircle extends StatefulWidget {
  TappableCircle({Key key}) : super(key: key);

  @override
  _TappableCircleState createState() => _TappableCircleState();
}

class _TappableCircleState extends State<TappableCircle> {
  Color tappableCircleColor = Colors.white;
  Color changeColor(Color color) {
    if (color == Colors.white) {
      return Colors.amber;
    } else
      return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    double cRadius = 15;
    return InkWell(
      onTap: () => setState(() {
        tappableCircleColor = changeColor(tappableCircleColor);
      }),
      child: CircleAvatar(
        radius: cRadius,
        backgroundColor: Colors.grey,
        child: CircleAvatar(
          backgroundColor: tappableCircleColor,
          radius: cRadius - 2,
        ),
      ),
    );
  }
}
