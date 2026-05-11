// lib/widgets/animated/slide_animation_widget.dart

import 'package:flutter/material.dart';

class SlideAnimationWidget
    extends StatefulWidget {

  final Widget child;

  final Offset beginOffset;

  final Offset endOffset;

  final Duration duration;

  final Duration delay;

  final Curve curve;

  final bool enableFade;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const SlideAnimationWidget({

    super.key,

    required this.child,

    this.beginOffset =
        const Offset(
      0,
      0.3,
    ),

    this.endOffset =
        Offset.zero,

    this.duration =
        const Duration(
      milliseconds: 700,
    ),

    this.delay =
        Duration.zero,

    this.curve =
        Curves.easeOutCubic,

    this.enableFade =
        true,
  });

  @override
  State<SlideAnimationWidget>
      createState() =>
          _SlideAnimationWidgetState();
}

class _SlideAnimationWidgetState
    extends State<
        SlideAnimationWidget>

    with
        SingleTickerProviderStateMixin {

  late AnimationController
      _controller;

  late Animation<Offset>
      _slideAnimation;

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
    // SLIDE
    // ===============================================

    _slideAnimation =
        Tween<Offset>(

      begin:
          widget.beginOffset,

      end:
          widget.endOffset,
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
        SlideTransition(

      position:
          _slideAnimation,

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