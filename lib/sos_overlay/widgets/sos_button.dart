import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SosButton extends StatelessWidget {
  const SosButton(
      {Key? key,
      this.containerColor = Colors.white,
      this.sosItemColor = Colors.red,
      this.visible = true, this.border, this.sosButtonKey, this.height, this.width, this.onLongPress, this.onLongPressEnd,})
      : super(key: key);
  final Color containerColor;
  final Color sosItemColor;
  final double? height;
  final double? width;
  final bool visible;
  final Border? border;
  final GlobalKey? sosButtonKey;
  final void Function()? onLongPress;
  final void Function(LongPressEndDetails details)? onLongPressEnd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onLongPressEnd: onLongPressEnd,
      child: Opacity(
        opacity: visible ? 1 : 0,
        child: Container(
          height: height,
          width: width,
          key: sosButtonKey,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: containerColor,
            border: border,
          ),
          child: SvgPicture.asset(
            'assets/sos_item.svg',
            color: sosItemColor,
          ),
        ),
      ),
    );
  }
}
