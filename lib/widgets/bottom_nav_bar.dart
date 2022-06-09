import 'package:ezan_official/painters/nav_bar_painter.dart';
import 'package:ezan_official/screens/navbar_screens_wrapper.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  void goToScreen(WidgetRef ref, int screenIndex) {
    ref.watch(navBarScreensIndexProvider.notifier).state = screenIndex;
  }

  bool isScreenSelected(WidgetRef ref, int screenIndex) {
    return ref.watch(navBarScreensIndexProvider) == screenIndex;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: SizeConfig.height(100),
      child: CustomPaint(
        painter: NavBarPainter(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: SizeConfig.screenWidth * 0.31,
              padding: EdgeInsets.only(right: SizeConfig.width(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      goToScreen(ref, 0);
                    },
                    child: Icon(
                      isScreenSelected(ref, 0) ? Icons.home : Icons.home_outlined,
                      color: isScreenSelected(ref, 0) ? Colors.blueAccent : Colors.grey,
                      size: SizeConfig.height(35),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      goToScreen(ref, 1);
                    },
                    child: Icon(
                      isScreenSelected(ref, 1) ? Icons.account_balance_wallet : Icons.account_balance_wallet_outlined,
                      color: isScreenSelected(ref, 1) ? Colors.blueAccent : Colors.grey,
                      size: SizeConfig.height(35),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: SizeConfig.screenWidth * 0.31,
              padding: EdgeInsets.only(left: SizeConfig.width(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      goToScreen(ref, 2);
                    },
                    child: Icon(
                      isScreenSelected(ref, 2) ? Icons.assessment : Icons.assessment_outlined,
                      color: isScreenSelected(ref, 2) ? Colors.blueAccent : Colors.grey,
                      size: SizeConfig.height(35),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      goToScreen(ref, 3);
                    },
                    child: Icon(
                      isScreenSelected(ref, 3) ? Icons.settings : Icons.settings_outlined,
                      color: isScreenSelected(ref, 3) ? Colors.blueAccent : Colors.grey,
                      size: SizeConfig.height(35),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
