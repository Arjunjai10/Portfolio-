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
  final List<Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      if (mounted) {
        setState(() {
          for (var particle in _particles) {
            particle.update();
          }
        });
      }
    });
    _ticker.start();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_particles.isEmpty) {
      final size = MediaQuery.of(context).size;
      for (int i = 0; i < 30; i++) {
        _particles.add(Particle(
          x: _random.nextDouble() * size.width,
          y: _random.nextDouble() * size.height,
          vx: _random.nextDouble() * 1.5 - 0.75,
          vy: _random.nextDouble() * 1.5 - 0.75,
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
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
      color: Theme.of(context).colorScheme.surface, // Base background
      child: CustomPaint(
        painter: ParticleNetworkPainter(
          particles: _particles,
          lineColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        ),
        child: Container(),
      ),
    );
  }
}

class Particle {
  double x, y, vx, vy;
  Color color;

  Particle({required this.x, required this.y, required this.vx, required this.vy, required this.color});

  void update() {
    x += vx;
    y += vy;

    // Bounce off edges (simplified wrapped for seamless look or bounce)
    // Let's bounce:
    // Actually, wrap sounds cooler for network.
    // If we bounce we need screen size, let's just bounce conceptually - wait, we don't have screen size in update easily.
    // Let's pass bounds or simple logic: if x > 2000 (rough max) reset. 
    // Wait, simpler: just let them drift and if they go too far, wrap them.
    // Ideally we need screen size. For now let's just let them move, the painter handles drawing.
    // We can assume a large enough canvas or pass bounds.
    // Let's just make them bounce effectively by checking rough bounds or simple sine wave motion relative to origin?
    // No, linear motion is best for tech.
    // Let's just re-initialize if out of bounds in Painter? No, keep logic here.
    // We will assume 1920x1080 approx for bounds or pass it.
    // Actually, let's just use a fixed large bounds for now.
    
    if (x < 0 || x > 3000) vx = -vx; 
    if (y < 0 || y > 3000) vy = -vy;
  }
}

class ParticleNetworkPainter extends CustomPainter {
  final List<Particle> particles;
  final Color lineColor;

  ParticleNetworkPainter({required this.particles, required this.lineColor});

  @override
  void paint(Canvas canvas, Size size) {
     // Update bounds check here effectively
     for (var p in particles) {
       if (p.x < 0) p.x = size.width;
       if (p.x > size.width) p.x = 0;
       if (p.y < 0) p.y = size.height;
       if (p.y > size.height) p.y = 0;
       
       // Draw particle
       canvas.drawCircle(Offset(p.x, p.y), 3.0, Paint()..color = p.color);
     }

     // Draw lines
     for (int i = 0; i < particles.length; i++) {
       for (int j = i + 1; j < particles.length; j++) {
         var p1 = particles[i];
         var p2 = particles[j];
         var dx = p1.x - p2.x;
         var dy = p1.y - p2.y;
         var dist = sqrt(dx * dx + dy * dy);

         if (dist < 150) {
           canvas.drawLine(
             Offset(p1.x, p1.y),
             Offset(p2.x, p2.y),
             Paint()..color = lineColor.withValues(alpha: (1 - dist / 150) * 0.3)..strokeWidth = 1,
           );
         }
       }
     }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
