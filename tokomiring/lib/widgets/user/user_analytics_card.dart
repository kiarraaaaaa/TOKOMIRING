// lib/widgets/user/user_analytics_card.dart

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
          AnimatedScale(

        duration:
            const Duration(
          milliseconds: 220,
        ),

        scale:
            hovered
                ? 1.02
                : 1,

        child:
            InkWell(

          borderRadius:
              BorderRadius.circular(
            28,
          ),

          onTap:
              widget.onTap,

          child:
              AnimatedContainer(

            duration:
                const Duration(
              milliseconds:
                  220,
            ),

            width:
                isMobile
                    ? double.infinity
                    : 240,

            padding:
                EdgeInsets.all(
              isMobile
                  ? 18
                  : 22,
            ),

            decoration:
                BoxDecoration(

              gradient:

                  widget.gradient ??

                      LinearGradient(

                        begin:
                            Alignment
                                .topLeft,

                        end:
                            Alignment
                                .bottomRight,

                        colors: [

                          widget.color,

                          widget.color
                              .withOpacity(
                            0.78,
                          ),
                        ],
                      ),

              borderRadius:
                  BorderRadius.circular(
                28,
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
                          ? 28
                          : 18,

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

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                // =========================================
                // TOP
                // =========================================

                Row(

                  children: [

                    Expanded(

                      child: Container(

                        padding:
                            const EdgeInsets.symmetric(

                          horizontal:
                              12,

                          vertical:
                              8,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.white
                                  .withOpacity(
                            0.16,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            30,
                          ),
                        ),

                        child: Text(

                          widget.title,

                          overflow:
                              TextOverflow
                                  .ellipsis,

                          maxLines: 1,

                          style:
                              const TextStyle(

                            color:
                                Colors.white,

                            fontWeight:
                                FontWeight.bold,

                            fontSize:
                                12,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 12,
                    ),

                    AnimatedContainer(

                      duration:
                          const Duration(
                        milliseconds:
                            220,
                      ),

                      padding:
                          const EdgeInsets.all(
                        14,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.white
                                .withOpacity(
                          hovered
                              ? 0.22
                              : 0.14,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),

                        border: Border.all(

                          color:
                              Colors.white
                                  .withOpacity(
                            0.12,
                          ),
                        ),
                      ),

                      child: Icon(

                        widget.icon,

                        color:
                            Colors.white,

                        size:
                            isMobile
                                ? 22
                                : 26,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height:
                      isMobile
                          ? 22
                          : 28,
                ),

                // =========================================
                // VALUE
                // =========================================

                AnimatedSwitcher(

                  duration:
                      const Duration(
                    milliseconds:
                        220,
                  ),

                  child: Text(

                    widget.value,

                    key: ValueKey(
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
                              ? 28
                              : 34,

                      fontWeight:
                          FontWeight.bold,

                      height: 1,
                    ),
                  ),
                ),

                if (widget.subtitle !=
                    null) ...[

                  const SizedBox(
                    height: 12,
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
                              ? 12
                              : 13,

                      height: 1.4,
                    ),
                  ),
                ],

                SizedBox(
                  height:
                      isMobile
                          ? 18
                          : 24,
                ),

                // =========================================
                // BOTTOM
                // =========================================

                Row(

                  children: [

                    Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal:
                            12,

                        vertical:
                            8,
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
                          30,
                        ),
                      ),

                      child: Row(

                        mainAxisSize:
                            MainAxisSize.min,

                        children: const [

                          Icon(

                            Icons
                                .trending_up_rounded,

                            size: 16,

                            color:
                                Colors.white,
                          ),

                          SizedBox(
                            width: 6,
                          ),

                          Text(

                            'Realtime',

                            style:
                                TextStyle(

                              color:
                                  Colors.white,

                              fontWeight:
                                  FontWeight.bold,

                              fontSize:
                                  11,
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
                              ? 44
                              : 38,

                      height:
                          hovered
                              ? 44
                              : 38,

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.white
                                .withOpacity(
                          hovered
                              ? 0.22
                              : 0.14,
                        ),

                        shape:
                            BoxShape.circle,
                      ),

                      child: const Icon(

                        Icons
                            .arrow_forward_rounded,

                        color:
                            Colors.white,

                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}