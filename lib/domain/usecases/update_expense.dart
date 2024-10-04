import 'package:budget_buddy/core/error/failures.dart';
import 'package:budget_buddy/core/usecases/usecase.dart';
import 'package:budget_buddy/domain/entities/expense.dart';
import 'package:budget_buddy/domain/repositories/expense_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateExpense implements UseCase<void, Expense> {
  final ExpenseRepository repository;

  UpdateExpense(this.repository);

  @override
  Future<Either<Failure, void>> call(Expense expense) async {
    return await repository.updateExpense(expense);
  }
}
