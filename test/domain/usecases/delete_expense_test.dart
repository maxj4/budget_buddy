import 'package:budget_buddy/domain/usecases/delete_expense.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  group('DeleteExpense Use Case', () {
    late MockExpenseRepository mockRepository;
    late DeleteExpense useCase;

    setUp(() {
      mockRepository = MockExpenseRepository();
      useCase = DeleteExpense(mockRepository);
    });

    test('calls repository', () async {
      const id = 1;

      when(mockRepository.deleteExpense(id))
          .thenAnswer((_) async => const Right(null));

      final result = await useCase(id);

      expect(result, const Right(null));
      verify(mockRepository.deleteExpense(id)).called(1);
    });
  });
}
