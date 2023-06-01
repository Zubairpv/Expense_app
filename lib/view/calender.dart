import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/view/select.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controller/bloc/expense_bloc.dart';
import 'aaa.dart';
import 'bardata.dart';

class hiiii extends StatefulWidget {
  @override
  State<hiiii> createState() => _hiiiiState();
}

class _hiiiiState extends State<hiiii> {
  final TextEditingController reasoncontroller = TextEditingController();
  final TextEditingController amountcontroller = TextEditingController();
  final TextEditingController timecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, state) {
            BlocProvider.of<ExpenseBloc>(context).add(Get(state.select));
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10),
                  height: 90,
                  decoration: BoxDecoration(
                      color: Colors.amber.shade300,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: TableCalendar(
                    headerVisible: false,
                    firstDay:
                        DateTime(kToday.year, kToday.month - 3, kToday.day),
                    lastDay:
                        DateTime(kToday.year, kToday.month + 3, kToday.day),
                    focusedDay: DateTime.now(),
                    calendarFormat: CalendarFormat.week,
                    selectedDayPredicate: (day) {
                      return isSameDay(state.select, day);
                    },
                    calendarStyle:
                        const CalendarStyle(isTodayHighlighted: false),
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(state.select, selectedDay)) {
                        BlocProvider.of<ExpenseBloc>(context)
                            .add(select(selectedDay));
                        BlocProvider.of<ExpenseBloc>(context).add(Clear());
                        BlocProvider.of<ExpenseBloc>(context)
                            .add(Get(selectedDay));
                      }
                    },
                  ),
                ),
                ExpenseChart(state: state),
                SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: state.reason.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.2),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                                color: colors[index % colors.length],
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Icon(Icons.restore_sharp),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                        state.reason[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(state.time[index]),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 135),
                                    child: Icon(
                                      Icons.currency_rupee,
                                      size: 15,
                                    ),
                                  ),
                                ),
                                Text(
                                  state.amount[index],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: () {
        popUp(context, reasoncontroller, amountcontroller, timecontroller);
      }),
    );
  }
}
