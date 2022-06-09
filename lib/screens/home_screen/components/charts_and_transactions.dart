import 'package:ezan_official/providers.dart';
import 'package:ezan_official/screens/home_screen/components/expences_wrapper.dart';
import 'package:ezan_official/screens/home_screen/components/latest_transactions_list.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChartsAndTransactions extends StatelessWidget {
  const ChartsAndTransactions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final categoriesData = ref.watch(categoriesProvider);
        final daysData = ref.watch(daysProvider);
        final transactionsData = ref.watch(transactionsFutureProvider);

        return categoriesData.when(
          data: (categories) {
            return daysData.when(
              data: (days) {
                return Column(
                  children: [
                    ExpencesWrapper(categoriesData: categories, daysData: days),
                    SizeConfig.addVerticalSpace(40),
                    transactionsData.maybeWhen(
                      data: (transactions) {
                        return LatestTransactionsList(transactionsData: transactions);
                      },
                      orElse: () => const SizedBox.shrink(),
                    )
                  ],
                );
              },
              error: (e, s) => const SizedBox.shrink(),
              loading: () => const CircularProgressIndicator(),
            );
          },
          error: (e, s) => const SizedBox.shrink(),
          loading: () => const CircularProgressIndicator(),
        );
      },
    );
  }
}
