import 'package:budget_buddy/domain/entities/expense.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class ExpenseLocalDatasource {
  late Future<Isar> _db;

  ExpenseLocalDatasource() {
    _db = _openDB();
  }

  Future<Isar> _openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [ExpenseSchema],
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<List<Expense>> getExpenses() async {
    final isar = await _db;
    return await isar.expenses.where().findAll();
  }

  Future<void> _putExpense(Expense expense) async {
    final isar = await _db;
    isar.writeTxn(() async {
      await isar.expenses.put(expense);
    });
  }

  Future<void> addExpense(Expense expense) async {
    await _putExpense(expense);
  }

  Future<void> updateExpense(Expense expense) async {
    await _putExpense(expense);
  }

  Future<void> deleteExpense(int id) async {
    final isar = await _db;
    isar.writeTxn(() async {
      await isar.expenses.delete(id);
    });
  }
}
