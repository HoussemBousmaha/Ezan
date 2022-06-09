import 'package:animations/animations.dart';
import 'package:ezan_official/screens/home_screen/components/add_expence_bottom_sheet.dart';
import 'package:ezan_official/screens/home_screen/home_wrapper.dart';
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
    HomeWrapper(),
    LoanScreen(),
    Scaffold(),
    Scaffold(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);

    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) async {
          final canShowX =
              SizeConfig.screenWidth * 0.38 < details.localPosition.dx && details.localPosition.dx < SizeConfig.screenWidth * 0.62;
          final canShowY = SizeConfig.screenHeight * 0.8 < SizeConfig.height(details.localPosition.dy) &&
              SizeConfig.height(details.localPosition.dy) < SizeConfig.screenHeight * 0.9;

          if (canShowY && canShowX) {
            await showModalBottomSheet(
              context: context,
              builder: (context) {
                return const AddExpenceBottomSheet();
              },
            );
          }
        },
        child: Stack(
          children: [
            PageTransitionSwitcher(
              transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
                return FadeThroughTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                );
              },
              child: screens[ref.watch(navBarScreensIndexProvider)],
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavBar(),
            ),
          ],
        ),
      ),
    );
  }
}
