import 'package:emergency_overlay_timer/sos_overlay/sos_fill_screen/sos_fill_screen_painter.dart';
import 'package:flutter/material.dart';

class SosFillScreenWidget extends StatelessWidget {
  const SosFillScreenWidget({
    Key? key,
    this.child,
    this.center,
    this.radius = 100,
  }) : super(key: key);
  final Widget? child;
  final Offset? center;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SosFillScreenPainter(radius: radius, center: center),
      child: child,
    );
  }
}
