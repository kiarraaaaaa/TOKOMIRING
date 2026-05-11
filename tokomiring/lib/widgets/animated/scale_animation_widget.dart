// lib/widgets/animated/scale_animation_widget.dart

import 'package:flutter/material.dart';

class ScaleAnimationWidget
    extends StatefulWidget {

  final Widget child;

  final Duration duration;

  final Duration delay;

  final Curve curve;

  final double beginScale;

  final double endScale;

  final bool enableFade;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const ScaleAnimationWidget({

    super.key,

    required this.child,

    this.duration =
        const Duration(
      milliseconds: 500,
    ),

    this.delay =
        Duration.zero,

    this.curve =
        Curves.easeOutBack,

    this.beginScale =
        0.8,

    this.endScale =
        1,

    this.enableFade =
        true,
  });

  @override
  State<ScaleAnimationWidget>
      createState() =>
          _ScaleAnimationWidgetState();
}

class _ScaleAnimationWidgetState
    extends State<
        ScaleAnimationWidget>

    with
        SingleTickerProviderStateMixin {

  late AnimationController
      _controller;

  late Animation<double>
      _scaleAnimation;

  late Animation<double>
      _fadeAnimation;

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
    // SCALE
    // ===============================================

    _scaleAnimation =
        Tween<double>(

      begin:
          widget.beginScale,

      end:
          widget.endScale,
    ).animate(

      CurvedAnimation(

        parent:
            _controller,

        curve:
            widget.curve,
      ),
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
            Curves.easeOut,
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
  // REPLAY
  // =====================================================

  Future<void> replay()
      async {

    await _controller.reverse();

    await _controller.forward();
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

    Widget content =
        ScaleTransition(

      scale:
          _scaleAnimation,

      child:
          widget.child,
    );

    // ===============================================
    // OPTIONAL FADE
    // ===============================================

    if (widget.enableFade) {

      content =
          FadeTransition(

        opacity:
            _fadeAnimation,

        child:
            content,
      );
    }

    return content;
  }
}