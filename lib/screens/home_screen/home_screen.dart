import 'package:ezan_official/screens/home_screen/components/bank_card.dart';
import 'package:ezan_official/size_config.dart';
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizeConfig.addVerticalSpace(100),
            buildTopRow(),
            SizeConfig.addVerticalSpace(45),
            Text(
              'الحسابات',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.height(30),
              ),
            ),
            SizeConfig.addVerticalSpace(30),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizeConfig.addHorizontalSpace(20),
                Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 5,
                  child: Container(
                    height: SizeConfig.height(100),
                    width: SizeConfig.width(80),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.add,
                      size: SizeConfig.height(30),
                      color: Colors.black,
                    ),
                  ),
                ),
                SizeConfig.addHorizontalSpace(20),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  height: SizeConfig.height(100),
                  width: SizeConfig.width(280),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: SizeConfig.height(5)),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return const BankCard();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding buildTopRow() {
    return Padding(
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
    );
  }
}
