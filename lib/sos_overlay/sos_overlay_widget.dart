import 'dart:async';
import 'dart:math' as math;

import 'package:emergency_overlay_timer/sos_overlay/sos_fill_screen/sos_fill_screen_widget.dart';
import 'package:emergency_overlay_timer/sos_overlay/sos_timer/sos_timer_widget.dart';
import 'package:flutter/material.dart';


class SosOverlayWidget extends StatefulWidget {
  const SosOverlayWidget({
    super.key,
    this.fillCenter,
    this.timerCenter,
    required this.countdownDuration,
    this.onComplete,
    required this.context,
  });

  final Offset? fillCenter;

  final BuildContext context;
  final Offset? timerCenter;
  final int countdownDuration;
  final void Function()? onComplete;

  @override
  State<SosOverlayWidget> createState() => _SosOverlayWidgetState();
}

class _SosOverlayWidgetState extends State<SosOverlayWidget>
    with TickerProviderStateMixin {
  late Size _screenSize;

  late double _calculatedFill;
  late Offset _center;

  late bool _timerVisible;
  late bool _centersEquals;

  late Animation<double> _fillRadius;
  late AnimationController _fillAnimationController;

  late Animation<double> _timerRadius;
  late AnimationController _timerRadiusController;

  late Animation<double> _progress;
  late AnimationController _progressAnimationController;

  Timer? _countdownTimer;
  late int _seconds;

  @override
  void initState() {
    super.initState();

    _screenSize = MediaQuery.of(widget.context).size;

    _calculatedFill = _screenSize.height / 2 +
        math.sqrt(
          math.pow(_screenSize.width / 2, 2) +
              math.pow(_screenSize.width / 2, 2),
        );

    _centersEquals = widget.timerCenter == widget.fillCenter;
    _timerVisible = _centersEquals;


    if (widget.fillCenter != null) {
      _calculatedFill += widget.fillCenter!.dy / 2;
    }

    _center = widget.timerCenter ??
        Offset(_screenSize.width / 2, _screenSize.height / 2);

    _initControllers();
    _initAnimations();

    _seconds = widget.countdownDuration;

    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => _beginCountdown());
  }

  @override
  void dispose() {
    _fillAnimationController.dispose();
    _progressAnimationController.dispose();
    _timerRadiusController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SosFillScreenWidget(
        center: widget.fillCenter,
        radius: _fillRadius.value,
        child: AnimatedOpacity(
          opacity: _timerVisible ? 1 : 0,
          duration: const Duration(milliseconds: 100),
          child: SosTimerWidget(
            center: _center,
            timerRadius: _timerRadius.value,
            seconds: _seconds,
            progress: _progress.value,
          ),
        ),
      ),
    );
  }

  void _initControllers() {
    _fillAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _progressAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.countdownDuration),
    );
    _timerRadiusController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _timerRadiusController.addListener(() => setState(() {}));
    _progressAnimationController.addListener(() => setState(() {}));
    _fillAnimationController.addListener(() => setState(() {}));
  }

  void _initAnimations() {
    _timerRadius = Tween<double>(begin: 56, end: 140).animate(
      CurvedAnimation(
        parent: _timerRadiusController,
        curve: Curves.easeOutBack,
      ),
    );

    _progress =
        Tween<double>(begin: 0, end: 1).animate(_progressAnimationController);

    _fillRadius = Tween<double>(begin: 0, end: _calculatedFill)
        .animate(_fillAnimationController);
  }

  void _tickTimer(Timer timer){
    if (_seconds == 0) {
      timer.cancel();
    } else {
      setState(() {
        _seconds--;
      });
    }
  }

  Future<void> _beginCountdown() async {
    if (!_centersEquals) {
      await _fillAnimationController.forward();
      setState(() {
        _timerVisible = true;
      });
    } else {
      unawaited(_fillAnimationController.forward(),);
    }

    unawaited(_timerRadiusController.forward(),);

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), _tickTimer);

    await _progressAnimationController.forward();

    unawaited(
      _progressAnimationController.animateBack(
        0,
        duration: const Duration(milliseconds: 400),
      ),
    );

    unawaited(
      _fillAnimationController.animateBack(
        0,
        duration: const Duration(milliseconds: 400),
      ),
    );

    if (!_centersEquals) {
      setState(() {
        _timerVisible = false;
      });
    }

    await _timerRadiusController.animateBack(
      0,
      duration: const Duration(milliseconds: 300),
    );
    if (widget.onComplete != null) {
      widget.onComplete!();
    }
  }
}
