import 'package:animations/animations.dart';
import 'package:ezan_official/screens/budget_screen/budget_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final budgetScreensIndexProvider = StateProvider<int>(
  (ref) => 0,
);

class BudgetScreenWrapper extends ConsumerWidget {
  const BudgetScreenWrapper({Key? key}) : super(key: key);

  static const screens = [
    BudgetScreen(),
    Scaffold(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTransitionSwitcher(
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: screens[ref.watch(budgetScreensIndexProvider)],
    );
  }
}
