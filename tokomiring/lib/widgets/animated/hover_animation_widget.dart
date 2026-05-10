import 'package:flutter/material.dart';

class HoverAnimationWidget extends StatefulWidget {
  final Widget child;

  const HoverAnimationWidget({
    super.key,
    required this.child,
  });

  @override
  State<HoverAnimationWidget> createState() => _HoverAnimationWidgetState();
}

class _HoverAnimationWidgetState extends State<HoverAnimationWidget> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedScale(
        scale: hovering ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: widget.child,
      ),
    );
  }
}
