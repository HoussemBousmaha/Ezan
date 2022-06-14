import 'package:ezan_official/constants.dart';
import 'package:ezan_official/models/bar_chart_days.dart';
import 'package:ezan_official/models/categories.dart';
import 'package:ezan_official/models/transactions.dart';
import 'package:ezan_official/services/sms_service.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final categoriesFutureProvider = FutureProvider((ref) async {
  final smsService = ref.read(smsServiceProvider);
  await smsService.getMessages();

  final transactionsData = ref.read(transactionsProvider(smsService.state));
  transactionsData.getTransactions();

  // meaning we are on emulator
  if (transactionsData.state.isEmpty) {
    transactionsData.state = demoTransactions;
  }

  final categoriesData = ref.read(categoriesProvider(transactionsData.state));

  categoriesData.getCategories();
  categoriesData.getTotal();

  await Future.delayed(const Duration(milliseconds: 1000));

  return categoriesData;
});

final daysFutureProvider = FutureProvider((ref) async {
  final smsService = ref.read(smsServiceProvider);
  await smsService.getMessages();

  final transactionsData = ref.read(transactionsProvider(smsService.state));
  transactionsData.getTransactions();

  final daysData = Days(transactionsData.state);
  daysData.getDayAmountSpent();

  // meaning we are on emulator
  if (transactionsData.state.isEmpty) {
    daysData.days = demoDays;
  }

  await Future.delayed(const Duration(milliseconds: 1000));

  return daysData;
});

final transactionsFutureProvider = FutureProvider((ref) async {
  final smsService = ref.read(smsServiceProvider);
  await smsService.getMessages();

  final transactionsData = ref.read(transactionsProvider(smsService.state));
  transactionsData.getTransactions();

  // meaning we are on emulator
  if (transactionsData.state.isEmpty) {
    transactionsData.state = demoTransactions;
  }

  await Future.delayed(const Duration(milliseconds: 1000));
  return transactionsData.state;
});

final transactionsProvider = Provider.family<Transactions, List<SmsMessage>>((ref, messages) {
  return Transactions(messages);
});

final categoriesProvider = Provider.family<Categories, List<Transaction>>((ref, transactions) {
  return Categories(transactions);
});

final smsServiceProvider = Provider<SmsService>(
  (ref) => SmsService(),
);
