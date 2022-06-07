import 'dart:math' as math;

import 'package:ezan_official/models/bar_chart_days.dart';
import 'package:ezan_official/models/categories.dart';
import 'package:ezan_official/painters/bar_chart_painter.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExpencesBarChart extends StatefulWidget {
  const ExpencesBarChart({Key? key, required this.items, required this.total}) : super(key: key);

  final List<Category> items;
  final double total;

  @override
  State<ExpencesBarChart> createState() => _ExpencesBarChartState();
}

class _ExpencesBarChartState extends State<ExpencesBarChart> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation animation;
  late final double itemMax;

  @override
  void initState() {
    super.initState();
    itemMax = getMax(widget.items);
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..addListener(() {
        setState(() {});
      });
    animation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double getMax(List<Category> items) {
    double itemMax = 0.0;
    for (var item in items) {
      itemMax = math.max(itemMax, item.amount);
    }

    return itemMax;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenWidth * 0.6,
      width: SizeConfig.screenWidth * 0.6,
      child: CustomPaint(
        painter: BarChartPainter(widget.items, widget.total, animation.value),
      ),
    );
  }
}

class BarChart extends HookConsumerWidget {
  const BarChart({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Day> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController(duration: const Duration(milliseconds: 1000));
    final percentage = useState(0.0);

    useEffect(() {
      final animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);
      controller.addListener(() {
        percentage.value = animation.value;
      });
      controller.forward();

      return null;
    }, [controller]);

    return SizedBox(
      height: SizeConfig.screenWidth * 0.8,
      width: SizeConfig.screenWidth * 0.8,
      child: CustomPaint(
        size: Size(SizeConfig.screenWidth * 0.8, SizeConfig.screenWidth * 0.8),
        painter: BarsPainter(items, percentage.value),
      ),
    );
  }
}
