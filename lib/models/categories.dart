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

const categoriesNames = {
  TransactionCategory.bills: 'الفواتير',
  TransactionCategory.cafes: 'المقاهي',
  TransactionCategory.electronics: 'الالكترونيات',
  TransactionCategory.restaurants: 'المطاعم',
  TransactionCategory.shopping: 'التسوق',
  TransactionCategory.travel: 'السفر و السياحة',
};

const categoriesColors = {
  TransactionCategory.bills: Colors.blueAccent,
  TransactionCategory.cafes: Colors.redAccent,
  TransactionCategory.electronics: Colors.greenAccent,
  TransactionCategory.restaurants: Colors.indigo,
  TransactionCategory.shopping: Colors.amberAccent,
  TransactionCategory.travel: Colors.purpleAccent,
};

final Map<TransactionCategory, double> categoriesPercentages = {
  TransactionCategory.bills: 0.0,
  TransactionCategory.cafes: 0.0,
  TransactionCategory.electronics: 0.0,
  TransactionCategory.restaurants: 0.0,
  TransactionCategory.shopping: 0.0,
  TransactionCategory.travel: 0.0,
};

class Category {
  final String name;
  double amountPercentage;
  final ColorSwatch<int>? color;

  Category({
    required this.name,
    this.amountPercentage = 0,
    required this.color,
  });

  static Category fromTransaction(Transaction transaction) {
    return Category(
      name: transaction.name!,
      color: categoriesColors[transaction.category],
    );
  }
}

class Categories extends ChangeNotifier {
  final ChangeNotifierProviderRef ref;

  List<Category> _items = [];
  List<Category> get items => [..._items];
  double total = 0;

  Categories(this.ref);

  Future<void> calculatePercentages() async {
    final transactions = ref.watch(allTransactionsProvider);
    transactions.when(
      data: (transactions) {
        for (Transaction transaction in transactions) {
          // log('category: ${transaction.category} - amount: ${transaction.amount}');
          total += transaction.amount ?? 0.0;
        }
        // log('total: $total');
        for (Transaction transaction in transactions) {
          categoriesPercentages[transaction.category!] = categoriesPercentages[transaction.category!]! + transaction.amount! / (total * 1);
          // log('percenrage of ${transaction.category!} = ${categoriesPercentages[transaction.category!]}');
        }
        _items = List.generate(
          categoriesNames.length,
          (index) => Category(
            name: categoriesNames.values.toList()[index],
            color: categoriesColors.values.toList()[index],
            amountPercentage: categoriesPercentages.values.toList()[index],
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
