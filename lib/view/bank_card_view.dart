import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import '../bloc/bank_card_bloc.dart';
import '../bloc/bank_card_state.dart';
import '../bloc/bank_card_event.dart';
import '../models/bank_card.dart';

class BankCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Card', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: Icon(CupertinoIcons.creditcard),
      ),
      body: BlocBuilder<BankCardBloc, BankCardState>(
        builder: (context, state) {
          if (state is BankCardInitial) {
            return _buildInitialUI(context);
          } else if (state is BankCardLoading) {
            return _buildLoadingUI();
          } else if (state is BankCardLoaded) {
            return _buildCardUI(state.bankCard);
          } else if (state is BankCardError) {
            return _buildErrorUI(state.message);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildInitialUI(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {
          BlocProvider.of<BankCardBloc>(context).add(FetchBankCardFromAPI());
        },
        child: Text('Fetch Bank Card', style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  Widget _buildLoadingUI() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildCardUI(BankCard bankCard) {
    return Center(
      child: Container(
        width: 350,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blue[800],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bank Card', style: TextStyle(color: Colors.white70, fontSize: 16)),
            SizedBox(height: 12),
            Text(
              bankCard.cardNumber,
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Card Holder', style: TextStyle(color: Colors.white70)),
                    Text(bankCard.cardHolder, style: TextStyle(color: Colors.white, fontSize: 18)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Expiry Date', style: TextStyle(color: Colors.white70)),
                    Text(bankCard.expiryDate, style: TextStyle(color: Colors.white, fontSize: 18)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorUI(String message) {
    return Center(
      child: Text(message, style: TextStyle(color: Colors.red, fontSize: 18)),
    );
  }
}
