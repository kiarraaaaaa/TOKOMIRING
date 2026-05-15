// =====================================================
// lib/widgets/user/user_analytics_card.dart
// ULTRA AESTHETIC GLASSMORPHISM PREMIUM VERSION
// =====================================================

import 'dart:ui';

import 'package:flutter/material.dart';

class UserAnalyticsCard
    extends StatefulWidget {

  final String title;

  final String value;

  final String? subtitle;

  final IconData icon;

  final Color color;

  final Gradient? gradient;

  final VoidCallback?
      onTap;

  const UserAnalyticsCard({

    super.key,

    required this.title,

    required this.value,

    required this.icon,

    required this.color,

    this.subtitle,

    this.gradient,

    this.onTap,
  });

  @override
  State<UserAnalyticsCard>
      createState() =>
          _UserAnalyticsCardState();
}

class _UserAnalyticsCardState
    extends State<UserAnalyticsCard> {

  bool hovered = false;

  @override
  Widget build(
    BuildContext context,
  ) {

    final screenWidth =
        MediaQuery.of(context)
            .size
            .width;

    final isMobile =
        screenWidth < 700;

    return MouseRegion(

      onEnter: (_) {

        setState(() {

          hovered = true;
        });
      },

      onExit: (_) {

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
            isMobile
                ? double.infinity
                : 210,

        child: GestureDetector(

          onTap:
              widget.onTap,

          child: Stack(

            children: [

              // =====================================
              // GLOW EFFECT
              // =====================================

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
                          : 0.75,

                  child: Container(

                    decoration:
                        BoxDecoration(

                      borderRadius:
                          BorderRadius.circular(
                        28,
                      ),

                      gradient:
                          RadialGradient(

                        radius: 1.1,

                        colors: [

                          widget.color
                              .withOpacity(
                            0.28,
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
              // MAIN CARD
              // =====================================

              ClipRRect(

                borderRadius:
                    BorderRadius.circular(
                  28,
                ),

                child: BackdropFilter(

                  filter:
                      ImageFilter.blur(

                    sigmaX: 12,

                    sigmaY: 12,
                  ),

                  child:
                      AnimatedContainer(

                    duration:
                        const Duration(
                      milliseconds:
                          260,
                    ),

                    padding:
                        EdgeInsets.all(
                      isMobile
                          ? 16
                          : 18,
                    ),

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

                                  widget.color,

                                  widget.color
                                      .withOpacity(
                                    0.82,
                                  ),

                                  widget.color
                                      .withOpacity(
                                    0.72,
                                  ),
                                ],
                              ),

                      borderRadius:
                          BorderRadius.circular(
                        28,
                      ),

                      border: Border.all(

                        color:
                            Colors.white
                                .withOpacity(
                          0.16,
                        ),

                        width: 1,
                      ),

                      boxShadow: [

                        BoxShadow(

                          color:
                              widget.color
                                  .withOpacity(
                            hovered
                                ? 0.30
                                : 0.18,
                          ),

                          blurRadius:
                              hovered
                                  ? 30
                                  : 18,

                          offset:
                              Offset(
                            0,
                            hovered
                                ? 16
                                : 8,
                          ),
                        ),
                      ],
                    ),

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        // =================================
                        // TOP
                        // =================================

                        Row(

                          children: [

                            Expanded(

                              child: Container(

                                padding:
                                    const EdgeInsets.symmetric(

                                  horizontal:
                                      10,

                                  vertical:
                                      6,
                                ),

                                decoration:
                                    BoxDecoration(

                                  color:
                                      Colors.white
                                          .withOpacity(
                                    0.14,
                                  ),

                                  borderRadius:
                                      BorderRadius.circular(
                                    18,
                                  ),
                                ),

                                child: Text(

                                  widget.title,

                                  maxLines: 1,

                                  overflow:
                                      TextOverflow
                                          .ellipsis,

                                  style:
                                      const TextStyle(

                                    color:
                                        Colors
                                            .white,

                                    fontWeight:
                                        FontWeight.bold,

                                    letterSpacing:
                                        0.3,

                                    fontSize:
                                        10,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            AnimatedContainer(

                              duration:
                                  const Duration(
                                milliseconds:
                                    260,
                              ),

                              width:
                                  hovered
                                      ? 46
                                      : 42,

                              height:
                                  hovered
                                      ? 46
                                      : 42,

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.white
                                        .withOpacity(
                                  hovered
                                      ? 0.20
                                      : 0.14,
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                  16,
                                ),
                              ),

                              child: Icon(

                                widget.icon,

                                color:
                                    Colors.white,

                                size:
                                    isMobile
                                        ? 18
                                        : 20,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height:
                              isMobile
                                  ? 18
                                  : 22,
                        ),

                        // =================================
                        // VALUE
                        // =================================

                        AnimatedSwitcher(

                          duration:
                              const Duration(
                            milliseconds:
                                260,
                          ),

                          child: ShaderMask(

                            shaderCallback:
                                (bounds) {

                              return LinearGradient(

                                colors: [

                                  Colors.white,

                                  Colors.white
                                      .withOpacity(
                                    0.88,
                                  ),
                                ],
                              ).createShader(
                                bounds,
                              );
                            },

                            child: Text(

                              widget.value,

                              key:
                                  ValueKey(
                                widget.value,
                              ),

                              maxLines: 1,

                              overflow:
                                  TextOverflow
                                      .ellipsis,

                              style:
                                  TextStyle(

                                color:
                                    Colors.white,

                                fontSize:

                                    isMobile
                                        ? 24
                                        : 28,

                                fontWeight:
                                    FontWeight
                                        .w900,

                                height: 1,
                              ),
                            ),
                          ),
                        ),

                        if (widget.subtitle !=
                            null) ...[

                          const SizedBox(
                            height: 8,
                          ),

                          Text(

                            widget.subtitle!,

                            maxLines: 2,

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                TextStyle(

                              color:
                                  Colors.white
                                      .withOpacity(
                                0.82,
                              ),

                              fontSize:
                                  isMobile
                                      ? 10
                                      : 11,

                              height: 1.4,
                            ),
                          ),
                        ],

                        SizedBox(
                          height:
                              isMobile
                                  ? 16
                                  : 20,
                        ),

                        // =================================
                        // FOOTER
                        // =================================

                        Row(

                          children: [

                            Container(

                              padding:
                                  const EdgeInsets.symmetric(

                                horizontal:
                                    10,

                                vertical:
                                    6,
                              ),

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.white
                                        .withOpacity(
                                  0.12,
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                  18,
                                ),
                              ),

                              child: Row(

                                mainAxisSize:
                                    MainAxisSize
                                        .min,

                                children: const [

                                  Icon(

                                    Icons
                                        .trending_up_rounded,

                                    size: 13,

                                    color:
                                        Colors
                                            .white,
                                  ),

                                  SizedBox(
                                    width:
                                        4,
                                  ),

                                  Text(

                                    'Live',

                                    style:
                                        TextStyle(

                                      color:
                                          Colors
                                              .white,

                                      fontWeight:
                                          FontWeight
                                              .bold,

                                      fontSize:
                                          9,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Spacer(),

                            AnimatedContainer(

                              duration:
                                  const Duration(
                                milliseconds:
                                    260,
                              ),

                              width:
                                  hovered
                                      ? 40
                                      : 34,

                              height:
                                  hovered
                                      ? 40
                                      : 34,

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.white
                                        .withOpacity(
                                  hovered
                                      ? 0.20
                                      : 0.12,
                                ),

                                shape:
                                    BoxShape.circle,
                              ),

                              child:
                                  const Icon(

                                Icons
                                    .arrow_forward_rounded,

                                color:
                                    Colors.white,

                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}