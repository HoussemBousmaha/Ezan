import 'dart:math';

import 'package:ezan_official/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

class Transaction {
  final int id;
  final String name;
  final DateTime date;
  double? amount; // assigned from the sms message body using regexp.
  TransactionCategory? category;
  bool isIncome = false;

  Transaction({
    required this.id,
    required this.name,
    required this.date,
    this.amount,
    this.category,
  });

  factory Transaction.smsToTransaction(SmsMessage message) {
    return Transaction(
      id: message.id!,
      name: message.sender!,
      date: message.date!,
    );
  }
}

class Transactions extends ChangeNotifier {
  final List<SmsMessage> messages;
  Transactions(this.messages);

  List<Transaction> _state = demoTransactions;
  List<Transaction> get state => [..._state];

  void getTransactions() {
    final filteredTransactions = messages.where((message) {
      return message.body!.contains('PoS Purchase') || message.body!.contains('شراء عبر نقاط البيع');
    }).toList();

    final purchases = filteredTransactions.map((message) {
      final doubleRE = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");
      final amount = double.parse(doubleRE.firstMatch(message.body!)?.group(0) ?? '0.0');
      final transaction = Transaction.smsToTransaction(message);
      transaction.amount = amount;
      transaction.category = TransactionCategory.values[Random().nextInt(
        TransactionCategory.values.length,
      )];
      return transaction;
    }).toList();

    if (purchases.isNotEmpty) {
      _state = purchases;
    }
  }
}
