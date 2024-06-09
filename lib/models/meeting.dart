import 'package:flutter/material.dart';

class Meeting {
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final Color background;
  final bool isAllDay;

  Meeting({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.background,
    required this.isAllDay,
  });
}
