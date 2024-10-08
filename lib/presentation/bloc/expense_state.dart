import 'package:budget_buddy/domain/entities/expense.dart';
import 'package:equatable/equatable.dart';

abstract class ExpenseState extends Equatable {
  // TODO explain the use of Equatable
  const ExpenseState();

  @override
  List<Object> get props => [];
}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Transaction> expenses;

  const ExpenseLoaded(this.expenses);

  @override
  List<Object> get props => [expenses];
}

class ExpenseError extends ExpenseState {
  final String message;

  const ExpenseError(this.message);

  @override
  List<Object> get props => [message];
}
