import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final Color? color;
  final BorderRadius? borderRadius;
  final bool enableSpotlight;

  const GlassCard({
    super.key,
    required this.child,
    this.blur = 10.0,
    this.opacity = 0.1,
    this.color,
    this.borderRadius,
    this.enableSpotlight = true,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  Offset _mousePos = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(16.0);
    
    return MouseRegion(
      onHover: (details) {
        if (widget.enableSpotlight) {
          setState(() {
            _mousePos = details.localPosition;
          });
        }
      },
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
          child: Stack(
            children: [
              // Base Container
              Container(
                decoration: BoxDecoration(
                  color: (widget.color ?? Theme.of(context).colorScheme.surface).withValues(alpha: widget.opacity),
                  borderRadius: borderRadius,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
                    width: 1.0,
                  ),
                ),
                child: widget.child,
              ),
              // Spotlight Overlay
              if (widget.enableSpotlight)
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: _SpotlightPainter(
                        cursorPos: _mousePos,
                        borderColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
                        borderRadius: borderRadius,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpotlightPainter extends CustomPainter {
  final Offset cursorPos;
  final Color borderColor;
  final BorderRadius borderRadius;

  _SpotlightPainter({required this.cursorPos, required this.borderColor, required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..shader = RadialGradient(
        colors: [borderColor, Colors.transparent],
        radius: 0.6, // Adjust radius to control spotlight size
        center: Alignment(
          (cursorPos.dx / size.width) * 2 - 1,
          (cursorPos.dy / size.height) * 2 - 1,
        ),
        tileMode: TileMode.clamp,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // We draw the RRect with the shader
    canvas.drawRRect(borderRadius.toRRect(Rect.fromLTWH(0, 0, size.width, size.height)), paint);
  }

  @override
  bool shouldRepaint(covariant _SpotlightPainter oldDelegate) {
    return oldDelegate.cursorPos != cursorPos;
  }
}
