import 'package:ezan_official/constants.dart';
import 'package:ezan_official/models/transactions.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: SizeConfig.height(80),
          width: SizeConfig.width(364),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizeConfig.addHorizontalSpace(10),
              Container(
                height: SizeConfig.height(65),
                width: SizeConfig.height(65),
                decoration: BoxDecoration(
                  color: categoriesColors[transaction.category]!.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(18),
                ),
                alignment: Alignment.center,
                child: Icon(
                  categoriesIcons[transaction.category]!.icon,
                  color: categoriesIcons[transaction.category]!.color.withOpacity(0.7),
                ),
              ),
              SizeConfig.addHorizontalSpace(10),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transaction.name!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  Text('${categoriesNames[transaction.category]}'),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${transaction.amount}',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  Text(DateFormat('dd-MM-y').format(transaction.date), style: const TextStyle(fontSize: 12)),
                ],
              ),
              SizeConfig.addHorizontalSpace(15),
            ],
          ),
        ),
        SizeConfig.addVerticalSpace(16),
      ],
    );
  }
}
