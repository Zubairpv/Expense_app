import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:image/bloc/expense_bloc.dart';

class ExpenseChart extends StatefulWidget {
  final ExpenseState state;

  ExpenseChart({required this.state});

  @override
  _ExpenseChartState createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart> {
  late Map<int, double> _weekdayExpenses;

  @override
  void initState() {
    super.initState();
    _computeWeekdayExpenses();
  }

  void _computeWeekdayExpenses() {
    _weekdayExpenses = {};
    for (int i = 0; i < widget.state.amount.length; i++) {
      DateTime date = widget.state.select;
      int weekday = date.weekday;
      double amount = double.parse(widget.state.amount[i]);
      _weekdayExpenses.update(weekday, (value) => value + amount,
          ifAbsent: () => amount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, getTitlesWidget: getBottomTiles),
              )),
          borderData: FlBorderData(show: false),
          barGroups: _weekdayExpenses.entries
              .map(
                (entry) => BarChartGroupData(
                  x: entry.key,
                  barRods: [
                    BarChartRodData(
                      toY: entry.value,
                      color: Colors.black,
                      width: 16,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

Widget getBottomTiles(double value, TitleMeta meta) {
  const style =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'S',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'M',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'T',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'W',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'T',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'F',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'S',
        style: style,
      );
      break;
    default:
      text = const Text(
        '',
        style: style,
      );
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
