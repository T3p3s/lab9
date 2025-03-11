class BankCard {
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;

  BankCard({
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
  });

  factory BankCard.fromJson(Map<String, dynamic> json) {
    return BankCard(
      cardNumber: json['phone'] ?? '0000 0000 0000 0000',  
      cardHolder: json['name'] ?? 'Unknown Holder',  
      expiryDate: '12/25', 
    );
  }
}
