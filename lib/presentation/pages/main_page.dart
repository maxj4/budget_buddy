import 'package:budget_buddy/presentation/bloc/expense_bloc.dart';
import 'package:budget_buddy/presentation/bloc/expense_state.dart';
import 'package:budget_buddy/presentation/widgets/add_expense_floating_action_button.dart';
import 'package:budget_buddy/presentation/widgets/expense_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Budget Buddy',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
        if (state is ExpenseInitial) {
          return const Center(
            child: Text('Initial'),
          );
        } else if (state is ExpenseLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ExpenseLoaded) {
          final double totalAmount =
              state.expenses.fold(0, (sum, expense) => sum + expense.amount);
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.expenses.length,
                  itemBuilder: (context, index) {
                    final expense = state.expenses[index];
                    return ExpenseWidget(expense: expense);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    totalAmount > 0
                        ? Text(
                            'Total: -${totalAmount.toStringAsFixed(2)} €',
                            style: Theme.of(context).textTheme.headlineMedium,
                          )
                        : Text(
                            'Total: +${totalAmount.abs().toStringAsFixed(2)} €',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                  ],
                ),
              ),
            ],
          );
        } else if (state is ExpenseError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('Unknown State'),
          );
        }
      }),
      floatingActionButton: AddExpenseFloatingActionButton(),
    );
  }
}
