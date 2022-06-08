import 'package:ezan_official/models/banks.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BankCard extends StatelessWidget {
  const BankCard({
    Key? key,
    required this.bank,
  }) : super(key: key);

  final Bank bank;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width(10),
        vertical: SizeConfig.height(10),
      ),
      height: SizeConfig.height(100),
      width: SizeConfig.width(135),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SvgPicture.asset(
          bank.logoPath,
          fit: BoxFit.fitWidth,
          // height: 20,
        ),
      ),
    );
  }
}
