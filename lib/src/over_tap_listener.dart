import 'dart:async';

import 'package:flutter/material.dart';

class OverTapListener extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final Size detectorSize;
  final Stream stream;

  const OverTapListener({
    Key? key,
    required this.child,
    required this.onTap,
    required this.detectorSize,
    required this.stream,
  }) : super(key: key);

  @override
  _OverTapListenerState createState() => _OverTapListenerState();
}

class _OverTapListenerState extends State<OverTapListener> {
  bool waitForNextGesture = false;
  StreamSubscription? _ss;

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      startListener();
    });
  }

  @override
  void dispose() {
    removeListener();
    super.dispose();
  }

  void startListener() {
    _ss = widget.stream.listen((dynamic data) {
      // tap down event
      // 判断down是否在侦测范围
      if (data is TapDownDetails) {
        final RenderBox box = context.findRenderObject()! as RenderBox;
        final Offset target = box.localToGlobal(
          box.size.center(Offset.zero),
        );

        Rect rect = Rect.fromCenter(
          center: target,
          width: widget.detectorSize.width,
          height: widget.detectorSize.height,
        );
        Offset tapDownOffset = data.globalPosition;
        waitForNextGesture = rect.contains(tapDownOffset);
      } else if (data is TapUpDetails && waitForNextGesture) {
        // tap up event
        waitForNextGesture = false;
        widget.onTap();
      } else if (data == null) {
        // cancel event
        waitForNextGesture = false;
      }
    });
  }

  void removeListener() {
    _ss?.cancel();
  }
}