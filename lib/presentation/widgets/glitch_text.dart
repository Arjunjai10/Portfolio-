import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GlitchText extends StatefulWidget {
  final String text;
  final TextStyle? style;

  const GlitchText(this.text, {super.key, this.style});

  @override
  State<GlitchText> createState() => _GlitchTextState();
}

class _GlitchTextState extends State<GlitchText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Timer? _glitchTimer;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    _startGlitchLoop();
  }

  void _startGlitchLoop() {
    _glitchTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_random.nextBool()) { // 50% chance to glitch every 3s
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _glitchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double offset = _controller.value * 3.0;
        return Stack(
          children: [
            // Red Channel
            Transform.translate(
              offset: Offset(offset, 0),
              child: Text(
                widget.text,
                style: widget.style?.copyWith(color: Colors.red.withOpacity(0.8)),
              ),
            ),
            // Blue Channel
            Transform.translate(
              offset: Offset(-offset, 0),
              child: Text(
                widget.text,
                style: widget.style?.copyWith(color: Colors.blue.withOpacity(0.8)),
              ),
            ),
            // Main Text
            Text(widget.text, style: widget.style),
          ],
        );
      },
    );
  }
}
