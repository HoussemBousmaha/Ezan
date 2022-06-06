import 'package:ezan_official/models/transactions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final transactionsProvider = ChangeNotifierProvider(
  (ref) => Transactions(),
);

final allTransactionsProvider = FutureProvider(
  (ref) => ref.watch(transactionsProvider).allTransactions,
);
