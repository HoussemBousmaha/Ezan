import 'package:ezan_official/providers.dart';
import 'package:ezan_official/screens/home_screen/components/transaction_card.dart';
import 'package:ezan_official/screens/home_screen/home_wrapper.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TransactionsScreen extends HookConsumerWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsData = ref.watch(transactionsFutureProvider);
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizeConfig.addVerticalSpace(80),
            SizedBox(
              width: SizeConfig.width(364),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      size: SizeConfig.height(30),
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: SizeConfig.height(30),
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {
                      ref.read(homeWrapperScreensIndexProvider.notifier).state = false;
                    },
                  )
                ],
              ),
            ),
            SizeConfig.addVerticalSpace(30),
            Expanded(
              child: transactionsData.when(
                data: (transactions) {
                  transactions.sort((a, b) => b.date.compareTo(a.date));
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: transactions.length,
                    itemBuilder: ((context, index) {
                      return TransactionCard(transaction: transactions[index]);
                    }),
                  );
                },
                error: (e, s) => const SizedBox.shrink(),
                loading: () => const CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
