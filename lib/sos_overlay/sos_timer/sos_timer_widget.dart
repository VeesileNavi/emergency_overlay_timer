import 'package:emergency_overlay_timer/sos_overlay/sos_timer/sos_countdown_info.dart';
import 'package:emergency_overlay_timer/sos_overlay/sos_timer/sos_timer_custom_painter.dart';
import 'package:emergency_overlay_timer/sos_overlay/widgets/sos_button.dart';
import 'package:flutter/material.dart';

class SosTimerWidget extends StatelessWidget {
  const SosTimerWidget({
    super.key,
    this.progress = 0,
    this.seconds = 3,
    this.sosItemColor = Colors.red,
    required this.center,
    required this.timerRadius,
  });

  final double progress;
  final double timerRadius;
  final int seconds;
  final Color sosItemColor;
  final Offset center;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fromRect(
          rect: Rect.fromCircle(
              center: center, radius: double.minPositive),
          child: CustomPaint(
            painter: SosTimerCustomPainter(
                progress: progress, radius: timerRadius),
          ),
        ),
        Positioned.fromRect(
          rect: Rect.fromCenter(
            center: center,
            height: 140 + timerRadius * 2,
            width: 240,
          ),
          child: SosCountdownInfo(
            seconds: seconds,
          ),
        ),
        Positioned.fromRect(
            rect: Rect.fromCircle(
              center: center,
              radius: 46 + timerRadius / 8,
            ),
            child: const SosButton()),
      ],
    );
  }
}


