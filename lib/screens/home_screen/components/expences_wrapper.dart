import 'package:animations/animations.dart';
import 'package:ezan_official/screens/home_screen/components/chart_categories.dart';
import 'package:ezan_official/screens/home_screen/components/expences_bar_chart.dart';
import 'package:ezan_official/screens/home_screen/components/expences_pie_chart.dart';
import 'package:ezan_official/providers.dart';
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
    final showPieChartNotifier = useState(true);

    // return Container();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      // height: SizeConfig.height(547),
      width: SizeConfig.screenWidth * 0.9,
      curve: Curves.ease,
      alignment: Alignment.center,
      // padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: categoriesData.when(
        data: (categoriesData) {
          return daysData.when(
            data: (daysData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showPieChartNotifier.value = !showPieChartNotifier.value;
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: PageTransitionSwitcher(
                        duration: const Duration(milliseconds: 1000),
                        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
                          return FadeThroughTransition(
                            fillColor: Colors.white,
                            animation: primaryAnimation,
                            secondaryAnimation: secondaryAnimation,
                            child: child,
                          );
                        },
                        child: !showPieChartNotifier.value
                            ? ExpencesPieChart(items: categoriesData.categories, total: categoriesData.total)
                            : ExpencesBarChart(items: daysData.days),
                      ),
                    ),
                  ),
                  SizeConfig.addVerticalSpace(20),
                  ChartsCategories(items: categoriesData.categories, total: categoriesData.total),
                ],
              );
            },
            error: (e, s) => Center(child: Text('error: $e stack: $s')),
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
          );
        },
        error: (e, s) => Center(child: Text('error: $e')),
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
