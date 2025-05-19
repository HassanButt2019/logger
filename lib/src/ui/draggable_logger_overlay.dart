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
bool isOnApiListScreen = false;
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
  return FloatingActionButton(
    backgroundColor: Colors.deepPurple,
    onPressed: () {
      if (!isOnApiListScreen) {
        isOnApiListScreen = true;

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const ApiListScreen()))
            .then((_) {
          isOnApiListScreen = false; // Reset when user returns
        });
      }
    },
    child: const Icon(Icons.api),
  );
}


}