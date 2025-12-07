import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_portfolio/presentation/main_screen.dart';

import 'package:my_portfolio/presentation/widgets/animated_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to MainScreen after delay
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 1000),
            pageBuilder: (_, __, ___) => const MainScreen(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
           // Matched Background Animation
           const Positioned.fill(child: AnimatedBackground()),
           
           // Centered Loader
           Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                const SizedBox(height: 40),
                // Text Animation
                Text(
                  "LOADING...",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, // Match theme
                    fontFamily: 'Courier',
                    fontSize: 16,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
                .animate() // Fade in initially
                .fadeIn(duration: 800.ms, curve: Curves.easeOut),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
