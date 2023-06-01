import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(ExpenseInitial()) {
    on<Add>((event, emit) async {
      List<String> newAmount = List.from(state.amount)
        ..add(event.amountcontroller.text);
      List<String> newReason = List.from(state.reason)
        ..add(event.reasoncontroller.text);
      List<String> newTime = List.from(state.time)
        ..add(event.timecontroller.text);

      SharedPreferences sf = await SharedPreferences.getInstance();
      sf.setStringList(
          '${DateFormat("yyyy-MM-dd").format(state.select)}amount', newAmount);
      sf.setStringList(
          '${DateFormat("yyyy-MM-dd").format(state.select)}reason', newReason);
      sf.setStringList(
          '${DateFormat("yyyy-MM-dd").format(state.select)}time', newTime);
      return emit(ExpenseState(
          amount: newAmount,
          reason: newReason,
          time: newTime,
          select: state.select,
         ));
    });
    on<Get>((event, emit) async {
      SharedPreferences sf = await SharedPreferences.getInstance();
      emit(ExpenseState(
        
          amount: sf.getStringList(
              '${DateFormat("yyyy-MM-dd").format(state.select)}amount')!,
          reason: sf.getStringList(
              '${DateFormat("yyyy-MM-dd").format(state.select)}reason')!,
          time: sf.getStringList(
              '${DateFormat("yyyy-MM-dd").format(state.select)}time')!,
          select: state.select));
    });
    on<select>((event, emit) {
      return emit(ExpenseState(
          amount: state.amount,
          time: state.time,
          reason: state.reason,
          select: event.selected,
       ));
    });
    on((event, emit) {
      List<String> newAmount = List.from(state.amount)..clear();
      List<String> newReason = List.from(state.reason)..clear();
      List<String> newTime = List.from(state.time)..clear();
  
      return emit(ExpenseState(
          amount: newAmount,
          reason: newReason,
          time: newTime,
          select: state.select,
         ));
    });
  }
}
