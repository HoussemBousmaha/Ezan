import 'package:ezan_official/models/categories.dart';
import 'package:ezan_official/painters/pie_chart_painter.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExpencesPieChart extends HookWidget {
  const ExpencesPieChart({
    Key? key,
    required this.items,
    required this.total,
  }) : super(key: key);

  final List<Category> items;
  final double total;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: const Duration(milliseconds: 800));
    // late final Animation<double> animation;
    final curvedAnimation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    final animation = Tween<double>(begin: 0.0, end: 360).animate(curvedAnimation);

    useEffect(() {
      controller.forward();

      return null;
    }, [controller]);

    return PieChartTransition(angle: animation, items: items, total: total);
  }
}

class PieChartTransition extends StatelessWidget {
  const PieChartTransition({
    Key? key,
    required this.angle,
    required this.items,
    required this.total,
  }) : super(key: key);

  final List<Category> items;
  final double total;
  final Animation<double> angle;

  @override
  Widget build(BuildContext context) {
    String totalTitle = total != 0.0 ? '${total.toStringAsFixed(2)} ريال' : '';
    return AnimatedBuilder(
      animation: angle,
      builder: (context, child) {
        return Container(
          height: SizeConfig.screenWidth * 0.9,
          width: SizeConfig.screenWidth * 0.9,
          padding: const EdgeInsets.all(30),
          child: CustomPaint(
            painter: PieChartPainter(items, total, angle.value),
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
      },
    );
  }
}
