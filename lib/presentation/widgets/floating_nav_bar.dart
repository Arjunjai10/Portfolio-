import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/presentation/widgets/glass_card.dart';

class FloatingNavBar extends StatelessWidget {
  final Function(int) onItemTapped;

  const FloatingNavBar({super.key, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: GlassCard(
        opacity: 0.1,
        blur: 10,
        borderRadius: BorderRadius.circular(50),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                 _NavBarItem(icon: FontAwesomeIcons.house, label: 'Home', onTap: () => onItemTapped(0)),
                 const SizedBox(width: 24),
                 _NavBarItem(icon: FontAwesomeIcons.user, label: 'About', onTap: () => onItemTapped(1)),
                 const SizedBox(width: 24),
                 _NavBarItem(icon: FontAwesomeIcons.briefcase, label: 'Experience', onTap: () => onItemTapped(2)),
                 const SizedBox(width: 24),
                 _NavBarItem(icon: FontAwesomeIcons.diagramProject, label: 'Projects', onTap: () => onItemTapped(3)),
                 const SizedBox(width: 24),
                 _NavBarItem(icon: FontAwesomeIcons.code, label: 'Skills', onTap: () => onItemTapped(4)),
                 const SizedBox(width: 24),
                 _NavBarItem(icon: FontAwesomeIcons.addressCard, label: 'Contact', onTap: () => onItemTapped(5)),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: -1, end: 0);
  }
}

class _NavBarItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavBarItem({required this.icon, required this.label, required this.onTap});

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovering ? 1.2 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Tooltip(
            message: widget.label,
            child: FaIcon(
              widget.icon,
              color: _isHovering 
                  ? Theme.of(context).colorScheme.primary 
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
