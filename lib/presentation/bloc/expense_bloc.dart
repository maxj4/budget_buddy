import 'package:budget_buddy/core/usecases/no_params.dart';
import 'package:budget_buddy/domain/usecases/add_expense.dart';
import 'package:budget_buddy/domain/usecases/delete_expense.dart';
import 'package:budget_buddy/domain/usecases/get_expenses.dart';
import 'package:budget_buddy/domain/usecases/update_expense.dart';
import 'package:budget_buddy/presentation/bloc/expense_event.dart';
import 'package:budget_buddy/presentation/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<TransactionEvent, ExpenseState> {
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
    on<LoadTransactionEvent>(_onLoadExpense);
    on<AddTransactionEvent>(_onAddExpense);
    on<UpdateTransactionEvent>(_onUpdateExpense);
    on<DeleteTransactionEvent>(_onDeleteExpense);
  }

  Future<void> _onLoadExpense(
      LoadTransactionEvent event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoading());
    final result = await getExpenses(NoParams());
    result.fold(
      (error) => emit(ExpenseError(error.message)),
      (expenses) => emit(ExpenseLoaded(expenses)),
    );
  }

  Future<void> _onAddExpense(
      AddTransactionEvent event, Emitter<ExpenseState> emit) async {
    // emit(ExpenseLoading());
    final result = await addExpense(event.transaction);
    result.fold(
      (error) => emit(ExpenseError(error.message)),
      (_) => add(LoadTransactionEvent()),
    );
  }

  Future<void> _onUpdateExpense(
      UpdateTransactionEvent event, Emitter<ExpenseState> emit) async {
    // emit(ExpenseLoading());
    final result = await updateExpense(event.transaction);
    result.fold(
      (error) => emit(ExpenseError(error.message)),
      (_) => add(LoadTransactionEvent()),
    );
  }

  Future<void> _onDeleteExpense(
      DeleteTransactionEvent event, Emitter<ExpenseState> emit) async {
    // emit(ExpenseLoading());
    final result = await deleteExpense(event.id);
    result.fold(
      (error) => emit(ExpenseError(error.message)),
      (_) => add(LoadTransactionEvent()),
    );
  }
}
