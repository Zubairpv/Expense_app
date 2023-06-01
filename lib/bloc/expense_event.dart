part of 'expense_bloc.dart';

@immutable
abstract class ExpenseEvent {}

class Add extends ExpenseEvent {
  final TextEditingController reasoncontroller;
  final TextEditingController amountcontroller;
  final TextEditingController timecontroller;
  Add(this.reasoncontroller, this.amountcontroller, this.timecontroller);
}

class Get extends ExpenseEvent {
  final DateTime selected;
  Get(this.selected);
}

class select extends ExpenseEvent {
  final DateTime selected;
  select(this.selected);
}

class Clear extends ExpenseEvent {}
