import 'package:ezan_official/constants.dart';
import 'package:ezan_official/models/transactions.dart';
import 'package:flutter/material.dart';

class Category {
  final String name;
  double amount;
  final CustomIcon icon;
  final Color color;

  Category({
    required this.name,
    this.amount = 0,
    required this.icon,
    required this.color,
  });

  static Category fromTransaction(Transaction transaction) {
    return Category(
      name: transaction.name,
      color: categoriesColors[transaction.category]!,
      icon: categoriesIcons[transaction.category]!,
    );
  }
}

class Categories extends ChangeNotifier {
  final List<Transaction> transactions;
  Categories(this.transactions);

  double _total = 0.0;
  List<Category> _categories = [];

  double get total => _total;
  List<Category> get categories => [..._categories];

  void getTotal() {
    double total = 0;
    for (Transaction transaction in transactions) {
      total += transaction.amount ?? 0.0;
    }
    _total = total;
  }

  void getCategories() {
    final Map<TransactionCategory, double> categoriesAmounts = {
      TransactionCategory.bills: 0.0,
      TransactionCategory.cafes: 0.0,
      TransactionCategory.electronics: 0.0,
      TransactionCategory.restaurants: 0.0,
      TransactionCategory.shopping: 0.0,
      TransactionCategory.travel: 0.0,
    };

    for (Transaction transaction in transactions) {
      categoriesAmounts[transaction.category!] = categoriesAmounts[transaction.category!]! + transaction.amount!;
    }
    _categories = List.generate(
      6,
      (index) => Category(
        name: categoriesNames.values.toList()[index],
        color: categoriesColors.values.toList()[index],
        amount: categoriesAmounts.values.toList()[index],
        icon: categoriesIcons.values.toList()[index],
      ),
    );
  }
}
