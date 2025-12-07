import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/logic/theme_cubit.dart';
import 'package:my_portfolio/presentation/sections/about_section.dart';
import 'package:my_portfolio/presentation/sections/contact_section.dart';
import 'package:my_portfolio/presentation/sections/experience_section.dart';
import 'package:my_portfolio/presentation/sections/home_section.dart';
import 'package:my_portfolio/presentation/sections/projects_section.dart';
import 'package:my_portfolio/presentation/sections/skills_section.dart';
import 'package:my_portfolio/presentation/widgets/floating_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _homeKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollToSection(int index) {
    final keys = [
      _homeKey,
      _aboutKey,
      _experienceKey,
      _projectsKey,
      _skillsKey,
      _contactKey
    ];
    
    if (index >= 0 && index < keys.length) {
      Scrollable.ensureVisible(
        keys[index].currentContext!,
        duration: const Duration(milliseconds: 1000), // Slower, smoother
        curve: Curves.easeInOutCubic, // More pronounced acceleration/deceleration
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<ThemeCubit>().toggleTheme(),
        child: Icon(context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark
            ? Icons.light_mode
            : Icons.dark_mode),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1600), // Increased width for better web feel
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeSection(key: _homeKey),
                    AboutSection(key: _aboutKey),
                    ExperienceSection(key: _experienceKey),
                    ProjectsSection(key: _projectsKey),
                    SkillsSection(key: _skillsKey),
                    ContactSection(key: _contactKey),
                    const SizedBox(height: 100), // Extra space at bottom
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: FloatingNavBar(
              onItemTapped: _scrollToSection,
            ),
          ),
        ],
      ),
    );
  }
}
