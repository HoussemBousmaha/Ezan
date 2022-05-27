import 'package:animations/animations.dart';
import 'package:ezan_official/screens/home_screen/home_screen.dart';
import 'package:ezan_official/screens/loan_screen.dart/loan_screen.dart';
import 'package:ezan_official/size_config.dart';
import 'package:ezan_official/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScreensWrapper extends HookConsumerWidget {
  const ScreensWrapper({Key? key}) : super(key: key);

  static const screens = [
    HomeScreen(),
    LoanScreen(),
    Scaffold(),
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
        child: screens[ref.watch(screenIndexProvider)],
      ),
      // body: screens[ref.watch(screenIndexProvider)],
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

final screenIndexProvider = StateProvider<int>(
  (ref) => 0,
);
