import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final Color? backgroundColor;

  const SectionContainer({
    super.key,
    required this.child,
    this.height,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: double.infinity,
      constraints: BoxConstraints(minHeight: height ?? 600),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: child,
        ),
      ),
    );
  }
}
