import 'package:ezan_official/size_config.dart';
import 'package:ezan_official/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({Key? key}) : super(key: key);

  static const _physics = BouncingScrollPhysics();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: _physics,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizeConfig.addVerticalSpace(80),
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(right: SizeConfig.width(40)),
                child: Container(
                  alignment: Alignment.center,
                  height: SizeConfig.height(40),
                  width: SizeConfig.width(130),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                        color: Colors.blueAccent.withOpacity(0.25),
                      ),
                    ],
                  ),
                  child: Text(
                    'الميزانية',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.height(20),
                    ),
                  ),
                ),
              ),
              SizeConfig.addVerticalSpace(40),
              SvgPicture.asset(
                'assets/illustations/budget_illustation.svg',
                fit: BoxFit.cover,
              ),
              SizeConfig.addVerticalSpace(40),
              Text(
                'وازن حياتك',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: SizeConfig.height(35),
                ),
              ),
              SizeConfig.addVerticalSpace(36),
              Container(
                height: SizeConfig.height(90),
                width: SizeConfig.width(310),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.blueAccent.withOpacity(0.25),
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'ميزانيتك الشهرية',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.height(25),
                  ),
                ),
              ),
              SizeConfig.addVerticalSpace(30),
              PrimaryButton(
                onPressed: () {},
                text: 'ابدأ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.height(25),
                ),
              ),
              SizeConfig.addVerticalSpace(30),
            ],
          ),
        ),
      ),
    );
  }
}
