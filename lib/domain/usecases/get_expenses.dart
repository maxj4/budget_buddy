import 'package:budget_buddy/core/error/failures.dart';
import 'package:budget_buddy/core/usecases/no_params.dart';
import 'package:budget_buddy/core/usecases/usecase.dart';
import 'package:budget_buddy/domain/entities/expense.dart';
import 'package:budget_buddy/domain/repositories/expense_repository.dart';
import 'package:dartz/dartz.dart';

class GetExpenses implements UseCase<List<Expense>, NoParams> {
  final ExpenseRepository repository;

  GetExpenses(this.repository);

  @override
  Future<Either<Failure, List<Expense>>> call(NoParams params) async {
    return await repository.getExpenses();
  }
}
