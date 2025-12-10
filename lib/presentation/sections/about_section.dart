import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/data/data_sources/portfolio_data.dart';
import 'package:my_portfolio/presentation/widgets/glass_card.dart';
import 'package:my_portfolio/presentation/widgets/section_container.dart';
import 'package:my_portfolio/presentation/widgets/tilt_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Certifications Header
          Text(
            "Certifications",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier',
                ),
          ).animate().fadeIn().slideX(),
          const SizedBox(height: 32),
          
          // Certifications Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.5,
            ),
            itemCount: PortfolioData.certifications.length,
            itemBuilder: (context, index) {
              return CertificationCard(text: PortfolioData.certifications[index])
                  .animate()
                  .fadeIn(delay: (index * 100).ms)
                  .scale();
            },
          ),
          
          const SizedBox(height: 64),
          
          // Achievements Header
          Text(
            "Achievements (Terminal)",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier',
                ),
          ).animate().fadeIn(delay: 400.ms).slideX(),
          const SizedBox(height: 32),
          
          // Terminal Window
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fake Terminal Header
                Row(
                  children: [
                    Container(width: 12, height: 12, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Container(width: 12, height: 12, decoration: const BoxDecoration(color: Colors.yellow, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Container(width: 12, height: 12, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                    const SizedBox(width: 16),
                    Text("user@portfolio:~", style: TextStyle(color: Colors.white.withOpacity(0.5), fontFamily: 'Courier', fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 24),
                // Commands
                const Text("> cat achievements.txt", style: TextStyle(color: Colors.greenAccent, fontFamily: 'Courier', fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                // Output
                ...PortfolioData.achievements.map((achievement) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "• $achievement",
                    style: const TextStyle(color: Colors.white, fontFamily: 'Courier'),
                  ),
                )),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Text("> ", style: TextStyle(color: Colors.greenAccent, fontFamily: 'Courier', fontWeight: FontWeight.bold)),
                    _BlinkingCursor(),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0),
        ],
      ),
    );
  }
}

class CertificationCard extends StatelessWidget {
  final String text;
  const CertificationCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TiltCard(
      child: GlassCard(
        opacity: 0.1,
        // Premium Gold Tint
        color: const Color(0xFFFFD700).withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFFFD700).withOpacity(0.3), // Gold Border
              width: 1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.05),
                const Color(0xFFFFD700).withOpacity(0.05), // Subtle Gold
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Row(
            children: [
              // Gold Medal / Award Icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFD700).withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const FaIcon(FontAwesomeIcons.award, color: Colors.black87, size: 18),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text, 
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 0.5,
                            // Use theme color (black in light, white in dark)
                            color: Theme.of(context).textTheme.titleMedium?.color,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "VERIFIED CERTIFICATION", 
                      style: TextStyle(
                        fontSize: 10,
                        // Use primary color (purple) or a darker gold that works on white
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor();

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 10,
        height: 18,
        color: Colors.greenAccent,
      ),
    );
  }
}
