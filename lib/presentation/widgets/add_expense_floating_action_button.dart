import 'package:budget_buddy/data/models/categories.dart';
import 'package:budget_buddy/domain/entities/expense.dart';
import 'package:budget_buddy/presentation/bloc/expense_bloc.dart';
import 'package:budget_buddy/presentation/bloc/expense_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AddExpenseFloatingActionButton extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  bool _isExpense = true;
  List<bool> _isSelected = [true, false];

  AddExpenseFloatingActionButton({
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
            return StatefulBuilder(
              builder: (context, setState) => AlertDialog.adaptive(
                title: const Text('Add Expense/Income'),
                content: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ToggleButtons(
                          isSelected: _isSelected,
                          borderRadius: BorderRadius.circular(8),
                          onPressed: (index) {
                            _isExpense = index == 0;
                            _isSelected = List.generate(2, (i) => i == index);
                            setState(() {});
                          },
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Expense'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Income'),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Title',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a title';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              expense.title = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Amount',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an amount';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              double amount = double.parse(value!);
                              expense.amount = _isExpense ? amount : -amount;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Category',
                            ),
                            items: categories.map((category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            onChanged: (value) {},
                            onSaved: (value) {
                              if (value != null) {
                                expense.category =
                                    value.isNotEmpty ? value : null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Description',
                            ),
                            onSaved: (value) {
                              expense.description = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        context
                            .read<ExpenseBloc>()
                            .add(AddExpenseEvent(expense));
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
