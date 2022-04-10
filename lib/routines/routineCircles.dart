import 'package:flutter/material.dart';
import './linepainters.dart';
import './dayroutinerows.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'boxholder.dart';

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

//-------------------------
//when moved to seperate file thsi creates error : gotta fix it

// the circle whic is tapped, lowesat in the widget tree
class TappableCircle extends StatefulWidget {
  final int id;
  TappableCircle({Key key, @required this.id}) : super(key: key);

  @override
  _TappableCircleState createState() => _TappableCircleState();
}

class _TappableCircleState extends State<TappableCircle> {
  Color tappableCircleColor = Colors.white;

  Color changeColor(Color color, int id) {
    if (color == Colors.white) {
      if (id == 1) {
        return Color.fromRGBO(255, 59, 48, 1);
      }
      if (id == 2) {
        return Color.fromRGBO(255, 150, 1, 1);
      }
      if (id == 3) {
        return Color.fromRGBO(255, 204, 0, 1);
      }
      if (id == 4) {
        return Color.fromRGBO(52, 198, 90, 1);
      }
      if (id == 5) {
        return Color.fromRGBO(1, 122, 255, 1);
      }
      if (id == 6) {
        return Color.fromRGBO(89, 86, 212, 1);
      }
    } else
      return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    double cRadius = 15;
    return InkWell(
      onTap: () => setState(() {
        tappableCircleColor = changeColor(tappableCircleColor, widget.id);
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

//----------------------------------

