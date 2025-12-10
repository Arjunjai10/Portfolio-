import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_portfolio/data/data_sources/portfolio_data.dart';
import 'package:my_portfolio/data/models/models.dart';
import 'package:my_portfolio/presentation/widgets/glass_card.dart';
import 'package:my_portfolio/presentation/widgets/section_container.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:my_portfolio/presentation/widgets/tilt_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Projects",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ).animate().fadeIn().slideX(),
          const SizedBox(height: 32),
          ResponsiveGridView.builder(
            gridDelegate: const ResponsiveGridDelegate(
              maxCrossAxisExtent: 400,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1.2,
            ),
            itemCount: PortfolioData.projects.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ProjectCard(project: PortfolioData.projects[index])
                  .animate()
                  .fadeIn(delay: (index * 200).ms)
                  .slideY(begin: 0.2, end: 0);
            },
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return TiltCard(
      child: GlassCard(
        opacity: 0.05,
        child: InkWell(
          onTap: () {}, // Add functionality to open link if available
          hoverColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      project.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (project.link != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        onPressed: () => launchUrl(Uri.parse(project.link!)),
                        icon: const FaIcon(FontAwesomeIcons.github, size: 20),
                        tooltip: "View Code",
                        style: IconButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                    ),
                  if (project.apkLink != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        onPressed: () => launchUrl(Uri.parse(project.apkLink!)),
                        icon: const Icon(Icons.android, size: 20, color: Colors.green),
                        tooltip: "Download APK",
                        style: IconButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                project.period,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Text(
                  project.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: project.technologies.take(3).map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tech,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                          ),
                    ),
                  );
                }).toList(),
              ),


            ],
            ),
          ),
        ),
      ),
    );
  }
}
