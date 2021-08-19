import 'dart:async';

import 'package:flutter/material.dart';

class OverTapDispatcher extends StatelessWidget {
  final Widget child;
  final StreamSink sink;

  const OverTapDispatcher({
    Key? key,
    required this.child,
    required this.sink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        sink.add(_);
      },
      onTapUp: (_) {
        sink.add(_);
      },
      onTapCancel: () {
        sink.add(null);
      },
      child: child,
    );
  }
}
