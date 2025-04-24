import 'package:flutter/material.dart';
import 'api_list_screen.dart';

class DraggableLoggerOverlay {
  static bool isInserted = false;

  static final OverlayEntry instance = OverlayEntry(
    builder: (context) => const _DraggableLoggerButton(),
  );
}

class _DraggableLoggerButton extends StatefulWidget {
  const _DraggableLoggerButton();

  @override
  State<_DraggableLoggerButton> createState() => _DraggableLoggerButtonState();
}

class _DraggableLoggerButtonState extends State<_DraggableLoggerButton> {
  double top = 100;
  double left = 20;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Draggable(
        feedback: _buildButton(),
        childWhenDragging: Container(),
        onDragEnd: (details) {
          setState(() {
            top = details.offset.dy;
            left = details.offset.dx;
          });
        },
        child: _buildButton(),
      ),
    );
  }
Widget _buildButton() {
  final currentRoute = ModalRoute.of(context);

  return FloatingActionButton(
    backgroundColor: Colors.deepPurple,
    onPressed: () {
      if (currentRoute?.settings.name != 'ApiListScreen') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const ApiListScreen(),
            settings: const RouteSettings(name: 'ApiListScreen'),
          ),
        );
      }
    },
    child: const Icon(Icons.api),
  );
}

}
