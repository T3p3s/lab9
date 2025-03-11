import '../models/bank_card.dart';

abstract class BankCardState {}

class BankCardInitial extends BankCardState {}
class BankCardLoading extends BankCardState {}
class BankCardLoaded extends BankCardState {
  final BankCard bankCard;
  BankCardLoaded({required this.bankCard});
}
class BankCardError extends BankCardState {
  final String message;
  BankCardError(this.message);
}
