// =====================================================
// lib/widgets/shared/glass_container.dart
// CLEAN MODERN RESPONSIVE VERSION
// =====================================================

import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer
    extends StatefulWidget {

  final Widget child;

  final double borderRadius;

  final double blur;

  final double opacity;

  final EdgeInsetsGeometry?
      padding;

  final EdgeInsetsGeometry?
      margin;

  final Gradient? gradient;

  final Color? borderColor;

  final double borderWidth;

  final double? width;

  final double? height;

  final List<BoxShadow>?
      boxShadow;

  final VoidCallback?
      onTap;

  final bool animated;

  const GlassContainer({

    super.key,

    required this.child,

    this.borderRadius = 24,

    this.blur = 14,

    this.opacity = 0.10,

    this.padding,

    this.margin,

    this.gradient,

    this.borderColor,

    this.borderWidth = 1,

    this.width,

    this.height,

    this.boxShadow,

    this.onTap,

    this.animated = true,
  });

  @override
  State<GlassContainer>
      createState() =>
          _GlassContainerState();
}

class _GlassContainerState
    extends State<GlassContainer> {

  bool hovered = false;

  @override
  Widget build(
    BuildContext context,
  ) {

    final borderColor =
        widget.borderColor ??

            Colors.white.withOpacity(
              0.12,
            );

    return MouseRegion(

      onEnter: (_) {

        if (!widget.animated) {
          return;
        }

        setState(() {

          hovered = true;
        });
      },

      onExit: (_) {

        if (!widget.animated) {
          return;
        }

        setState(() {

          hovered = false;
        });
      },

      child: AnimatedContainer(

        duration:
            const Duration(
          milliseconds: 220,
        ),

        transform:
            Matrix4.identity()
              ..translate(
                0.0,
                hovered ? -2 : 0,
              ),

        width:
            widget.width,

        height:
            widget.height,

        margin:
            widget.margin,

        decoration:
            BoxDecoration(

          borderRadius:
              BorderRadius.circular(
            widget.borderRadius,
          ),

          boxShadow:

              widget.boxShadow ??

                  [

                    BoxShadow(

                      color:
                          Colors.black
                              .withOpacity(

                        hovered
                            ? 0.08
                            : 0.04,
                      ),

                      blurRadius:
                          hovered
                              ? 22
                              : 14,

                      offset:
                          Offset(
                        0,
                        hovered
                            ? 10
                            : 6,
                      ),
                    ),
                  ],
        ),

        child: ClipRRect(

          borderRadius:
              BorderRadius.circular(
            widget.borderRadius,
          ),

          child: BackdropFilter(

            filter: ImageFilter.blur(

              sigmaX:
                  widget.blur,

              sigmaY:
                  widget.blur,
            ),

            child: Material(

              color:
                  Colors.transparent,

              child: InkWell(

                onTap:
                    widget.onTap,

                child: Container(

                  padding:
                      widget.padding,

                  decoration:
                      BoxDecoration(

                    gradient:

                        widget.gradient ??

                            LinearGradient(

                              begin:
                                  Alignment.topLeft,

                              end:
                                  Alignment.bottomRight,

                              colors: [

                                Colors.white
                                    .withOpacity(

                                  widget.opacity +
                                      0.05,
                                ),

                                Colors.white
                                    .withOpacity(

                                  widget.opacity,
                                ),
                              ],
                            ),

                    borderRadius:
                        BorderRadius.circular(
                      widget.borderRadius,
                    ),

                    border: Border.all(

                      color:
                          borderColor,

                      width:
                          widget.borderWidth,
                    ),
                  ),

                  child:
                      widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}