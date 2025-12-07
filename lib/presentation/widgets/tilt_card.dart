import 'package:flutter/material.dart';

class TiltCard extends StatefulWidget {
  final Widget child;
  final double borderRadius;

  const TiltCard({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
  });

  @override
  State<TiltCard> createState() => _TiltCardState();
}

class _TiltCardState extends State<TiltCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _tiltAnimation;
  
  // Tilt angles
  double x = 0.0;
  double y = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {},
      onExit: (_) {
        setState(() {
          x = 0;
          y = 0;
        });
      },
      onHover: (details) {
        final size = context.size!;
        final centerX = size.width / 2;
        final centerY = size.height / 2;

        final percentX = (details.localPosition.dx - centerX) / centerX;
        final percentY = (details.localPosition.dy - centerY) / centerY;

        setState(() {
          x = -percentY * 0.1; // Rotate X based on Y Axis movement
          y = percentX * 0.1;  // Rotate Y based on X Axis movement
        });
      },
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // Perspective
          ..rotateX(x)
          ..rotateY(y),
        child: widget.child,
      ),
    );
  }
}
