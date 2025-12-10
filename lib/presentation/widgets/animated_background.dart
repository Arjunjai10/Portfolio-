import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  final List<Star> _stars = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      if (mounted) {
        setState(() {
          for (var star in _stars) {
            star.update();
          }
        });
      }
    });
    _ticker.start();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_stars.isEmpty) {
      final size = MediaQuery.of(context).size;
      for (int i = 0; i < 100; i++) { // More stars
        _stars.add(Star(
          x: _random.nextDouble() * size.width,
          y: _random.nextDouble() * size.height,
          speed: 1 + _random.nextDouble() * 4, // Horizontal speed
          size: 2 + _random.nextDouble() * 3, // Variable pixel size
          color: Colors.white.withValues(alpha: 0.2 + _random.nextDouble() * 0.6),
        ));
      }
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor, 
      child: CustomPaint(
        painter: StarfieldPainter(stars: _stars),
        child: Container(),
      ),
    );
  }
}

class Star {
  double x, y, speed, size;
  Color color;

  Star({required this.x, required this.y, required this.speed, required this.size, required this.color});

  void update() {
    x -= speed; // Move Left
    if (x < 0) {
      x = 4000; // Loop back far right (assuming large screen)
      y = Random().nextDouble() * 3000; // Random Y
    }
  }
}

class StarfieldPainter extends CustomPainter {
  final List<Star> stars;

  StarfieldPainter({required this.stars});

  @override
  void paint(Canvas canvas, Size size) {
     for (var s in stars) {
       // Loop logic is handled in update(), just ensuring it's within view if needed, 
       // but typically we trust the update logic or just draw.
       
       canvas.drawCircle(
         Offset(s.x, s.y),
         s.size / 2, // Radius is half the size
         Paint()..color = s.color,
       );
     }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
