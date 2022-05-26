import 'package:ezan_official/screens/home_screen/components/bank_accounts.dart';
import 'package:ezan_official/size_config.dart';
import 'package:ezan_official/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeConfig.addVerticalSpace(100),
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
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
