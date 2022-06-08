import 'package:ezan_official/models/transactions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final daysProvider = Provider(
  (ref) => Days(),
);

class Day {
  final String name;
  final double amountSpent;

  Day(this.name, this.amountSpent);
}

class Days {
  Future<List<Day>> getDayAmountSpent() async {
    List<Day> days = [];
    String currentday = DateFormat('EEEE').format(DateTime.now());
    String today = DateFormat('EEEE').format(DateTime.now());

    final transactions = await Transactions.fetchTransactions();
    final transactionsCount = transactions.length;
    double amount = 0.0;
    for (int i = 0; i < transactionsCount; i++) {
      final transactionDay = DateFormat('EEEE').format(transactions[i].date);
      if (transactionDay == currentday) {
        amount += transactions[i].amount!;
      } else {
        days.insert(0, Day(currentday, amount));
        amount = 0.0;
        i--;
        currentday = transactionDay;
      }

      if (currentday == today) {
        break;
      }
    }

    return days.reversed.toList();
  }
}
