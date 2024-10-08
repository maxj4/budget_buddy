import 'package:budget_buddy/domain/entities/expense.dart';
import 'package:budget_buddy/domain/usecases/add_expense.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  group('AddExpense Use Case', () {
    late MockExpenseRepository mockRepository;
    late AddExpense useCase;

    setUp(() {
      mockRepository = MockExpenseRepository();
      useCase = AddExpense(mockRepository);
    });

    test('calls repository', () async {
      final Transaction expense = Transaction(
        date: DateTime(2024, 10, 3),
        title: 'Test',
        category: 'Test',
        description: 'Test description',
        value: 100.0,
      );

      when(mockRepository.addExpense(expense))
          .thenAnswer((_) async => const Right(null));

      final result = await useCase(expense);

      expect(result, const Right(null));
      verify(mockRepository.addExpense(expense)).called(1);
    });
  });
}
