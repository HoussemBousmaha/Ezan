import 'package:ezan_official/models/bar_chart_days.dart';
import 'package:ezan_official/models/categories.dart';
import 'package:ezan_official/models/transactions.dart';
import 'package:ezan_official/services/sms_service.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final categoriesProvider = FutureProvider((ref) async {
  final smsService = ref.read(smsProvider);
  await smsService.getMessages();

  final transactionsData = ref.read(transactionsProvider(smsService.state));
  transactionsData.getTransactions();

  final categoriesData = Categories(transactionsData.state);

  categoriesData.getCategories();

  categoriesData.getTotal();

  await Future.delayed(const Duration(milliseconds: 1000));

  return categoriesData;
});

final daysProvider = FutureProvider((ref) async {
  final smsService = ref.read(smsProvider);
  await smsService.getMessages();

  final transactionsData = ref.read(transactionsProvider(smsService.state));
  transactionsData.getTransactions();

  final daysData = Days(transactionsData.state);
  daysData.getDayAmountSpent();

  await Future.delayed(const Duration(milliseconds: 1000));

  return daysData;
});

final transactionsProvider = ChangeNotifierProvider.family<Transactions, List<SmsMessage>>((ref, messages) {
  return Transactions(messages);
});

final smsProvider = ChangeNotifierProvider<SmsService>(
  (ref) => SmsService(),
);

final transactionsFutureProvider = FutureProvider((ref) async {
  final smsService = ref.read(smsProvider);
  await smsService.getMessages();

  final transactionsData = ref.read(transactionsProvider(smsService.state));
  transactionsData.getTransactions();
  return transactionsData.state;
});
