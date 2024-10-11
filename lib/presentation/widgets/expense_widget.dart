import 'package:budget_buddy/domain/entities/expense.dart';
import 'package:budget_buddy/presentation/bloc/expense_bloc.dart';
import 'package:budget_buddy/presentation/bloc/expense_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseWidget extends StatelessWidget {
  final Expense expense;

  const ExpenseWidget({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    bool isExpense = expense.amount > 0;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.all(8),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(expense.title,
            style: Theme.of(context).textTheme.headlineSmall),
        subtitle: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isExpense
                    ? Text(
                        '-${expense.amount.toStringAsFixed(2)} €',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      )
                    : Text(
                        // Remove the leading - and add a + in front of the amount
                        '+${expense.amount.toStringAsFixed(2).substring(1)} €',
                        style: const TextStyle(
                          color: Colors.green,
                        ),
                      ),
                Text(_formatDate(expense.date)),
              ],
            ),
            if (expense.category != null && expense.category!.isNotEmpty)
              Row(
                children: [
                  Text(
                    expense.category!,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            showAdaptiveDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete Expense'),
                    content: const Text(
                        'Are you sure you want to delete this expense?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<ExpenseBloc>(context)
                              .add(DeleteExpenseEvent(expense.id));
                          Navigator.of(context).pop();
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}

String _formatDate(DateTime date) {
  return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year.toString().substring(2)} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
}
