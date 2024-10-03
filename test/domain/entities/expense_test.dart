import 'package:budget_buddy/domain/entities/expense.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Expense', () {
    test('should create an Expense object with all fields', () {
      final expense = Expense(
        title: 'Drinks',
        amount: 20.0,
        date: DateTime(2024, 10, 3),
        description: 'Night out with friends',
        category: 'Food & Drinks',
      );

      expect(expense.title, 'Drinks');
      expect(expense.amount, 20.0);
      expect(expense.date, DateTime(2024, 10, 3));
      expect(expense.description, 'Night out with friends');
      expect(expense.category, 'Food & Drinks');
    });

    test('should create an Expense object with required fields only', () {
      final expense = Expense(
        title: 'Drinks',
        amount: 20.0,
        date: DateTime(2024, 10, 3),
      );

      expect(expense.title, 'Drinks');
      expect(expense.amount, 20.0);
      expect(expense.date, DateTime(2024, 10, 3));
      expect(expense.description, null);
      expect(expense.category, null);
    });
  });
}
