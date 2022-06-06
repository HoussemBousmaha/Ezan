import 'package:ezan_official/models/categories.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

const daysNames = [
  'الأحد',
  'الإثنين',
  'الثلاثاء',
  'الأربعاء',
  'الخميس',
  'الجمعة',
  'السبت',
];

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

final Map<TransactionCategory, double> categoriesPercentages = {
  TransactionCategory.bills: 0.0,
  TransactionCategory.cafes: 0.0,
  TransactionCategory.electronics: 0.0,
  TransactionCategory.restaurants: 0.0,
  TransactionCategory.shopping: 0.0,
  TransactionCategory.travel: 0.0,
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
