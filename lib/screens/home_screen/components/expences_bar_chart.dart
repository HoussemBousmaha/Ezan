import 'package:ezan_official/models/bar_chart_days.dart';
import 'package:ezan_official/painters/bar_chart_painter.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExpencesBarChart extends HookWidget {
  const ExpencesBarChart({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Day> items;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: const Duration(milliseconds: 800));
    final anim = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    useEffect(() {
      controller.forward();
      return null;
    }, [controller]);

    return BarChartTransition(height: anim, items: items);
  }
}

class BarChartTransition extends StatelessWidget {
  const BarChartTransition({
    Key? key,
    required this.height,
    required this.items,
  }) : super(key: key);

  final List<Day> items;
  final Animation<double> height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenWidth * 0.9,
      width: SizeConfig.screenWidth * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(top: 0),
      child: AnimatedBuilder(
        animation: height,
        builder: (context, child) {
          return CustomPaint(
            painter: BarsPainter(items, height.value),
          );
        },
      ),
    );
  }
}
