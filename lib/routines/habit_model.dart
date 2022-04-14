import 'package:flutter/material.dart';

class Habit {
  int Nameid; //should be a number associated with name
  Icon icon;
  bool completed;
  DateTime timeStamp;

  Habit(
      {@required this.Nameid,
      @required this.completed,
      @required this.timeStamp});
}
