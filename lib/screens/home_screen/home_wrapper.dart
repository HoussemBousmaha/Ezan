import 'package:animations/animations.dart';
import 'package:ezan_official/screens/home_screen/home_screen.dart';
import 'package:ezan_official/screens/transactions_screen/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeWrapper extends HookConsumerWidget {
  const HomeWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showTransactionsScreen = ref.watch(homeWrapperScreensIndexProvider);
    return PageTransitionSwitcher(
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: showTransactionsScreen ? const TransactionsScreen() : const HomeScreen(),
    );
  }
}

final homeWrapperScreensIndexProvider = StateProvider.autoDispose((_) => false);
