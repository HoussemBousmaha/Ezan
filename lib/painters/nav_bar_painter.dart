import 'package:flutter/material.dart';

class NavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;
    // ..style = PaintingStyle.fill;

    Path path = Path()
      // ..moveTo(0, 0);
      ..lineTo(size.width * 0.27, 0)
      ..quadraticBezierTo(size.width * 0.32, 0, size.width * 0.37, 30)
      ..quadraticBezierTo(size.width * 0.42, 60, size.width * 0.5, 60)
      ..quadraticBezierTo(size.width * 0.57, 60, size.width * 0.63, 30)
      ..quadraticBezierTo(size.width * 0.68, 0, size.width * 0.77, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.1),
      size.height * 0.45,
      Paint()..color = Colors.blueAccent,
    );
    canvas.drawLine(
      Offset(size.width * 0.46, size.height * 0.1),
      Offset(size.width * 0.54, size.height * 0.1),
      Paint()
        ..color = Colors.white
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * -0.05),
      Offset(size.width * 0.5, size.height * 0.25),
      Paint()
        ..color = Colors.white
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawPath(path, paint);
    canvas.drawShadow(path, Colors.black.withOpacity(0.3), 2.0, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
