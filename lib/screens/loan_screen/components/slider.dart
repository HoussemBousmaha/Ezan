import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.7,
      height: SizeConfig.height(300),
      child: SleekCircularSlider(
        innerWidget: (percentage) {
          return Container(
            alignment: Alignment.center,
            child: Container(
              height: SizeConfig.height(250),
              width: SizeConfig.height(250),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 5,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.blueAccent,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('المبلغ المتوفر'),
                  SizeConfig.addVerticalSpace(10),
                  const Icon(Icons.arrow_downward),
                  SizeConfig.addVerticalSpace(10),
                  Text(
                    '16000 ريال',
                    style: TextStyle(
                      fontSize: SizeConfig.height(20),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizeConfig.addVerticalSpace(20),
                  const Text(
                    'المبلغ المراد سحبه',
                  ),
                  SizeConfig.addVerticalSpace(20),
                  Text(
                    '${percentage.toInt()} ريال',
                    style: TextStyle(
                      fontSize: SizeConfig.height(25),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        appearance: CircularSliderAppearance(
          customColors: CustomSliderColors(
            progressBarColors: [
              Colors.blueAccent,
              Colors.blue,
            ],
            trackColors: [
              Colors.blueAccent,
              Colors.blue,
            ],
          ),
        ),
        initialValue: 1.0,
        min: 1,
        max: 16000,
        onChange: (_) {},
      ),
    );
  }
}
