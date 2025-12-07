import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/data/data_sources/portfolio_data.dart';
import 'package:my_portfolio/data/models/models.dart';
import 'package:my_portfolio/presentation/widgets/glass_card.dart';
import 'package:my_portfolio/presentation/widgets/section_container.dart';
import 'package:my_portfolio/presentation/widgets/tilt_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tech Stack (Arsenal)",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier',
                ),
          ).animate().fadeIn().slideX(),
          const SizedBox(height: 32),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: PortfolioData.skills.length,
            itemBuilder: (context, index) {
              return SkillCategoryGroup(skill: PortfolioData.skills[index])
                  .animate()
                  .fadeIn(delay: (index * 100).ms)
                  .slideX(begin: 0.1, end: 0);
            },
          ),
        ],
      ),
    );
  }
}

class SkillCategoryGroup extends StatelessWidget {
  final Skill skill;
  const SkillCategoryGroup({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "> ${skill.category.toUpperCase()}",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: 'Courier',
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: skill.names.map((name) => SkillLogoCard(skillName: name)).toList(),
          ),
        ],
      ),
    );
  }
}

class SkillLogoCard extends StatelessWidget {
  final String skillName;
  const SkillLogoCard({super.key, required this.skillName});

  IconData _getIconForSkill(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('flutter')) return FontAwesomeIcons.flutter;
    if (lower.contains('dart')) return FontAwesomeIcons.bullseye; // No official Dart icon in FA yet, conceptual
    if (lower.contains('react')) return FontAwesomeIcons.react;
    if (lower.contains('node')) return FontAwesomeIcons.nodeJs;
    if (lower.contains('java') && !lower.contains('script')) return FontAwesomeIcons.java;
    if (lower.contains('python')) return FontAwesomeIcons.python;
    if (lower.contains('mongo')) return FontAwesomeIcons.database;
    if (lower.contains('git')) return FontAwesomeIcons.github;
    if (lower.contains('c++')) return FontAwesomeIcons.c; // Use C as placeholder or standard coding icon
    if (lower.contains('html')) return FontAwesomeIcons.html5;
    if (lower.contains('css')) return FontAwesomeIcons.css3;
    if (lower.contains('js') || lower.contains('javascript')) return FontAwesomeIcons.js;
    if (lower.contains('android')) return FontAwesomeIcons.android;
    if (lower.contains('aws')) return FontAwesomeIcons.aws;
    if (lower.contains('docker')) return FontAwesomeIcons.docker;
    
    return FontAwesomeIcons.code; // Default
  }

  @override
  Widget build(BuildContext context) {
    return TiltCard(
      child: Tooltip(
        message: skillName,
        child: GlassCard(
          opacity: 0.1,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  _getIconForSkill(skillName),
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
