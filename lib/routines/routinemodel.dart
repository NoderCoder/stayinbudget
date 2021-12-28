import 'package:flutter/foundation.dart';

class Routine {
  final String title;
  bool checked;
  DateTime checkedDate;

  Routine({
    @required this.title,
    @required this.checked,
    @required this.checkedDate,
  });
}
