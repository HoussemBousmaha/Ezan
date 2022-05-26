import 'package:ezan_official/screens/home_screen/components/add_expence_bottom_sheet.dart';
import 'package:ezan_official/size_config.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: SizeConfig.height(130),
          child: CustomPaint(
            size: Size(SizeConfig.screenWidth, 80),
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
                          onTap: () {},
                          child: Icon(
                            Icons.home,
                            color: Colors.blueAccent,
                            size: SizeConfig.height(35),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.account_balance_wallet,
                            color: Colors.blueAccent,
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
                          onTap: () {},
                          child: Icon(
                            Icons.assessment,
                            color: Colors.blueAccent,
                            size: SizeConfig.height(35),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.settings,
                            color: Colors.blueAccent,
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
        Positioned(
          bottom: 35,
          left: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              await showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const AddExpenceBottomSheet();
                },
              );
            },
            child: Container(
              height: SizeConfig.height(85),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: SizeConfig.height(50),
              ),
            ),
          ),
        ),
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
