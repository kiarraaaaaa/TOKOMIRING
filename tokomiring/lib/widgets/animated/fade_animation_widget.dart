// lib/widgets/animated/fade_animation_widget.dart

import 'package:flutter/material.dart';

class FadeAnimationWidget
    extends StatefulWidget {
  final Widget child;

  final Duration duration;

  const FadeAnimationWidget({
    super.key,
    required this.child,
    this.duration =
        const Duration(milliseconds: 600),
  });

  @override
  State<FadeAnimationWidget> createState() =>
      _FadeAnimationWidgetState();
}

class _FadeAnimationWidgetState
    extends State<FadeAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}