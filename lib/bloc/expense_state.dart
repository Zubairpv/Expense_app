part of 'expense_bloc.dart';

class ExpenseState {
  final List<String> amount;
  final List<String> time;
  final List<String> reason;
  DateTime select;
  ExpenseState({
    required this.amount,
    required this.time,
    required this.reason,
    required this.select,
  });
}

class ExpenseInitial extends ExpenseState {
  ExpenseInitial()
      : super(amount: [], time: [], reason: [], select: DateTime.now());
}
