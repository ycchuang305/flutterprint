import 'dart:async';
import 'package:flutter/material.dart';

/// A countdown trigger is a widget that starts counting down from a specified number [startFrom],
/// and decreases by 1 every time the child widget is pressed, the [onUpdated] callback is triggered each time the count decreases.
/// When the count reaches 0, the [onFinished] callback is triggered and the count will reset back to [startFrom].
///
/// If there are no press events within [resetDurationInSec] seconds,
/// the count will reset back to [startFrom].
class CountdownTrigger extends StatefulWidget {
  final Widget child;
  final int startFrom;
  final int resetDurationInSec;
  final void Function(int)? onUpdated;
  final VoidCallback? onFinished;
  const CountdownTrigger({
    super.key,
    required this.startFrom,
    required this.child,
    this.resetDurationInSec = 3,
    this.onUpdated,
    this.onFinished,
  })  : assert(startFrom > 0),
        assert(resetDurationInSec > 0);

  @override
  State<CountdownTrigger> createState() => _CountdownTriggerState();
}

class _CountdownTriggerState extends State<CountdownTrigger> {
  Timer? timer;
  late int count;

  @override
  void initState() {
    super.initState();
    count = widget.startFrom;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        timer?.cancel();
        timer = Timer(
          Duration(seconds: widget.resetDurationInSec),
          () => count = widget.startFrom,
        );
        count--;
        if (count > 0) {
          widget.onUpdated?.call(count);
        } else {
          timer?.cancel();
          count = widget.startFrom;
          widget.onFinished?.call();
        }
      },
      child: widget.child,
    );
  }
}
