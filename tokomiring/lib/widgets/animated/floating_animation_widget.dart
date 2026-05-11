// lib/widgets/animated/floating_animation_widget.dart

import 'package:flutter/material.dart';

class FloatingAnimationWidget
    extends StatefulWidget {

  final Widget child;

  final Duration duration;

  final double floatingValue;

  final Curve curve;

  final bool autoStart;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const FloatingAnimationWidget({

    super.key,

    required this.child,

    this.duration =
        const Duration(
      seconds: 2,
    ),

    this.floatingValue =
        8,

    this.curve =
        Curves.easeInOut,

    this.autoStart =
        true,
  });

  @override
  State<FloatingAnimationWidget>
      createState() =>
          _FloatingAnimationWidgetState();
}

class _FloatingAnimationWidgetState
    extends State<
        FloatingAnimationWidget>

    with
        SingleTickerProviderStateMixin {

  late final AnimationController
      _controller;

  late final Animation<double>
      _animation;

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

    _animation =
        Tween<double>(

      begin: 0,

      end:
          widget.floatingValue,
    ).animate(

      CurvedAnimation(

        parent:
            _controller,

        curve:
            widget.curve,
      ),
    );

    // ===============================================
    // START ANIMATION
    // ===============================================

    if (widget.autoStart) {

      _controller.repeat(
        reverse: true,
      );
    }
  }

  // =====================================================
  // CONTROL
  // =====================================================

  void start() {

    if (!_controller
        .isAnimating) {

      _controller.repeat(
        reverse: true,
      );
    }
  }

  void stop() {

    _controller.stop();
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

    return AnimatedBuilder(

      animation:
          _animation,

      builder: (
        context,
        child,
      ) {

        return Transform.translate(

          offset:
              Offset(
            0,
            -_animation.value,
          ),

          child:
              child,
        );
      },

      child:
          widget.child,
    );
  }
}