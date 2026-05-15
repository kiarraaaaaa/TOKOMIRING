// =====================================================
// lib/widgets/shared/glass_container.dart
// ULTRA AESTHETIC PREMIUM GLASSMORPHISM VERSION
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

  final bool glowEffect;

  final bool shineEffect;

  const GlassContainer({

    super.key,

    required this.child,

    this.borderRadius = 28,

    this.blur = 18,

    this.opacity = 0.08,

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

    this.glowEffect = true,

    this.shineEffect = true,
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
              hovered
                  ? 0.18
                  : 0.10,
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

      child:
          AnimatedContainer(

        duration:
            const Duration(
          milliseconds: 260,
        ),

        curve:
            Curves.easeOutCubic,

        transform:
            Matrix4.identity()
              ..translate(
                0.0,
                hovered ? -4 : 0,
              ),

        width:
            widget.width,

        height:
            widget.height,

        margin:
            widget.margin,

        child: Stack(

          children: [

            // =====================================
            // GLOW EFFECT
            // =====================================

            if (widget.glowEffect)

              Positioned.fill(

                child:
                    AnimatedOpacity(

                  duration:
                      const Duration(
                    milliseconds:
                        260,
                  ),

                  opacity:
                      hovered
                          ? 1
                          : 0.7,

                  child: Container(

                    decoration:
                        BoxDecoration(

                      borderRadius:
                          BorderRadius.circular(
                        widget.borderRadius,
                      ),

                      gradient:
                          RadialGradient(

                        radius: 1.25,

                        colors: [

                          Colors.white
                              .withOpacity(
                            hovered
                                ? 0.12
                                : 0.06,
                          ),

                          Colors
                              .transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            // =====================================
            // MAIN GLASS
            // =====================================

            ClipRRect(

              borderRadius:
                  BorderRadius.circular(
                widget.borderRadius,
              ),

              child: BackdropFilter(

                filter:
                    ImageFilter.blur(

                  sigmaX:
                      hovered

                          ? widget.blur +
                              2

                          : widget.blur,

                  sigmaY:
                      hovered

                          ? widget.blur +
                              2

                          : widget.blur,
                ),

                child:
                    AnimatedContainer(

                  duration:
                      const Duration(
                    milliseconds:
                        260,
                  ),

                  decoration:
                      BoxDecoration(

                    borderRadius:
                        BorderRadius.circular(
                      widget.borderRadius,
                    ),

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

                                  hovered

                                      ? widget.opacity +
                                          0.12

                                      : widget.opacity +
                                          0.08,
                                ),

                                Colors.white
                                    .withOpacity(

                                  hovered

                                      ? widget.opacity +
                                          0.04

                                      : widget.opacity,
                                ),
                              ],
                            ),

                    border: Border.all(

                      color:
                          borderColor,

                      width:
                          widget.borderWidth,
                    ),

                    boxShadow:

                        widget.boxShadow ??

                            [

                              BoxShadow(

                                color:
                                    Colors.white
                                        .withOpacity(
                                  hovered
                                      ? 0.08
                                      : 0.03,
                                ),

                                blurRadius:
                                    hovered
                                        ? 24
                                        : 12,

                                spreadRadius:
                                    hovered
                                        ? 1
                                        : 0,
                              ),

                              BoxShadow(

                                color:
                                    Colors.black
                                        .withOpacity(

                                  hovered
                                      ? 0.10
                                      : 0.05,
                                ),

                                blurRadius:
                                    hovered
                                        ? 26
                                        : 16,

                                offset:
                                    Offset(
                                  0,
                                  hovered
                                      ? 14
                                      : 8,
                                ),
                              ),
                            ],
                  ),

                  child: Stack(

                    children: [

                      // ===============================
                      // SHINE EFFECT
                      // ===============================

                      if (widget.shineEffect)

                        Positioned(

                          top: -40,

                          left: -30,

                          child:
                              AnimatedContainer(

                            duration:
                                const Duration(
                              milliseconds:
                                  260,
                            ),

                            width:
                                hovered
                                    ? 180
                                    : 140,

                            height:
                                hovered
                                    ? 180
                                    : 140,

                            decoration:
                                BoxDecoration(

                              shape:
                                  BoxShape.circle,

                              gradient:
                                  RadialGradient(

                                colors: [

                                  Colors.white
                                      .withOpacity(
                                    hovered
                                        ? 0.12
                                        : 0.06,
                                  ),

                                  Colors
                                      .transparent,
                                ],
                              ),
                            ),
                          ),
                        ),

                      // ===============================
                      // CONTENT
                      // ===============================

                      Material(

                        color:
                            Colors.transparent,

                        child: InkWell(

                          onTap:
                              widget.onTap,

                          borderRadius:
                              BorderRadius.circular(
                            widget.borderRadius,
                          ),

                          splashColor:
                              Colors.white
                                  .withOpacity(
                            0.04,
                          ),

                          highlightColor:
                              Colors.transparent,

                          child: Container(

                            width:
                                widget.width,

                            height:
                                widget.height,

                            padding:
                                widget.padding,

                            child:
                                widget.child,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}