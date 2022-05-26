import 'package:ezan_official/screens/home_screen/components/add_bank_button.dart';
import 'package:ezan_official/screens/home_screen/components/banks_list.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';

class BankAccounts extends StatelessWidget {
  const BankAccounts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: SizeConfig.width(40)),
          child: Text(
            'الحسابات',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.height(30),
            ),
          ),
        ),
        SizeConfig.addVerticalSpace(30),
        Row(
          children: [
            SizeConfig.addHorizontalSpace(20),
            const AddBankButton(),
            SizeConfig.addHorizontalSpace(20),
            const BanksList(),
          ],
        ),
      ],
    );
  }
}
