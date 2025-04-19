import 'package:flutter/material.dart';
import 'draggable_logger_overlay.dart';

class NetwordLoggerHost extends StatefulWidget {
  const NetwordLoggerHost({super.key});

  @override
  State<NetwordLoggerHost> createState() => _NetwordLoggerHostState();
}

class _NetwordLoggerHostState extends State<NetwordLoggerHost> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final overlay = Overlay.of(context, rootOverlay: true);
      if (overlay != null && !DraggableLoggerOverlay.isInserted) {
        overlay.insert(DraggableLoggerOverlay.instance);
        DraggableLoggerOverlay.isInserted = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
