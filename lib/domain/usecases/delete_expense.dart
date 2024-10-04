import 'package:budget_buddy/core/error/failures.dart';
import 'package:budget_buddy/core/usecases/usecase.dart';
import 'package:budget_buddy/domain/repositories/expense_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteExpense implements UseCase<void, int> {
  final ExpenseRepository repository;

  DeleteExpense(this.repository);

  @override
  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteExpense(id);
  }
}
