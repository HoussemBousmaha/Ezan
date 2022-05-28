import 'package:ezan_official/screens/screens_wrapper.dart';
import 'package:ezan_official/size_config.dart';
import 'package:ezan_official/widgets/floating_action_add_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  void goToScreen(WidgetRef ref, int screenIndex) {
    ref.watch(screenIndexProvider.notifier).state = screenIndex;
  }

  bool isScreenSelected(WidgetRef ref, int screenIndex) {
    return ref.watch(screenIndexProvider) == screenIndex;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        SizedBox(
          height: SizeConfig.height(130),
          child: CustomPaint(
            size: Size(SizeConfig.screenWidth, SizeConfig.height(50)),
            painter: NavBarCustomPainter(),
            child: Container(
              margin: EdgeInsets.only(top: SizeConfig.height(10)),
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
                            isScreenSelected(ref, 1)
                                ? Icons.account_balance_wallet
                                : Icons.account_balance_wallet_outlined,
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
          ),
        ),
        const FloatingActionAddButton(),
      ],
    );
  }
}

class NavBarCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path()..moveTo(0, 30);
    path.lineTo(size.width * 0.27, 30);
    path.quadraticBezierTo(size.width * 0.37, 30, size.width * 0.37, 60);
    path.arcToPoint(
      Offset(size.width * 0.63, 50),
      clockwise: false,
      radius: const Radius.circular(10),
    );
    path.quadraticBezierTo(size.width * 0.63, 30, size.width * 0.73, 30);
    path.lineTo(size.width, 30);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
