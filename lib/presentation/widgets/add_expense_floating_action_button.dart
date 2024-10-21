import 'package:budget_buddy/domain/entities/expense.dart';
import 'package:budget_buddy/presentation/bloc/expense_bloc.dart';
import 'package:budget_buddy/presentation/bloc/expense_event.dart';
import 'package:budget_buddy/presentation/widgets/expense_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseFloatingActionButton extends StatelessWidget {
  const AddExpenseFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        final expense = Expense(
          title: 'New Expense',
          amount: 0,
          date: DateTime.now(),
        );

        showAdaptiveDialog(
            context: context,
            builder: (BuildContext context) {
              return ExpenseDialog(
                  expense: expense,
                  isEditing: false,
                  onSave: (expense) {
                    BlocProvider.of<ExpenseBloc>(context)
                        .add(AddExpenseEvent(expense));
                  });
            });
      },
    );
  }
}
