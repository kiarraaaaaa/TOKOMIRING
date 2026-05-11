// lib/widgets/animated/hover_animation_widget.dart

import 'package:flutter/material.dart';

class HoverAnimationWidget
    extends StatefulWidget {

  final Widget child;

  final double translateY;

  final double scale;

  final Duration duration;

  final Curve curve;

  final bool enableShadow;

  final VoidCallback? onTap;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const HoverAnimationWidget({

    super.key,

    required this.child,

    this.translateY =
        -8,

    this.scale =
        1.02,

    this.duration =
        const Duration(
      milliseconds: 220,
    ),

    this.curve =
        Curves.easeOut,

    this.enableShadow =
        false,

    this.onTap,
  });

  @override
  State<HoverAnimationWidget>
      createState() =>
          _HoverAnimationWidgetState();
}

class _HoverAnimationWidgetState
    extends State<
        HoverAnimationWidget> {

  bool isHovered =
      false;

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(
    BuildContext context,
  ) {

    return MouseRegion(

      cursor:
          SystemMouseCursors.click,

      onEnter: (_) {

        setState(() {

          isHovered = true;
        });
      },

      onExit: (_) {

        setState(() {

          isHovered = false;
        });
      },

      child: GestureDetector(

        onTap:
            widget.onTap,

        child:
            AnimatedContainer(

          duration:
              widget.duration,

          curve:
              widget.curve,

          transform:
              Matrix4.identity()

                ..translate(

                  0.0,

                  isHovered

                      ? widget
                          .translateY

                      : 0.0,
                )

                ..scale(

                  isHovered

                      ? widget
                          .scale

                      : 1.0,
                ),

          decoration:
              widget.enableShadow

                  ? BoxDecoration(

                      boxShadow: [

                        BoxShadow(

                          color:
                              Colors.black
                                  .withOpacity(
                            isHovered
                                ? 0.12
                                : 0.05,
                          ),

                          blurRadius:
                              isHovered
                                  ? 25
                                  : 10,

                          offset:
                              Offset(

                            0,

                            isHovered
                                ? 12
                                : 4,
                          ),
                        ),
                      ],
                    )

                  : null,

          child:
              widget.child,
        ),
      ),
    );
  }
}