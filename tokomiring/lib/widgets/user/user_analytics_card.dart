// =====================================================
// lib/widgets/user/user_analytics_card.dart
// COMPACT PREMIUM VERSION
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
          milliseconds: 220,
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
            isMobile
                ? double.infinity
                : 190,

        child:
            GestureDetector(

          onTap:
              widget.onTap,

          child:
              ClipRRect(

            borderRadius:
                BorderRadius.circular(
              22,
            ),

            child:
                BackdropFilter(

              filter:
                  ImageFilter.blur(

                sigmaX: 10,

                sigmaY: 10,
              ),

              child:
                  AnimatedContainer(

                duration:
                    const Duration(
                  milliseconds:
                      220,
                ),

                padding:
                    EdgeInsets.all(
                  isMobile
                      ? 14
                      : 16,
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
                                0.88,
                              ),
                            ],
                          ),

                  borderRadius:
                      BorderRadius.circular(
                    22,
                  ),

                  boxShadow: [

                    BoxShadow(

                      color:
                          widget.color
                              .withOpacity(
                        hovered
                            ? 0.24
                            : 0.14,
                      ),

                      blurRadius:
                          hovered
                              ? 18
                              : 12,

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

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    // TOP

                    Row(

                      children: [

                        Expanded(

                          child: Container(

                            padding:
                                const EdgeInsets.symmetric(

                              horizontal:
                                  9,

                              vertical:
                                  5,
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
                                14,
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
                                    Colors.white,

                                fontWeight:
                                    FontWeight.bold,

                                fontSize:
                                    9,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 8,
                        ),

                        AnimatedContainer(

                          duration:
                              const Duration(
                            milliseconds:
                                220,
                          ),

                          width:
                              hovered
                                  ? 40
                                  : 36,

                          height:
                              hovered
                                  ? 40
                                  : 36,

                          decoration:
                              BoxDecoration(

                            color:
                                Colors.white
                                    .withOpacity(
                              0.14,
                            ),

                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),
                          ),

                          child: Icon(

                            widget.icon,

                            color:
                                Colors.white,

                            size:
                                isMobile
                                    ? 16
                                    : 18,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height:
                          isMobile
                              ? 14
                              : 16,
                    ),

                    // VALUE

                    AnimatedSwitcher(

                      duration:
                          const Duration(
                        milliseconds:
                            220,
                      ),

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
                                  ? 22
                                  : 24,

                          fontWeight:
                              FontWeight
                                  .w900,

                          height: 1,
                        ),
                      ),
                    ),

                    if (widget.subtitle !=
                        null) ...[

                      const SizedBox(
                        height: 6,
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
                            0.80,
                          ),

                          fontSize:
                              isMobile
                                  ? 9
                                  : 10,

                          height: 1.35,
                        ),
                      ),
                    ],

                    SizedBox(
                      height:
                          isMobile
                              ? 12
                              : 14,
                    ),

                    // FOOTER

                    Row(

                      children: [

                        Container(

                          padding:
                              const EdgeInsets.symmetric(

                            horizontal:
                                8,

                            vertical:
                                5,
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
                              14,
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

                                size: 11,

                                color:
                                    Colors
                                        .white,
                              ),

                              SizedBox(
                                width:
                                    3,
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
                                      8,
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
                                220,
                          ),

                          width:
                              hovered
                                  ? 34
                                  : 30,

                          height:
                              hovered
                                  ? 34
                                  : 30,

                          decoration:
                              BoxDecoration(

                            color:
                                Colors.white
                                    .withOpacity(
                              0.12,
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

                            size: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}