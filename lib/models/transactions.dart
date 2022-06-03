import 'package:ezan_official/services/sms_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

class Transaction {
  final int? id;
  final String? name;
  final DateTime? date;
  double? amount; // assigned from the sms message body using regexp.
  bool isIncome = false;

  // String? category; // for later.

  Transaction({
    required this.id,
    required this.name,
    required this.date,
    this.amount,
  });

  factory Transaction.smsToTransaction(SmsMessage message) {
    return Transaction(
      id: message.id,
      name: message.sender,
      date: message.date,
    );
  }
}

class Transactions extends ChangeNotifier {
  final _items = [];
  List<Transaction> get allTransactions => [..._items];

  Future<List<Transaction>> get purchases async {
    final SmsService service = SmsService();
    final messages = await service.getSmsMessages();

    final filteredTransactions = messages.where((message) {
      return message.body!.contains('PoS Purchase');
    }).toList();

    final purchases = filteredTransactions.map((message) {
      final doubleRE = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");
      final amount = double.parse(doubleRE.firstMatch(message.body!)?.group(0) ?? '0.0');
      final transaction = Transaction.smsToTransaction(message);
      transaction.amount = amount;
      return transaction;
    }).toList();

    return purchases;
  }
}
