import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import './linepainters.dart';

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
                  children: dayRoutineRowList(
                      DateTime.utc(2022, 03), DateTime.utc(2022, 05))),
            ),
          ],
        ),
      ),
    );
  }
}

List<DayRoutineRow> dayRoutineRowList(DateTime startDate, DateTime endDate) {
  List<DayRoutineRow> tempdayRoutineRowList = [
    DayRoutineRow(
      day: "",
      date: "X)",
      boxRow: RoutineBoxHolderRow(),
    ),
  ];

  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    tempdayRoutineRowList.add(
      DayRoutineRow(
        date: DateFormat("d").format(startDate.add(Duration(days: i))),
        day: DateFormat("E")
            .format(startDate.add(Duration(days: i)))
            .toUpperCase(),
        boxRow: StreakBoxHolderRow(),
      ),
    );
  }

  return tempdayRoutineRowList;
}

class DayRoutineRow extends StatelessWidget {
  Widget boxRow;
  String day;
  String date;
  DayRoutineRow({Key key, this.boxRow, this.day, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomPaint(
          painter: DrawDottedhorizontalline(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    date,
                    style: GoogleFonts.allertaStencil(
                        textStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      day,
                      style: GoogleFonts.allertaStencil(
                          textStyle: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.normal)),
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

//ROutine box to hold the icons for the habit
class RoutineBoxHolderRow extends StatelessWidget {
  const RoutineBoxHolderRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoutineIconHolderBox(
          routineIcon: Icons.access_alarm,
        ),
        RoutineIconHolderBox(routineIcon: Icons.book),
        RoutineIconHolderBox(
          routineIcon: Icons.work_outline,
        ),
        RoutineIconHolderBox(routineIcon: Icons.computer),
        RoutineIconHolderBox(routineIcon: Icons.call_made),
        RoutineIconHolderBox(
          routineIcon: Icons.network_check,
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
          painter: DrawVerticalStraightLine(),
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
          painter: DrawVerticalStraightLine(),
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
          painter: DrawVerticalStraightLine(),
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
          painter: DrawVerticalStraightLine(),
        ),
      ],
    );
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

//Date time returner : this will gove me the list of dates to be displayed inbetween the streakz app
//TODO1: currebntly betwen some months will need to make ist dynamic


//Widget hirarchary
// Tappable circle < StreakBoxholder < StreakBOXholder ROw < DayRoutineROw <