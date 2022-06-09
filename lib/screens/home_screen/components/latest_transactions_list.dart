import 'package:ezan_official/models/transactions.dart';
import 'package:ezan_official/screens/home_screen/components/transaction_card.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LatestTransactionsList extends HookConsumerWidget {
  const LatestTransactionsList({
    Key? key,
    required this.transactionsData,
  }) : super(key: key);

  final List<Transaction> transactionsData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          width: SizeConfig.width(364),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('العمليات الأخيرة', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              GestureDetector(
                onTap: () {},
                child: const Text('عرض الكل', style: TextStyle(color: Colors.blue, fontSize: 15)),
              ),
            ],
          ),
        ),
        SizeConfig.addVerticalSpace(10),
        ...List.generate(
          4,
          (index) => TransactionCard(transaction: transactionsData[index]),
        ),
      ],
    );
  }
}
