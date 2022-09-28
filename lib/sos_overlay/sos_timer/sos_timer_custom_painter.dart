import 'dart:math';

import 'package:flutter/material.dart';

class SosTimerCustomPainter extends CustomPainter{
  final double progress;
  final double radius;
  SosTimerCustomPainter({this.progress = 0, this.radius = 140});

  @override
  void paint(Canvas canvas, Size size) {
    Paint circularPaint = Paint();
    Paint progressPaint = Paint();

    circularPaint..color = const Color.fromRGBO(255, 218, 218, 1)..style = PaintingStyle.stroke..strokeWidth = 8;
    progressPaint..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = 8..strokeCap = StrokeCap.round;

    Offset progressCenter = Offset(size.width/2, size.height/2);

    canvas.drawCircle(progressCenter, radius, circularPaint);
    canvas.drawArc(Rect.fromCircle(center: progressCenter, radius: radius), -pi/2, pi*2*progress, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}