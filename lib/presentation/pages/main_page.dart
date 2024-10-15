import 'package:budget_buddy/domain/entities/expense.dart';
import 'package:budget_buddy/presentation/bloc/expense_bloc.dart';
import 'package:budget_buddy/presentation/bloc/expense_state.dart';
import 'package:budget_buddy/presentation/widgets/add_expense_floating_action_button.dart';
import 'package:budget_buddy/presentation/widgets/expense_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _showMonthly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const Text('Monthly'),
          const SizedBox(width: 8),
          Switch(
            value: _showMonthly,
            onChanged: (value) {
              setState(() {
                _showMonthly = value;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              _showAboutDialog(context);
            },
          ),
        ],
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
          final List<Expense> expenses = state.expenses
              .where((expense) => _showMonthly
                  ? expense.date.month == DateTime.now().month
                  : true)
              .toList();
          final double totalAmount =
              expenses.fold(0, (sum, expense) => sum + expense.amount);
          return Column(
            children: [
              _showMonthly
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Text(
                            _getMonthName(),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Expanded(
                child: ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
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

  Future<dynamic> _showAboutDialog(BuildContext context) {
    return showAdaptiveDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('About'),
            content: const Text("""
Budget Buddy is a simple expense tracker app. This is a hobby project created by a Flutter enthusiast.
The app is open-source and can be found on GitHub: https://github.com/maxj4/budget_buddy\n
The app icon is provided by Flaticon.com: https://www.flaticon.com/free-icon/circle-b_11183363"""),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        });
  }

  String _getMonthName() {
    final month = DateTime.now().month;
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}
