import 'dart:math' as math;

import 'package:ezan_official/models/bar_chart_days.dart';
import 'package:ezan_official/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

const daysNames = [
  'الأحد',
  'الإثنين',
  'الثلاثاء',
  'الأربعاء',
  'الخميس',
  'الجمعة',
  'السبت',
];
final Map<String, String> englishToArabic = {
  'Sunday': 'الأحد',
  'Monday': 'الإثنين',
  'Tuesday': 'الثلاثاء',
  'Wednesday': 'الأربعاء',
  'Thursday': 'الخميس',
  'Friday': 'الجمعة',
  'Saturday': 'السبت',
};

enum TransactionCategory {
  electronics,
  bills,
  restaurants,
  cafes,
  shopping,
  travel,
}

final demoTransactions = List.generate(
  200,
  (index) {
    final randomAmount = math.Random().nextInt(100).toDouble();
    final randomDate = DateTime.now().subtract(Duration(days: math.Random().nextInt(7)));
    final randomCategory = TransactionCategory.values[math.Random().nextInt(
      TransactionCategory.values.length,
    )];
    return Transaction(
      id: index,
      name: '',
      date: randomDate,
      amount: randomAmount,
      category: randomCategory,
    );
  },
);

final demoDays = List.generate(7, (index) {
  final randomAmount = math.Random().nextInt(100).toDouble();
  final randomDate = DateFormat('EEEE').format(DateTime.now().subtract(Duration(days: math.Random().nextInt(7))));
  return Day(randomDate, randomAmount);
});

final ThemeData theme = ThemeData(
  textTheme: GoogleFonts.madaTextTheme(),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    floatingLabelStyle: const TextStyle(color: Colors.black),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.black),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  ),
);

final Map<TransactionCategory, String> categoriesNames = {
  TransactionCategory.bills: 'الفواتير',
  TransactionCategory.cafes: 'المقاهي',
  TransactionCategory.electronics: 'الالكترونيات',
  TransactionCategory.restaurants: 'المطاعم',
  TransactionCategory.shopping: 'التسوق',
  TransactionCategory.travel: 'السفر و السياحة',
};

final Map<TransactionCategory, Color> categoriesColors = {
  TransactionCategory.bills: Colors.blueAccent,
  TransactionCategory.cafes: Colors.brown.withOpacity(0.4),
  TransactionCategory.electronics: Colors.greenAccent,
  TransactionCategory.restaurants: Colors.indigoAccent,
  TransactionCategory.shopping: Colors.amberAccent,
  TransactionCategory.travel: Colors.purpleAccent,
};

class CustomIcon {
  final IconData icon;
  final Color color;
  CustomIcon(this.icon, this.color);
}

final Map<TransactionCategory, CustomIcon> categoriesIcons = {
  TransactionCategory.bills: CustomIcon(FontAwesomeIcons.moneyBills, Colors.blue),
  TransactionCategory.cafes: CustomIcon(Icons.coffee, Colors.brown),
  TransactionCategory.electronics: CustomIcon(Icons.electrical_services_outlined, Colors.green),
  TransactionCategory.restaurants: CustomIcon(Icons.restaurant, Colors.indigo),
  TransactionCategory.shopping: CustomIcon(Icons.shop_2, Colors.amber),
  TransactionCategory.travel: CustomIcon(Icons.travel_explore, Colors.purple),
};
