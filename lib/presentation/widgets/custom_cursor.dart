import 'package:flutter/material.dart';

class CustomCursor extends StatefulWidget {
  final Widget child;
  const CustomCursor({super.key, required this.child});

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor> {
  Offset _mousePos = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerHover: (event) {
        setState(() {
          _mousePos = event.localPosition;
        });
      },
      behavior: HitTestBehavior.translucent, // Capture events even if child handles them
      child: MouseRegion(
        cursor: SystemMouseCursors.none, // Hide default cursor
        child: Stack(
          children: [
            widget.child,
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
              left: _mousePos.dx - 15,
              top: _mousePos.dy - 15,
              child: IgnorePointer(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            Positioned(
              left: _mousePos.dx - 4,
              top: _mousePos.dy - 4,
              child: IgnorePointer(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
