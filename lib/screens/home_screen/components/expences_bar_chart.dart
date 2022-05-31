import 'package:ezan_official/constants.dart';
import 'package:ezan_official/providers/expences.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExpencesBarChart extends StatelessWidget {
  const ExpencesBarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: SizeConfig.height(380),
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
            // const Spacer(),
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(
                right: SizeConfig.width(20),
              ),
              child: Text(
                'نظرة عامة',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.height(30),
                ),
              ),
            ),
            SizeConfig.addVerticalSpace(20),
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
    return SizedBox(
      height: SizeConfig.height(300),
      child: Stack(
        children: const [
          Grid(),
          Bars(),
        ],
      ),
    );
  }
}

class Grid extends StatelessWidget {
  const Grid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: SizeConfig.height(45),
      left: 0,
      right: 0,
      child: Column(
        children: List.generate(
          5,
          (index) => Container(
            margin: EdgeInsets.only(
              top: SizeConfig.height(30),
              left: SizeConfig.width(10),
              right: SizeConfig.width(10),
            ),
            child: Row(
              children: [
                ...List.generate(
                  500 ~/ 10,
                  (index) => Expanded(
                    child: Container(
                      color: index % 2 == 0 ? null : Colors.grey,
                      height: 1,
                    ),
                  ),
                ),
                SizedBox(width: SizeConfig.width(13)),
                SizedBox(
                  width: SizeConfig.width(40),
                  child: Text(
                    '${(4 - index) * 1000}',
                    style: TextStyle(
                      fontSize: SizeConfig.height(15),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Bars extends HookConsumerWidget {
  const Bars({
    Key? key,
  }) : super(key: key);

  static const _physics = BouncingScrollPhysics();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      bottom: SizeConfig.height(20),
      left: 0,
      right: 0,
      child: Container(
        height: SizeConfig.height(280),
        padding: EdgeInsets.only(left: SizeConfig.width(40)),
        child: SingleChildScrollView(
          physics: _physics,
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              7,
              (index) => HookConsumer(
                builder: ((context, ref, child) {
                  final isHoveringNotifier = useState(false);
                  final expences = ref.watch(expencesProvider);
                  final expence = (expences[index] / 4000) * SizeConfig.height(49.5 * 4);
                  return SizedBox(
                    width: SizeConfig.width(60),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            isHoveringNotifier.value = !isHoveringNotifier.value;
                          },
                          child: Column(
                            verticalDirection: VerticalDirection.up,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                daysNames[index],
                                style: TextStyle(
                                  fontSize: SizeConfig.height(14),
                                  color: const Color(0xFF7B7B7B),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                height: isHoveringNotifier.value ? 20 : 15,
                              ),
                              HookConsumer(
                                builder: (context, ref, child) {
                                  return Container(
                                    height: expence,
                                    width: SizeConfig.width(12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.blueAccent,
                                    ),
                                  );
                                },
                              ),
                              SizeConfig.addVerticalSpace(15),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: SizeConfig.height(expence + 60),
                          left: 0,
                          right: 0,
                          child: AnimatedOpacity(
                            opacity: isHoveringNotifier.value ? 1 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              height: SizeConfig.height(30),
                              // width: SizeConfig.width(100),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black54,
                              ),
                              child: Text(
                                '${expences[index].toStringAsFixed(1)} ريال',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.height(13),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
