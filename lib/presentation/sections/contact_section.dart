import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/data/data_sources/portfolio_data.dart';
import 'package:my_portfolio/presentation/widgets/section_container.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      height: 400,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Get In Touch",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            "I'm currently looking for new opportunities.",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => launchUrl(Uri.parse("mailto:${PortfolioData.email}")),
            icon: const Icon(Icons.email),
            label: const Text("Say Hello"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => launchUrl(Uri.parse(PortfolioData.githubUrl)),
                icon: const FaIcon(FontAwesomeIcons.github),
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: () => launchUrl(Uri.parse(PortfolioData.linkedinUrl)),
                icon: const FaIcon(FontAwesomeIcons.linkedin),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "© 2025 Arjun Jai Shanmugam P.V.N",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
