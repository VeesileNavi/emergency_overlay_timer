import 'package:flutter/material.dart';

class SosCountdownInfo extends StatelessWidget {
  const SosCountdownInfo({Key? key, required this.seconds}) : super(key: key);
  final int seconds;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Экстренное обращение в службу 112 через...',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.red,
                  Colors.red.withOpacity(0),
                ],
                stops: const [
                  0.5,
                  1,
                ],
              )),
          child: Center(
            child: Text(
              seconds.toString(),
              maxLines: 2,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const Text(
          'Сек.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
