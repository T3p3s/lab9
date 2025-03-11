import '../models/bank_card.dart';
abstract class BankCardEvent {}

class LoadBankCard extends BankCardEvent {
  final BankCard bankCard;
  LoadBankCard(this.bankCard);
}

class FetchBankCardFromAPI extends BankCardEvent {}