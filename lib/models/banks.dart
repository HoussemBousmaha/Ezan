import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final banksProvider = ChangeNotifierProvider((ref) {
  return Banks();
});

class Bank {
  final String? name;
  final String logoPath;

  Bank({
    this.name,
    required this.logoPath,
  });
}

class Banks extends ChangeNotifier {
  final _items = [
    Bank(
      logoPath: 'assets/logos/Al_Rajhi.svg',
    ),
    Bank(
      logoPath: 'assets/logos/Stc_Pay.svg',
    ),
    Bank(
      logoPath: 'assets/logos/Mada.svg',
    ),
    Bank(
      logoPath: 'assets/logos/Saudi_Central.svg',
    ),
  ];

  List<Bank> get items => [..._items];
}
