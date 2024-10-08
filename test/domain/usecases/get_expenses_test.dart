import 'package:budget_buddy/core/usecases/no_params.dart';
import 'package:budget_buddy/domain/entities/expense.dart';
import 'package:budget_buddy/domain/usecases/get_expenses.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  group('GetExpenses Use Case', () {
    late MockExpenseRepository mockRepository;
    late GetExpenses useCase;

    setUp(() {
      mockRepository = MockExpenseRepository();
      useCase = GetExpenses(mockRepository);
    });

    test('calls repository', () async {
      final expense = Transaction(
        date: DateTime(2024, 10, 3),
        title: 'Test',
        category: 'Test',
        description: 'Test description',
        value: 100.0,
      );
      final NoParams params = NoParams();

      when(mockRepository.getExpenses())
          .thenAnswer((_) async => Right([expense]));

      final result = await useCase(params);

      result.fold(
        (l) => fail('Should not return a failure'),
        (r) => expect(r, [expense]),
      );
      verify(mockRepository.getExpenses()).called(1);
    });
  });
}
