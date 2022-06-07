import 'dart:math' as math;
import 'package:ezan_official/constants.dart';
import 'package:ezan_official/models/bar_chart_days.dart';
import 'package:ezan_official/models/categories.dart';
import 'package:flutter/material.dart';

class BarChartPainter extends CustomPainter {
  final List<Category> categories;
  final double total;
  final double heightPercentage;
  BarChartPainter(this.categories, this.total, this.heightPercentage);

  @override
  void paint(Canvas canvas, Size size) {
    double maxAmount = categories[0].amount;

    for (var item in categories) {
      maxAmount = math.max(maxAmount, item.amount);
    }

    final lineWidth = size.width / (categories.length - 1);

    for (int i = 0; i < categories.length; i++) {
      final lineHeight = size.height * (1 - heightPercentage * (categories[i].amount) / maxAmount);

      final paint = Paint()
        ..color = categories[i].color
        // ..style = PaintingStyle.fill
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 10;

      canvas.drawLine(
        Offset(i * lineWidth, size.height),
        Offset(i * lineWidth, lineHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BarsPainter extends CustomPainter {
  final List<Day> days;
  final double percentage;

  BarsPainter(this.days, this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    final linePaint = Paint()
      ..color = Colors.grey.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final lineWidth = size.width * 0.72 / 6;

    double maxAmount = days[0].amountSpent;

    for (Day day in days) {
      maxAmount = math.max(maxAmount, day.amountSpent);
    }

    canvas.drawLine(
      Offset(size.width * 0.15, 10 + 4 / 5 * size.height),
      Offset(size.width * 1, 10 + 4 / 5 * size.height),
      Paint()
        ..color = Colors.grey
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    canvas.drawLine(
      Offset(size.width * 0.15, 0),
      Offset(size.width * 0.15, 10 + 4 / 5 * size.height),
      Paint()
        ..color = Colors.grey
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    drawText(
      canvas,
      Offset(size.width * 0.05, 10 + 4 * size.height / 5),
      '0',
      const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Colors.black,
      ),
      double.infinity,
    );

    for (int i = 0; i < 8; i++) {
      drawHorizontalDashedLines(
        canvas,
        Offset(size.width * 0.15, 10 + i * size.height / 10),
        size,
        linePaint,
      );

      final barMaxAmount = maxAmount.round() - maxAmount.round() % 10;

      drawText(
        canvas,
        Offset(size.width * 0.05, 10 + i * size.height / 10),
        (barMaxAmount - i * barMaxAmount / 8).toStringAsFixed(2),
        const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Colors.black,
        ),
        double.infinity,
      );
    }
    for (int i = 0; i < days.length; i++) {
      final lineHeight = size.height * (1 - percentage * (days[i].amountSpent) / maxAmount);
      canvas.drawLine(
        Offset(size.width * 0.2 + i * lineWidth, size.height * 0.8),
        Offset(size.width * 0.2 + i * lineWidth, 0.8 * lineHeight),
        paint,
      );

      drawVerticalDashedLines(
        canvas,
        Offset(7 + (i + 2) * lineWidth, size.height),
        size,
        linePaint,
      );

      drawText(
        canvas,
        Offset(size.width * 0.2 + i * lineWidth, size.height * 0.9),
        englishToArabic[days[i].name]!,
        const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        lineWidth + 100,
      );
    }
  }

  void drawVerticalDashedLines(Canvas canvas, Offset position, Size size, Paint paint) {
    // Chage to your preferred size
    const int dashWidth = 3;
    const int dashSpace = 5;

    // Start to draw from left size.
    // Of course, you can change it to match your requirement.
    double startY = 10;
    double x = position.dx;

    // Repeat drawing until we reach the right edge.
    // In our example, size.with = 300 (from the SizedBox)
    while (startY < size.height * 0.83) {
      // Draw a small line.
      canvas.drawLine(Offset(x, startY), Offset(x, startY + dashWidth), paint);

      // Update the starting y
      startY += dashWidth + dashSpace;
    }
  }

  void drawHorizontalDashedLines(Canvas canvas, Offset position, Size size, Paint paint) {
    // Chage to your preferred size
    const int dashWidth = 5;
    const int dashSpace = 5;

    // Start to draw from left size.
    // Of course, you can change it to match your requirement.
    double startX = position.dx;
    double y = position.dy;

    // Repeat drawing until we reach the right edge.
    // In our example, size.with = 300 (from the SizedBox)
    while (startX < size.width * 0.995) {
      // Draw a small line.
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);

      // Update the starting X
      startX += dashWidth + dashSpace;
    }
  }

  TextPainter measureText(String string, TextStyle style, double maxWidth, TextAlign align) {
    final span = TextSpan(text: string, style: style);
    final textPainter = TextPainter(text: span, textAlign: align, textDirection: TextDirection.rtl);
    textPainter.layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter;
  }

  void drawText(
    Canvas canvas,
    Offset position,
    String text,
    TextStyle style,
    double maxWidth,
  ) {
    final tp = measureText(text, style, maxWidth, TextAlign.center);
    final pos = position + Offset(-tp.width / 2.0, -tp.height / 2.0);
    tp.paint(canvas, pos);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
