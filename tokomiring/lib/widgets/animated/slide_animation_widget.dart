// lib/widgets/animated/slide_animation_widget.dart

import 'package:flutter/material.dart';

class SlideAnimationWidget
    extends StatefulWidget {
  final Widget child;

  final Offset beginOffset;

  final Duration duration;

  const SlideAnimationWidget({
    super.key,
    required this.child,
    this.beginOffset =
        const Offset(0, 0.3),
    this.duration =
        const Duration(milliseconds: 700),
  });

  @override
  State<SlideAnimationWidget> createState() =>
      _SlideAnimationWidgetState();
}

class _SlideAnimationWidgetState
    extends State<SlideAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
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
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}