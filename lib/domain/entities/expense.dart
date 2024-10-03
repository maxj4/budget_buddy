import 'package:isar/isar.dart';

@collection
class Expense {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  String title;

  @Index(type: IndexType.value)
  double amount;

  @Index(type: IndexType.value)
  DateTime date;

  @Index(type: IndexType.value)
  String? category;

  String? description;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    this.category,
    this.description,
  });
}
