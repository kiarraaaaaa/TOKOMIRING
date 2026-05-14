// lib/widgets/animations/stagger_animation.dart

import 'package:flutter/material.dart';

class StaggerAnimation
    extends StatefulWidget {

  final Widget child;

  final Duration delay;

  final Duration duration;

  final Offset beginOffset;

  final Curve curve;

  final bool fade;

  final bool slide;

  final bool scale;

  final double beginScale;

  const StaggerAnimation({

    super.key,

    required this.child,

    this.delay =
        Duration.zero,

    this.duration =
        const Duration(
      milliseconds: 500,
    ),

    this.beginOffset =
        const Offset(
      0,
      0.08,
    ),

    this.curve =
        Curves.easeOutCubic,

    this.fade = true,

    this.slide = true,

    this.scale = false,

    this.beginScale = 0.96,
  });

  @override
  State<StaggerAnimation>
      createState() =>
          _StaggerAnimationState();
}

class _StaggerAnimationState
    extends State<StaggerAnimation>
    with
        SingleTickerProviderStateMixin {

  late AnimationController
      _controller;

  late Animation<double>
      _fadeAnimation;

  late Animation<Offset>
      _slideAnimation;

  late Animation<double>
      _scaleAnimation;

  // =====================================================
  // INIT
  // =====================================================

  @override
  void initState() {

    super.initState();

    _controller =
        AnimationController(

      vsync: this,

      duration:
          widget.duration,
    );

    final curvedAnimation =
        CurvedAnimation(

      parent:
          _controller,

      curve:
          widget.curve,
    );

    _fadeAnimation =
        Tween<double>(

      begin: 0,

      end: 1,

    ).animate(
      curvedAnimation,
    );

    _slideAnimation =
        Tween<Offset>(

      begin:
          widget.beginOffset,

      end:
          Offset.zero,

    ).animate(
      curvedAnimation,
    );

    _scaleAnimation =
        Tween<double>(

      begin:
          widget.beginScale,

      end: 1,

    ).animate(
      curvedAnimation,
    );

    startAnimation();
  }

  // =====================================================
  // START
  // =====================================================

  Future<void>
      startAnimation()
      async {

    if (widget.delay >
        Duration.zero) {

      await Future.delayed(
        widget.delay,
      );
    }

    if (!mounted) {
      return;
    }

    _controller.forward();
  }

  // =====================================================
  // DISPOSE
  // =====================================================

  @override
  void dispose() {

    _controller.dispose();

    super.dispose();
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(
    BuildContext context,
  ) {

    Widget current =
        widget.child;

    // ===============================================
    // SCALE
    // ===============================================

    if (widget.scale) {

      current =
          ScaleTransition(

        scale:
            _scaleAnimation,

        child:
            current,
      );
    }

    // ===============================================
    // SLIDE
    // ===============================================

    if (widget.slide) {

      current =
          SlideTransition(

        position:
            _slideAnimation,

        child:
            current,
      );
    }

    // ===============================================
    // FADE
    // ===============================================

    if (widget.fade) {

      current =
          FadeTransition(

        opacity:
            _fadeAnimation,

        child:
            current,
      );
    }

    return current;
  }
}