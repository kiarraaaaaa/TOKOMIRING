// lib/widgets/animated/fade_animation_widget.dart

import 'package:flutter/material.dart';

class FadeAnimationWidget
    extends StatefulWidget {

  final Widget child;

  final Duration duration;

  final Duration delay;

  final Curve curve;

  final double beginOffsetY;

  final bool enableSlide;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const FadeAnimationWidget({

    super.key,

    required this.child,

    this.duration =
        const Duration(
      milliseconds: 600,
    ),

    this.delay =
        Duration.zero,

    this.curve =
        Curves.easeOut,

    this.beginOffsetY =
        20,

    this.enableSlide =
        true,
  });

  @override
  State<FadeAnimationWidget>
      createState() =>
          _FadeAnimationWidgetState();
}

class _FadeAnimationWidgetState
    extends State<FadeAnimationWidget>

    with
        SingleTickerProviderStateMixin {

  late AnimationController
      _controller;

  late Animation<double>
      _fadeAnimation;

  late Animation<Offset>
      _slideAnimation;

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

    // ===============================================
    // FADE
    // ===============================================

    _fadeAnimation =
        Tween<double>(

      begin: 0,

      end: 1,
    ).animate(

      CurvedAnimation(

        parent:
            _controller,

        curve:
            widget.curve,
      ),
    );

    // ===============================================
    // SLIDE
    // ===============================================

    _slideAnimation =
        Tween<Offset>(

      begin:
          Offset(
        0,
        widget.beginOffsetY / 100,
      ),

      end:
          Offset.zero,
    ).animate(

      CurvedAnimation(

        parent:
            _controller,

        curve:
            Curves.easeOutCubic,
      ),
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

    if (mounted) {

      _controller.forward();
    }
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

    return FadeTransition(

      opacity:
          _fadeAnimation,

      child:
          widget.enableSlide

              ? SlideTransition(

                  position:
                      _slideAnimation,

                  child:
                      widget.child,
                )

              : widget.child,
    );
  }
}