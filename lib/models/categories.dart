// ignore_for_file: unused_local_variable

import 'package:ezan_official/constants.dart';
import 'package:ezan_official/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum TransactionCategory {
  electronics,
  bills,
  restaurants,
  cafes,
  shopping,
  travel,
}

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
  Future<double> getTotal() async {
    final transactions = await Transactions.fetchTransactions();
    double total = 0;
    for (Transaction transaction in transactions) {
      total += transaction.amount ?? 0.0;
    }

    return total;
  }

  Future<List<Category>> getCategories() async {
    final transactions = await Transactions.fetchTransactions();

    List<Category> items = [];
    final total = await getTotal();

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
    items = List.generate(
      categoriesNames.length,
      (index) => Category(
        name: categoriesNames.values.toList()[index],
        color: categoriesColors.values.toList()[index],
        amount: categoriesAmounts.values.toList()[index],
        icon: categoriesIcons.values.toList()[index],
      ),
    );
    return items;
  }
}

final categoriesProvider = ChangeNotifierProvider(
  (ref) => Categories(),
);
