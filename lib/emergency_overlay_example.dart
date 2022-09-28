import 'package:emergency_overlay_timer/sos_overlay/sos_overlay_widget.dart';
import 'package:emergency_overlay_timer/sos_overlay/widgets/sos_button.dart';
import 'package:flutter/material.dart';

class EmergencyOverlayExample extends StatefulWidget {
  const EmergencyOverlayExample({Key? key}) : super(key: key);

  @override
  _EmergencyOverlayExampleState createState() =>
      _EmergencyOverlayExampleState();
}

class _EmergencyOverlayExampleState extends State<EmergencyOverlayExample>
    with TickerProviderStateMixin {
  OverlayEntry? _overlayEntry;

  final GlobalKey sosKey = GlobalKey();
  final GlobalKey sosItemKey = GlobalKey();
  late bool sosTimerVisible;

  @override
  void initState() {
    sosTimerVisible = true;
    super.initState();
  }

  @override
  void dispose() {
    _overlayEntry?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext currentContext) {
    return MaterialApp(
      home: Overlay(
        initialEntries: [
          OverlayEntry(builder: (currentContext) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Flutter Sandbox'),
              ),
              body: Center(
                child: SosButton(
                  height: 120,
                  width: 120,
                  border: Border.all(
                      color: const Color.fromRGBO(255, 218, 218, 1),
                      width: 8),
                  containerColor: Colors.red,
                  sosItemColor: Colors.white,
                  visible: sosTimerVisible,
                  key: sosItemKey,
                  onLongPress: () {
                    if (sosTimerVisible) {
                      _setOverlayEntry(currentContext);
                      sosTimerVisible = false;
                    }
                  },
                  onLongPressEnd: (details) {
                    if (_overlayEntry!.mounted) {
                      _overlayEntry!.remove();
                      sosTimerVisible = true;
                    }
                  },
                ),
              ),
              bottomNavigationBar: Builder(builder: (currentContext) {
                return Container(
                  color: Colors.white,
                  height: 72,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        key: sosKey,
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: const Center(
                          child: Text(
                            'sos',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          })
        ],
      ),
    );
  }

  void _setOverlayEntry(BuildContext currentContext) {
    _overlayEntry = OverlayEntry(builder: (currentContext) {
      final itemObject =
          sosItemKey.currentContext?.findRenderObject() as RenderBox;
      var timerCenter = itemObject.localToGlobal(
          Offset(itemObject.size.width / 2, itemObject.size.height / 2));
      return SosOverlayWidget(
        fillCenter: timerCenter,
        timerCenter: timerCenter,
        countdownDuration: 3,
        onComplete: () {
          _overlayEntry!.remove();
          setState(() {
            sosTimerVisible = true;
          });
        },
        context: currentContext,
      );
    });
    Overlay.of(currentContext)!.insert(_overlayEntry!);
    return;
  }
}
