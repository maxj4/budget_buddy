import 'package:budget_buddy/core/error/failures.dart';
import 'package:budget_buddy/domain/entities/expense.dart';
import 'package:dartz/dartz.dart';

abstract class ExpenseRepository {
  Future<Either<Failure, List<Transaction>>> getExpenses();
  Future<Either<Failure, void>> addExpense(Transaction expense);
  Future<Either<Failure, void>> updateExpense(Transaction expense);
  Future<Either<Failure, void>> deleteExpense(int id);
}
