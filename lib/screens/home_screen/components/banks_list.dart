import 'package:ezan_official/models/banks.dart';
import 'package:ezan_official/screens/home_screen/components/bank_card.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BanksList extends ConsumerWidget {
  const BanksList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final banks = ref.watch(banksProvider).items;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      height: SizeConfig.height(100),
      width: SizeConfig.width(270),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: SizeConfig.height(5)),
          scrollDirection: Axis.horizontal,
          itemCount: banks.length,
          itemBuilder: (context, index) {
            return BankCard(
              bank: banks[index],
            );
          },
        ),
      ),
    );
  }
}
