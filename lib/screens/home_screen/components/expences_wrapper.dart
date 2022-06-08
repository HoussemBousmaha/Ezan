import 'package:ezan_official/models/bar_chart_days.dart';
import 'package:ezan_official/models/categories.dart';
import 'package:ezan_official/screens/home_screen/components/chart_categories.dart';
import 'package:ezan_official/screens/home_screen/components/expences_bar_chart.dart';
import 'package:ezan_official/screens/home_screen/components/expences_pie_chart.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExpencesWrapper extends HookConsumerWidget {
  const ExpencesWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesData = ref.watch(categoriesProvider);
    final daysData = ref.watch(daysProvider);
    final categoriesFuture = useMemoized(categoriesData.getCategories);
    final categories = useFuture(categoriesFuture);
    final totalFuture = useMemoized(categoriesData.getTotal);
    final total = useFuture(totalFuture);
    final daysFuture = useMemoized(daysData.getDayAmountSpent);
    final days = useFuture(daysFuture);
    final isLoaded = categories.hasData && total.hasData && days.hasData;

    final showPieChartNotifier = useState(true);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
      alignment: Alignment.center,
      // height: SizeConfig.screenHeight * (showPieChartNotifier.value ? .35 : .43),
      width: SizeConfig.screenWidth * 0.9,
      // padding: EdgeInsets.only(top: SizeConfig.height(40)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 0, spreadRadius: 1)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoaded
              ? GestureDetector(
                  onTap: () async {
                    showPieChartNotifier.value = !showPieChartNotifier.value;
                  },
                  child: !showPieChartNotifier.value
                      ? ExpencesBarChart(items: days.data!)
                      : ExpencesPieChart(items: categories.data!, total: total.data!),
                )
              : Container(
                  alignment: Alignment.center,
                  height: SizeConfig.screenWidth * 0.6,
                  width: SizeConfig.screenWidth * 0.6,
                  child: const CircularProgressIndicator(),
                ),
          // if (showPieChartNotifier.value) SizeConfig.addVerticalSpace(60),
          if (isLoaded && showPieChartNotifier.value) ChartsCategories(items: categories.data!, total: total.data!),
        ],
      ),
    );
  }
}
