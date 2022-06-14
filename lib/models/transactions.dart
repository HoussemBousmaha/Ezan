import 'dart:math' as math;

import 'package:ezan_official/constants.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

class Transaction {
  final int id;
  final DateTime date;
  // assigned from the sms message body using regexp.
  String? name;
  double? amount;

  TransactionCategory? category;
  bool isIncome = false;

  Transaction({
    required this.id,
    required this.date,
    this.name,
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
      final doubleRE = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");
      final amount = double.parse(doubleRE.firstMatch(message.body!)?.group(0) ?? '0.0');

      const start = 'From';
      const end = 'on';

      final startIndex = message.body!.indexOf(start);
      final endIndex = message.body!.indexOf(end, startIndex + start.length);

      final name = message.body!.substring(startIndex + start.length, endIndex).trim();

      final transaction = Transaction.smsToTransaction(message);
      transaction.amount = amount;
      transaction.name = name;
      transaction.category = TransactionCategory.values[math.Random().nextInt(TransactionCategory.values.length)];
      return transaction;
    }).toList();

    state = purchases;
  }
}
