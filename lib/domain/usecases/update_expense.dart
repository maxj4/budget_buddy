import 'package:budget_buddy/core/error/failures.dart';
import 'package:budget_buddy/core/usecases/usecase.dart';
import 'package:budget_buddy/domain/entities/expense.dart';
import 'package:budget_buddy/domain/repositories/expense_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateExpense implements UseCase<void, Transaction> {
  final ExpenseRepository repository;

  UpdateExpense(this.repository);

  @override
  Future<Either<Failure, void>> call(Transaction expense) async {
    return await repository.updateExpense(expense);
  }
}
