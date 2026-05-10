// lib/widgets/animated/scale_animation_widget.dart

import 'package:flutter/material.dart';

class ScaleAnimationWidget
    extends StatefulWidget {
  final Widget child;

  final Duration duration;

  const ScaleAnimationWidget({
    super.key,
    required this.child,
    this.duration =
        const Duration(milliseconds: 500),
  });

  @override
  State<ScaleAnimationWidget> createState() =>
      _ScaleAnimationWidgetState();
}

class _ScaleAnimationWidgetState
    extends State<ScaleAnimationWidget>
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
      begin: 0.8,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}