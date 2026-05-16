// =====================================================
// lib/widgets/shared/glass_container.dart
// COMPACT PREMIUM GLASS VERSION
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

    this.borderRadius = 22,

    this.blur = 12,

    this.opacity = 0.05,

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

    this.glowEffect = false,

    this.shineEffect = false,
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
                  ? 0.12
                  : 0.08,
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
          milliseconds: 200,
        ),

        curve:
            Curves.easeOut,

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

        child:
            ClipRRect(

          borderRadius:
              BorderRadius.circular(
            widget.borderRadius,
          ),

          child:
              BackdropFilter(

            filter:
                ImageFilter.blur(

              sigmaX:
                  widget.blur,

              sigmaY:
                  widget.blur,
            ),

            child:
                AnimatedContainer(

              duration:
                  const Duration(
                milliseconds:
                    200,
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
                                      0.04

                                  : widget.opacity +
                                      0.02,
                            ),

                            Colors.white
                                .withOpacity(

                              hovered

                                  ? widget.opacity

                                  : widget.opacity -
                                      0.01,
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
                                Colors.black
                                    .withOpacity(

                              hovered
                                  ? 0.07
                                  : 0.04,
                            ),

                            blurRadius:
                                hovered
                                    ? 18
                                    : 10,

                            offset:
                                Offset(
                              0,
                              hovered
                                  ? 8
                                  : 5,
                            ),
                          ),
                        ],
              ),

              child:
                  Material(

                color:
                    Colors.transparent,

                child:
                    InkWell(

                  onTap:
                      widget.onTap,

                  borderRadius:
                      BorderRadius.circular(
                    widget.borderRadius,
                  ),

                  splashColor:
                      Colors.white
                          .withOpacity(
                    0.03,
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
            ),
          ),
        ),
      ),
    );
  }
}