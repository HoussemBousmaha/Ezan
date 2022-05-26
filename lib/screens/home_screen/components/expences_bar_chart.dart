import 'package:ezan_official/constants.dart';
import 'package:ezan_official/providers/expences.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExpencesBarChart extends StatelessWidget {
  const ExpencesBarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: SizeConfig.height(352),
        width: SizeConfig.width(364),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.up,
          children: [
            const BarChart(),
            const Spacer(),
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(
                right: SizeConfig.width(20),
                top: SizeConfig.height(30),
              ),
              child: Text(
                'نظرة عامة',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.height(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarChart extends StatelessWidget {
  const BarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: SizeConfig.width(45),
          left: 0,
          right: 0,
          child: Column(
            children: List.generate(
              5,
              (index) => Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.height(30),
                  left: SizeConfig.width(10),
                  right: SizeConfig.width(20),
                ),
                child: Row(
                  children: [
                    ...List.generate(
                      500 ~/ 10,
                      (index) => Expanded(
                        child: Container(
                          color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                          height: 1,
                        ),
                      ),
                    ),
                    SizedBox(width: SizeConfig.width(10)),
                    SizedBox(
                      width: SizeConfig.width(40),
                      child: Text(
                        '${(4 - index) * 1000}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: SizeConfig.height(260),
          padding: EdgeInsets.only(left: SizeConfig.width(40)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              7,
              (index) => Column(
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizeConfig.addVerticalSpace(15),
                  Text(
                    daysNames[index],
                    style: TextStyle(
                      fontSize: SizeConfig.height(15),
                      color: const Color(0xFF7B7B7B),
                    ),
                  ),
                  SizeConfig.addVerticalSpace(15),
                  HookConsumer(
                    builder: (context, ref, child) {
                      final expences = ref.watch(expencesProvider);
                      final expence = expences[index].toDouble() * (SizeConfig.height(185) / 4000);
                      return Container(
                        height: SizeConfig.height(expence),
                        width: SizeConfig.width(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.blueAccent,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
