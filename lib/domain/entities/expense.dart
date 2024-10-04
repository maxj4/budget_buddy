import 'package:isar/isar.dart';

part 'expense.g.dart';

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

  @override
  String toString() {
    return 'Expense{title: $title, amount: $amount, date: $date, category: $category, description: $description}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Expense &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          amount == other.amount &&
          date == other.date &&
          category == other.category &&
          description == other.description;

  @override
  int get hashCode =>
      title.hashCode ^
      amount.hashCode ^
      date.hashCode ^
      category.hashCode ^
      description.hashCode;
}
