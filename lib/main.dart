import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/routines/routineCircles.dart';
import 'package:flutter_complete_guide/widgets/navbar.dart';
import './widgets/navbar.dart';
import 'routines/routines.dart';
import 'budget/myhomepage.dart';
//===================Hive test
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const TransactionBox = "Transactions_box";
const routinesBox = "Routines_Box";
void main() async {
  await Hive.initFlutter();
  await Hive.openBox(TransactionBox);
  await Hive.openBox(routinesBox);
  runApp(MyApp());
}

// void main() async {
//   await Hive.initFlutter();
//   await Hive.openBox<String>(favoritesBox);
//   runApp(MyHiveApp());
//

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFf7f5fd),
          primaryColorDark: Color(0xFF180448),
          primaryColorLight: Color(0xFF440fc0),
          cardColor: Colors.white,
          accentColor: Color(0xFFffc946),
          colorScheme: ColorScheme.light(),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF180448),
                ),
              ),
          fontFamily: "OpenSans",
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 32,
                fontWeight: FontWeight.bold),
          )),
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',

      //ROutes

      // initialRoute: MyHomePage.id,

      initialRoute: StreakTable.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        RoutinesPage.id: (context) => RoutinesPage(),
        NavDrawer.id: (context) => NavDrawer(),
        StreakCircles.id: (context) => StreakCircles(),
        StreakTable.id: (context) => StreakTable(),
      },
    );
  }
}
