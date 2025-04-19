import 'package:flutter/material.dart';
import 'draggable_logger_overlay.dart';

class NetworkLoggerHost extends StatefulWidget {
  const NetworkLoggerHost({super.key});

  @override
  State<NetworkLoggerHost> createState() => _NetworkLoggerHostState();
}

class _NetworkLoggerHostState extends State<NetworkLoggerHost> {
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
