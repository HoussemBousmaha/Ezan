import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BankCard extends StatelessWidget {
  const BankCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: SizeConfig.width(20)),
        Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 5,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width(10),
              vertical: SizeConfig.height(10),
            ),
            width: SizeConfig.width(135),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SvgPicture.asset(
                'assets/logos/Al_Rajhi.svg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
