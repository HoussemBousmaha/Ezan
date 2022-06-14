// ignore_for_file: avoid_print

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
  List<Day> days;
  final double percentage;

  BarsPainter(this.days, this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    final mainPaint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 20;
    final linePaint = Paint()
      ..color = Colors.grey.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final axisLinePaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    const numberTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
      color: Colors.black,
    );

    double maxExpence = 0;
    for (Day day in days) {
      maxExpence = math.max(maxExpence, day.amountSpent);
    }

    final defaultPadding = size.width * 0.1;
    final lineWidth = size.width - defaultPadding;
    final lineHeight = size.height - defaultPadding;

    // horizontal line
    canvas.drawLine(
      Offset(20 + defaultPadding, lineHeight),
      Offset(lineWidth, lineHeight),
      axisLinePaint,
    );

    // vertical line
    canvas.drawLine(
      Offset(20 + defaultPadding, 5 + defaultPadding),
      Offset(20 + defaultPadding, lineHeight),
      axisLinePaint,
    );
    // draw 10 lines from default padding to size.height - default padding
    final barMaxAmount = maxExpence.round() - maxExpence.round() % 10 + 10;
    for (int i = 0; i < 7; i++) {
      drawText(
        canvas,
        Offset(defaultPadding - 10, (i + 1) * (lineHeight / 8)),
        (barMaxAmount - i * barMaxAmount / 7).toStringAsFixed(2),
        numberTextStyle,
        double.infinity,
      );
      drawDashedHorizontalLines(defaultPadding, lineWidth, canvas, i, lineHeight, linePaint);
    }
    drawText(
      canvas,
      Offset(defaultPadding - 10, defaultPadding + lineHeight - defaultPadding),
      '0',
      numberTextStyle,
      double.infinity,
    );
    for (int i = 0; i < 7; i++) {
      drawText(
        canvas,
        Offset(5 + defaultPadding * 2 + i * (lineWidth - 20) / 8, lineHeight + defaultPadding / 2),
        englishToArabic[days[i].name]!,
        const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        lineWidth + 100,
      );

      final p = percentage * double.parse((days[i].amountSpent / barMaxAmount).toStringAsFixed(2));

      final barEndPoint = lineHeight - p * ((lineHeight - defaultPadding - 5));

      canvas.drawLine(
        Offset(4 + defaultPadding * 2 + i * (lineWidth - 20) / 8, lineHeight),
        Offset(4 + defaultPadding * 2 + i * (lineWidth - 20) / 8, barEndPoint),
        mainPaint,
      );

      drawDashedVerticalLines(defaultPadding, lineWidth, canvas, i, lineHeight, linePaint);
    }
  }

  void drawDashedHorizontalLines(double defaultPadding, double lineWidth, Canvas canvas, int i, double lineHeight, Paint axisLinePaint) {
    double start = 20 + defaultPadding;
    double end = lineWidth;
    double dashWidth = 4;
    double dashSpace = 4;
    while (start < end) {
      canvas.drawLine(
        Offset(start, (i + 1) * (lineHeight / 8)),
        Offset(start + dashWidth, (i + 1) * (lineHeight / 8)),
        axisLinePaint,
      );
      start += dashSpace + dashWidth;
    }
  }

  void drawDashedVerticalLines(double defaultPadding, double lineWidth, Canvas canvas, int i, double lineHeight, Paint axisLinePaint) {
    double start = defaultPadding + 4;
    double end = lineHeight;
    double dashWidth = 4;
    double dashSpace = 4;
    while (start < end) {
      canvas.drawLine(
        Offset(lineWidth - i * ((lineWidth - 20) / 8), start),
        Offset(lineWidth - i * ((lineWidth - 20) / 8), start + dashWidth),
        axisLinePaint,
      );
      start += dashSpace + dashWidth;
    }
  }

  TextPainter measureText(String string, TextStyle style, double maxWidth, TextAlign align) {
    final span = TextSpan(text: string, style: style);
    final textPainter = TextPainter(text: span, textAlign: align, textDirection: TextDirection.rtl);
    textPainter.layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter;
  }

  void drawText(Canvas canvas, Offset position, String text, TextStyle style, double maxWidth) {
    final tp = measureText(text, style, maxWidth, TextAlign.center);
    final pos = position + Offset(-tp.width / 2.0, -tp.height / 2.0);
    tp.paint(canvas, pos);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
