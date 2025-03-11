import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/bank_card.dart';
import 'bank_card_event.dart';
import 'bank_card_state.dart';

class BankCardBloc extends Bloc<BankCardEvent, BankCardState> {
  BankCardBloc() : super(BankCardInitial()) {
    on<LoadBankCard>((event, emit) {
      emit(BankCardLoaded(bankCard: event.bankCard));
    });
    on<FetchBankCardFromAPI>((event, emit) async {
      emit(BankCardLoading());
      try {
        final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));

        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final bankCard = BankCard.fromJson(data);
          emit(BankCardLoaded(bankCard: bankCard));
        } else {
          emit(BankCardError('Failed to fetch bank card'));
        }
      } catch (e) {
        emit(BankCardError('Error: $e'));
      }
    });
  }
}