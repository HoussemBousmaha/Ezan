import 'package:animations/animations.dart';
import 'package:ezan_official/screens/budget_screen/budget_screens_wrapper.dart';
import 'package:ezan_official/screens/home_screen/home_screen.dart';
import 'package:ezan_official/screens/loan_screen/loan_screen.dart';
import 'package:ezan_official/size_config.dart';
import 'package:ezan_official/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final navBarScreensIndexProvider = StateProvider.autoDispose<int>(
  (ref) => 0,
);

class NavBarScreensWrapper extends HookConsumerWidget {
  const NavBarScreensWrapper({Key? key}) : super(key: key);

  static const screens = [
    HomeScreen(),
    LoanScreen(),
    BudgetScreenWrapper(),
    Scaffold(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);

    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: screens[ref.watch(navBarScreensIndexProvider)],
      ),
      // body: screens[ref.watch(navBarScreensIndexProvider)],
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
