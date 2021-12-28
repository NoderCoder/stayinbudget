import 'package:flutter/foundation.dart';

class Routine {
  final String title;
  bool checked;
  DateTime checkedDate;
  int id;

  Routine({
    @required this.title,
    @required this.checked,
    @required this.checkedDate,
    @required this.id,
  });
}
