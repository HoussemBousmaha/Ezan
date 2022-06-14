import 'dart:math' as math;
import 'dart:developer' as developer;

import 'package:ezan_official/constants.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

class Transaction {
  final int id;
  final String name;
  final DateTime date;
  double? amount; // assigned from the sms message body using regexp.
  TransactionCategory? category; // this is NULL if isIncome is True.
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

class Transactions {
  final List<SmsMessage> messages;
  Transactions(this.messages);

  List<Transaction> state = [];

  void getTransactions() {
    final filteredTransactions = messages.where((message) {
      return message.body!.contains('PoS Purchase') || message.body!.contains('شراء عبر نقاط البيع');
    }).toList();

    final purchases = filteredTransactions.map((message) {
      developer.log(message.body!);
      final doubleRE = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");
      final amount = double.parse(doubleRE.firstMatch(message.body!)?.group(0) ?? '0.0');
      final transaction = Transaction.smsToTransaction(message);
      transaction.amount = amount;
      transaction.category = TransactionCategory.values[math.Random().nextInt(
        TransactionCategory.values.length,
      )];
      return transaction;
    }).toList();

    // if (purchases.isNotEmpty) {
    //   _state = purchases;
    // }

    state = purchases;
  }
}
