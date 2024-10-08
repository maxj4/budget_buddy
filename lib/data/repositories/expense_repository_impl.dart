import 'package:budget_buddy/core/error/failures.dart';
import 'package:budget_buddy/data/datasources/expense_local_datasource.dart';
import 'package:budget_buddy/domain/entities/expense.dart';
import 'package:budget_buddy/domain/repositories/expense_repository.dart';
import 'package:dartz/dartz.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDatasource localDatasource;

  ExpenseRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<Transaction>>> getExpenses() async {
    try {
      final expenses = await localDatasource.getExpenses();
      return Right(expenses);
    } catch (e) {
      return const Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addExpense(Transaction expense) async {
    try {
      await localDatasource.addExpense(expense);
      return const Right(null);
    } catch (e) {
      return const Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateExpense(Transaction expense) async {
    try {
      await localDatasource.updateExpense(expense);
      return const Right(null);
    } catch (e) {
      return const Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense(int id) async {
    try {
      await localDatasource.deleteExpense(id);
      return const Right(null);
    } catch (e) {
      return const Left(DatabaseFailure());
    }
  }
}
