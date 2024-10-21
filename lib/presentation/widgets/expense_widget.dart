import 'package:budget_buddy/domain/entities/expense.dart';
import 'package:budget_buddy/presentation/bloc/expense_bloc.dart';
import 'package:budget_buddy/presentation/bloc/expense_event.dart';
import 'package:budget_buddy/presentation/widgets/expense_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseWidget extends StatelessWidget {
  final Expense expense;

  const ExpenseWidget({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
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
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        confirmDismiss: (_) {
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Delete Expense'),
                content:
                    const Text('Are you sure you want to delete this expense?'),
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
            },
          );
        },
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onLongPress: () {
            showAdaptiveDialog(
              context: context,
              builder: (BuildContext context) {
                return ExpenseDialog(
                  expense: expense,
                  isEditing: true,
                  onSave: (expense) {
                    BlocProvider.of<ExpenseBloc>(context)
                        .add(UpdateExpenseEvent(expense));
                  },
                );
              },
            );
          },
          title: Text(expense.title,
              style: Theme.of(context).textTheme.headlineSmall),
          subtitle: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  expense.amount > 0
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
              Row(
                children: [
                  expense.category != null && expense.category!.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: Text(
                            expense.category!,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  expense.description != null && expense.description!.isNotEmpty
                      ? Text(
                          expense.description!,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatDate(DateTime date) {
  return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year.toString().substring(2)} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
}
