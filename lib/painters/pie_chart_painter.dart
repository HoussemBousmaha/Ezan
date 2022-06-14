import 'package:ezan_official/models/categories.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

final midPaint = Paint()..color = Colors.white;

class PieChartPainter extends CustomPainter {
  final List<Category> categories;
  final double total;
  final double angle;

  PieChartPainter(this.categories, this.total, this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    double startAngle = 0;

    for (var category in categories) {
      double sweepAngle = drawSector(category, canvas, rect, startAngle, size);

      startAngle += sweepAngle;
    }
  }

  void drawLabel(
    Canvas canvas,
    Offset center,
    double radius,
    double startAngle,
    double sweepAngle,
    String text,
  ) {
    final r = radius * 0.5;
    final dx = r * math.cos(startAngle + sweepAngle / 2.0);
    final dy = r * math.sin(startAngle + sweepAngle / 2.0);
    final position = center + Offset(dx, dy);
    drawTextCentered(
      canvas,
      position,
      text,
      const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
      100,
      (size) {
        final rect = Rect.fromCenter(
          center: position,
          width: size.width + 10,
          height: size.height + 10,
        );
        final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(10));
        canvas.drawRRect(rrect, midPaint);
      },
    );
  }

  TextPainter measureText(String string, TextStyle style, double maxWidth, TextAlign align) {
    final span = TextSpan(text: string, style: style);
    final textPainter = TextPainter(text: span, textAlign: align, textDirection: TextDirection.rtl);
    textPainter.layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter;
  }

  void drawTextCentered(
    Canvas canvas,
    Offset position,
    String text,
    TextStyle style,
    double maxWidth,
    Function(Size sz) bg,
  ) {
    final tp = measureText(text, style, maxWidth, TextAlign.center);
    final pos = position + Offset(-tp.width / 2.0, -tp.height / 2.0);
    bg(tp.size);
    tp.paint(canvas, pos);
  }

  void drawLine(double radius, double startAngle, Offset center, Canvas canvas) {
    final linePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    final dx = radius / 2.0 * math.cos(startAngle);
    final dy = radius / 2.0 * math.sin(startAngle);
    final point = center + Offset(dx, dy);
    canvas.drawLine(center, point, linePaint);
  }

  double drawSector(Category category, Canvas canvas, Rect rect, double startAngle, Size size) {
    Paint paint = Paint()
      ..strokeWidth = size.height / 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = category.color;
    double sweepAngle = category.amount / (total != 0 ? total : 1.0) * angle * math.pi / 180.0;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
    return sweepAngle;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
