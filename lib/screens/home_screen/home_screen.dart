// ignore_for_file: avoid_print

import 'package:ezan_official/screens/home_screen/components/bank_accounts.dart';
import 'package:ezan_official/screens/home_screen/components/expences_wrapper.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const _physics = BouncingScrollPhysics();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SingleChildScrollView(
      physics: _physics,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizeConfig.addVerticalSpace(60),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.width(30)),
              child: Row(
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
                      Icons.notifications,
                      size: SizeConfig.height(30),
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            SizeConfig.addVerticalSpace(45),
            const BankAccounts(),
            SizeConfig.addVerticalSpace(80),
            const ExpencesWrapper(),
            // const BarChart(),
            SizeConfig.addVerticalSpace(200),
          ],
        ),
      ),
    );
  }
}
