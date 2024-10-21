import 'package:budget_buddy/data/models/categories.dart';
import 'package:budget_buddy/domain/entities/expense.dart';
import 'package:flutter/material.dart';

class ExpenseDialog extends StatefulWidget {
  final Expense expense;
  final bool isEditing;
  final Function(Expense) onSave;

  const ExpenseDialog({
    super.key,
    required this.expense,
    required this.isEditing,
    required this.onSave,
  });

  @override
  State<ExpenseDialog> createState() => _ExpenseDialogState();
}

class _ExpenseDialogState extends State<ExpenseDialog> {
  final _formKey = GlobalKey<FormState>();
  late bool _isExpense;
  late List<bool> _isSelected;
  late Expense _expense;

  @override
  void initState() {
    super.initState();
    _expense = widget.expense;
    _isExpense = _expense.amount >= 0;
    _isSelected = [_isExpense, !_isExpense];
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.isEditing;
    return AlertDialog.adaptive(
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
                  initialValue: isEditing ? _expense.title : null,
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
                    _expense.title = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue:
                      isEditing ? _expense.amount.abs().toString() : null,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                  ),
                  keyboardType: TextInputType.number,
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
                    _expense.amount = _isExpense ? amount : -amount;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  value: _expense.category,
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
                      _expense.category = value.isNotEmpty ? value : null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: isEditing ? _expense.description : null,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  onSaved: (value) {
                    _expense.description = value;
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
              widget.onSave(_expense);
              Navigator.of(context).pop();
            }
          },
          child: Text(widget.isEditing ? 'Edit' : 'Add'),
        ),
      ],
    );
  }
}
