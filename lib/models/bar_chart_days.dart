import 'package:ezan_official/models/transactions.dart';
import 'package:intl/intl.dart';

class Day {
  final String name;
  final double amountSpent;

  Day(this.name, this.amountSpent);
}

class Days {
  final List<Transaction> transactions;

  Days(this.transactions);
  List<Day> days = [];

  void getDayAmountSpent() {
    String currentDay = DateFormat('EEEE').format(DateTime.now());

    final today = DateFormat('EEEE').format(DateTime.now());

    final transactionsCount = transactions.length;
    double amount = 0.0;

    for (int i = 0; i < transactionsCount; i++) {
      final transactionDay = DateFormat('EEEE').format(transactions[i].date);

      if (transactionDay == currentDay) {
        amount += transactions[i].amount!;
      } else {
        days.insert(0, Day(currentDay, amount));
        amount = 0.0;
        i--;
        currentDay = transactionDay;
      }

      if (currentDay == today && days.isNotEmpty) {
        break;
      }
    }
    days = days.reversed.toList();
  }
}
