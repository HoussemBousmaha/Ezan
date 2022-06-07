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
    final itemsFuture = useMemoized(categoriesData.getCategories);
    final items = useFuture(itemsFuture);
    final totalFuture = useMemoized(categoriesData.getTotal);
    final total = useFuture(totalFuture);
    final daysFuture = useMemoized(daysData.getDayAmountSpent);
    final days = useFuture(daysFuture);
    final isLoaded = items.hasData && total.hasData;

    final isPie = useState(true);
    final done = useState(true);

    return IgnorePointer(
      ignoring: isPie.value && !done.value || false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.bounceOut,
        height: SizeConfig.screenHeight * (isPie.value ? 0.58 : 0.43),
        width: SizeConfig.screenWidth * 0.9,
        padding: EdgeInsets.only(
          top: SizeConfig.height(40),
          bottom: SizeConfig.height(10),
        ),
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
        child: Column(
          children: [
            isLoaded
                ? GestureDetector(
                    onTap: () async {
                      if (!isPie.value) {
                        isPie.value = true;
                        await Future.delayed(const Duration(milliseconds: 750));
                        done.value = !done.value;
                      } else {
                        done.value = false;
                        isPie.value = false;
                      }
                    },
                    child: !isPie.value ? BarChart(items: days.data!) : ExpencesPieChart(items: items.data!, total: total.data!),
                  )
                : Container(
                    alignment: Alignment.center,
                    height: SizeConfig.screenWidth * 0.6,
                    width: SizeConfig.screenWidth * 0.6,
                    child: const CircularProgressIndicator(),
                  ),
            if (isLoaded && isPie.value && done.value) SizeConfig.addVerticalSpace(60),
            if (isLoaded && isPie.value && done.value) ChartsCategories(items: items.data!, total: total.data!),
          ],
        ),
      ),
    );
  }
}
