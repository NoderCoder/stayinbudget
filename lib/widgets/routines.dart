import 'package:flutter/material.dart';

class Routines extends StatefulWidget {
  static String id = "Routines";

  @override
  _RoutinesState createState() => _RoutinesState();
}

class _RoutinesState extends State<Routines> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" My Routines"),
      ),
      body: Container(),
    );
  }
}
