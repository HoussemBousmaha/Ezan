import 'package:ezan_official/constants.dart';
import 'package:ezan_official/models/transactions.dart';
import 'package:ezan_official/providers/transactions_provider.dart';
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
  double amountPercentage;
  final CustomIcon icon;
  final Color color;

  Category({
    required this.name,
    this.amountPercentage = 0,
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
  final ChangeNotifierProviderRef ref;

  List<Category> _items = [];
  List<Category> get items => [..._items];
  double _total = 0;
  double get total => _total;

  Categories(this.ref);

  Future<void> calculatePercentages() async {
    final transactions = ref.watch(allTransactionsProvider);
    transactions.when(
      data: (transactions) {
        for (Transaction transaction in transactions) {
          _total += transaction.amount ?? 0.0;
        }

        for (Transaction transaction in transactions) {
          categoriesPercentages[transaction.category!] = categoriesPercentages[transaction.category!]! + transaction.amount! / _total;
        }
        _items = List.generate(
          categoriesNames.length,
          (index) => Category(
            name: categoriesNames.values.toList()[index],
            color: categoriesColors.values.toList()[index],
            amountPercentage: categoriesPercentages.values.toList()[index],
            icon: categoriesIcons.values.toList()[index],
          ),
        );
      },
      error: (e, s) => null,
      loading: () => null,
    );
  }
}

final categoriesProvider = ChangeNotifierProvider(
  (ref) {
    final categories = Categories(ref);
    categories.calculatePercentages();
    return categories;
  },
);
