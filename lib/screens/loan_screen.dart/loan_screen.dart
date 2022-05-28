import 'package:ezan_official/screens/loan_screen.dart/components/slider.dart';
import 'package:ezan_official/screens/loan_screen.dart/components/success_dialog.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoanScreen extends HookWidget {
  const LoanScreen({Key? key}) : super(key: key);

  static const _physics = BouncingScrollPhysics();

  void showSuccessDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return const SuccessDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          physics: _physics,
          child: Column(
            children: [
              SizeConfig.addVerticalSpace(60),
              SizedBox(
                height: SizeConfig.height(200),
                child: Image.asset(
                  'assets/logos/Ezan.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: SizeConfig.width(20)),
                child: Text(
                  'خذ قروضا مصغرة بكل سهولة',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.height(25),
                  ),
                ),
              ),
              const CustomSlider(),
              GestureDetector(
                onTap: () {
                  showSuccessDialog(context);
                },
                child: Container(
                  height: SizeConfig.height(60),
                  width: SizeConfig.width(200),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'اسحب',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.height(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
