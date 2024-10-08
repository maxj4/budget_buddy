import 'package:isar/isar.dart';

part 'expense.g.dart';

@collection
class Transaction {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  String title;

  @Index(type: IndexType.value)
  double value;

  @Index(type: IndexType.value)
  DateTime date;

  @Index(type: IndexType.value)
  String? category;

  String? description;

  Transaction({
    required this.title,
    required this.value,
    required this.date,
    this.category,
    this.description,
  });

  @override
  String toString() {
    return 'Transaction{id: $id, title: $title, amount: $value, date: $date, category: $category, description: $description}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transaction &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          value == other.value &&
          date == other.date &&
          category == other.category &&
          description == other.description;

  @override
  int get hashCode =>
      title.hashCode ^
      value.hashCode ^
      date.hashCode ^
      category.hashCode ^
      description.hashCode;
}
