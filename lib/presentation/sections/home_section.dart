import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/data/data_sources/portfolio_data.dart';
import 'package:my_portfolio/presentation/widgets/animated_background.dart';
import 'package:my_portfolio/presentation/widgets/section_container.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(child: AnimatedBackground()),
        SectionContainer(
          height: 800, // Make home section taller for impact
          backgroundColor: Colors.transparent, // Allow background to show
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, I am",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
              const SizedBox(height: 16),
              Text(
                PortfolioData.name,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 64, // Bigger font
                    ),
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms).scale(),
              const SizedBox(height: 16),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontFamily: Theme.of(context).textTheme.headlineMedium?.fontFamily,
                    ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      PortfolioData.tagline,
                      speed: const Duration(milliseconds: 100),
                      cursor: '|',
                    ),
                  ],
                  totalRepeatCount: 1,
                  displayFullTextOnTap: true,
                ),
              ),
              const SizedBox(height: 48),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Placeholder for Resume Download
                    },
                    icon: const Icon(Icons.download),
                    label: const Text("Download Resume"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                  ).animate().shimmer(delay: 1000.ms, duration: 1200.ms).fadeIn(delay: 600.ms, duration: 600.ms),
                  OutlinedButton.icon(
                    onPressed: () => launchUrl(Uri.parse(PortfolioData.githubUrl)),
                    icon: const FaIcon(FontAwesomeIcons.github),
                    label: const Text("GitHub"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                  ).animate().fadeIn(delay: 700.ms, duration: 600.ms),
                  OutlinedButton.icon(
                    onPressed: () => launchUrl(Uri.parse(PortfolioData.linkedinUrl)),
                    icon: const FaIcon(FontAwesomeIcons.linkedin),
                    label: const Text("LinkedIn"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                  ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
                ],
          ),
        ],
      ),
    ),
      ],
    );
  }
}
