  import 'package:flutter/material.dart';

final List<Color> colors = [
    Color.fromARGB(255, 146, 236, 248),
    Color.fromARGB(255, 121, 107, 94),
    Color.fromARGB(255, 39, 44, 39),
    Colors.yellow,
    Colors.orange,
    Colors.red,
    Colors.indigo,
    Colors.blue,
    Colors.green,
    Colors.grey,
  ];

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);