import 'package:flutter/material.dart';
import './linepainters.dart';
import './dayroutinerows.dart';
import './habit_model.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'boxholder.dart';

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
            miniHabitIconRow,
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

//--------------------------
//lIST OF HABITS T
List<Habit> habitList = [
  Habit(Nameid: 1, completed: true, timeStamp: DateTime.now()),
];

//-------------------------
//when moved to seperate file thsi creates error : gotta fix it
// the circle whic is tapped, lowesat in the widget tree
class TappableCircle extends StatefulWidget {
  // id will be used to define the number linked ot the daily habit
  final int id;
  TappableCircle({Key key, @required this.id}) : super(key: key);

  @override
  _TappableCircleState createState() => _TappableCircleState();
}

class _TappableCircleState extends State<TappableCircle> {
  Color tappableCircleColor = Colors.white;
  bool isCircleTapped = true;

  Color onCircleTap(Color color, int id) {
    Habit tempHabit =
        Habit(Nameid: id, completed: isCircleTapped, timeStamp: DateTime.now());
    if (color == Colors.white) {
      if (id == 1) {
        habitList.add(tempHabit);
        return Color.fromRGBO(255, 59, 48, 1);
      } else if (id == 2) {
        habitList.add(tempHabit);
        return Color.fromRGBO(255, 150, 1, 1);
      } else if (id == 3) {
        habitList.add(tempHabit);
        return Color.fromRGBO(255, 204, 0, 1);
      } else if (id == 4) {
        habitList.add(tempHabit);
        return Color.fromRGBO(52, 198, 90, 1);
      } else if (id == 5) {
        habitList.add(tempHabit);
        return Color.fromRGBO(1, 122, 255, 1);
      } else if (id == 6) {
        habitList.add(tempHabit);
        return Color.fromRGBO(89, 86, 212, 1);
      }
    } else {
      habitList.add(tempHabit);
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    double cRadius = 15;
    return InkWell(
      onTap: () => setState(() {
        isCircleTapped = !isCircleTapped;

        print(habitList.length);
        print(habitList.last.Nameid);
        print(habitList.last.completed);
        print(habitList.last.timeStamp);

        tappableCircleColor = onCircleTap(tappableCircleColor, widget.id);
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

