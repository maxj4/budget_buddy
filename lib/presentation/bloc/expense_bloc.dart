import 'package:budget_buddy/core/usecases/no_params.dart';
import 'package:budget_buddy/domain/usecases/add_expense.dart';
import 'package:budget_buddy/domain/usecases/delete_expense.dart';
import 'package:budget_buddy/domain/usecases/get_expenses.dart';
import 'package:budget_buddy/domain/usecases/update_expense.dart';
import 'package:budget_buddy/presentation/bloc/expense_event.dart';
import 'package:budget_buddy/presentation/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final GetExpenses getExpenses;
  final AddExpense addExpense;
  final UpdateExpense updateExpense;
  final DeleteExpense deleteExpense;

  ExpenseBloc({
    required this.getExpenses,
    required this.addExpense,
    required this.updateExpense,
    required this.deleteExpense,
  }) : super(ExpenseInitial()) {
    on<LoadExpenseEvent>(_onLoadExpense);
    on<AddExpenseEvent>(_onAddExpense);
    on<UpdateExpenseEvent>(_onUpdateExpense);
    on<DeleteExpenseEvent>(_onDeleteExpense);
  }

  Future<void> _onLoadExpense(
      LoadExpenseEvent event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoading());
    final result = await getExpenses(NoParams());
    result.fold(
      (error) => emit(ExpenseError(error.message)),
      (expenses) => emit(ExpenseLoaded(expenses)),
    );
  }

  Future<void> _onAddExpense(
      AddExpenseEvent event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoading());
    final result = await addExpense(event.expense);
    result.fold(
      (error) => emit(ExpenseError(error.message)),
      (_) => add(LoadExpenseEvent()),
    );
  }

  Future<void> _onUpdateExpense(
      UpdateExpenseEvent event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoading());
    final result = await updateExpense(event.expense);
    result.fold(
      (error) => emit(ExpenseError(error.message)),
      (_) => add(LoadExpenseEvent()),
    );
  }

  Future<void> _onDeleteExpense(
      DeleteExpenseEvent event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoading());
    final result = await deleteExpense(event.id);
    result.fold(
      (error) => emit(ExpenseError(error.message)),
      (_) => add(LoadExpenseEvent()),
    );
  }
}
