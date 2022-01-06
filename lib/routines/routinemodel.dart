import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Routine {
  @HiveField(0)
  final String title;
  @HiveField(1)
  bool checked;
  @HiveField(2)
  DateTime checkedDate;

  Routine({
    @required this.title,
    @required this.checked,
    @required this.checkedDate,
  });
}
