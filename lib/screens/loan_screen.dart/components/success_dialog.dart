import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: SizeConfig.height(400),
        width: SizeConfig.width(200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: SizeConfig.height(70),
              width: SizeConfig.width(70),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green),
              ),
              child: Icon(
                Icons.check,
                color: Colors.green,
                size: SizeConfig.height(50),
              ),
            ),
            SizeConfig.addVerticalSpace(40),
            Text(
              'سيتم معالجة طلبكم في 24 ساعة',
              style: TextStyle(
                fontSize: SizeConfig.height(20),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizeConfig.addVerticalSpace(40),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: SizeConfig.height(40),
                width: SizeConfig.width(140),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'موافق',
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
    );
  }
}
