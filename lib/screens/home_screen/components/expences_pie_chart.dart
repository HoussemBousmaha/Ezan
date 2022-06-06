import 'dart:async';

import 'package:ezan_official/models/categories.dart';
import 'package:ezan_official/painters/pie_chart_painter.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExpencesPieChart extends HookConsumerWidget {
  const ExpencesPieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    return Column(
      children: [
        PieChart(categories: categories),
        SizeConfig.addVerticalSpace(60),
        Container(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.width(20), vertical: SizeConfig.height(10)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.2),
                blurRadius: 2,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Wrap(
            children: List.generate(
              categories.items.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(vertical: SizeConfig.height(10)),
                child: SizedBox(
                  width: SizeConfig.width(170),
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: categories.items[index].color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizeConfig.addHorizontalSpace(10),
                      Column(
                        children: [
                          Text(
                            '${categories.items[index].name} ${(categories.items[index].amountPercentage * 100).toStringAsFixed(1)}%',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class PieChart extends StatefulWidget {
  const PieChart({Key? key, required this.categories}) : super(key: key);

  final Categories categories;

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  late final Timer timer;

  double fullAngle = 0.0;
  double secondsToComplete = 3.0;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (timer) {
      setState(() {
        fullAngle += 360.0 / (secondsToComplete * 1000 ~/ 60);
        if (fullAngle >= 360.0) {
          fullAngle = 360.0;
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String total = widget.categories.total != 0.0 ? '${widget.categories.total.toStringAsFixed(2)} ريال' : '';
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.height * 0.35,
      child: CustomPaint(
        painter: PieChartPainter(widget.categories.items, fullAngle),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            total,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
