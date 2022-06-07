import 'package:ezan_official/models/categories.dart';
import 'package:ezan_official/painters/pie_chart_painter.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';

class ExpencesPieChart extends StatefulWidget {
  const ExpencesPieChart({
    Key? key,
    required this.items,
    required this.total,
  }) : super(key: key);

  final List<Category> items;
  final double total;

  @override
  State<ExpencesPieChart> createState() => _ExpencesPieChartState();
}

class _ExpencesPieChartState extends State<ExpencesPieChart> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation animation;
  late final double itemMax;

  @override
  void initState() {
    super.initState();

    itemMax = 360;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {});
      });

    animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String totalTitle = widget.total != 0.0 ? '${widget.total.toStringAsFixed(2)} ريال' : '';

    return SizedBox(
      height: SizeConfig.screenWidth * 0.6,
      width: SizeConfig.screenWidth * 0.6,
      child: CustomPaint(
        painter: PieChartPainter(widget.items, widget.total, animation.value * itemMax),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            totalTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
