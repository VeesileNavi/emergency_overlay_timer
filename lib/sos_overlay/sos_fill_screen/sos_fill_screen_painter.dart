import 'package:flutter/material.dart';

class SosFillScreenPainter extends CustomPainter{
  final double radius;
  final Offset? center;

  SosFillScreenPainter({required this.radius, this.center,});
  @override
  void paint(Canvas canvas, Size size) {
    Paint mainPaint = Paint();

    Offset mainCenter = center??Offset(size.width/2, size.height/2);

    mainPaint..color=Colors.red..style=PaintingStyle.fill;
    canvas.drawCircle(mainCenter, radius, mainPaint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}