import 'package:budget_buddy/domain/entities/expense.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class LoadTransactionEvent extends TransactionEvent {}

class AddTransactionEvent extends TransactionEvent {
  final Transaction transaction;

  const AddTransactionEvent(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class UpdateTransactionEvent extends TransactionEvent {
  final Transaction transaction;

  const UpdateTransactionEvent(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class DeleteTransactionEvent extends TransactionEvent {
  final int id;

  const DeleteTransactionEvent(this.id);

  @override
  List<Object> get props => [id];
}
