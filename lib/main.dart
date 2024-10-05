import 'package:budget_buddy/data/datasources/expense_local_datasource.dart';
import 'package:budget_buddy/data/repositories/expense_repository_impl.dart';
import 'package:budget_buddy/domain/usecases/add_expense.dart';
import 'package:budget_buddy/domain/usecases/delete_expense.dart';
import 'package:budget_buddy/domain/usecases/get_expenses.dart';
import 'package:budget_buddy/domain/usecases/update_expense.dart';
import 'package:budget_buddy/presentation/bloc/expense_bloc.dart';
import 'package:budget_buddy/presentation/bloc/expense_event.dart';
import 'package:budget_buddy/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final localDataSource = ExpenseLocalDatasource();
  final repository = ExpenseRepositoryImpl(localDataSource);

  final getExpenses = GetExpenses(repository);
  final addExpense = AddExpense(repository);
  final updateExpense = UpdateExpense(repository);
  final deleteExpense = DeleteExpense(repository);

  runApp(MainApp(
    expenseBloc: ExpenseBloc(
      getExpenses: getExpenses,
      addExpense: addExpense,
      updateExpense: updateExpense,
      deleteExpense: deleteExpense,
    ),
  ));
}

class MainApp extends StatelessWidget {
  final ExpenseBloc expenseBloc;

  const MainApp({super.key, required this.expenseBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => expenseBloc..add(LoadExpenseEvent()),
      child: MaterialApp(
        theme: AppTheme.darkTheme,
        home: const MainPage(),
      ),
    );
  }
}
