// =====================================================
// lib/widgets/user/user_analytics_card.dart
// CLEAN MODERN RESPONSIVE VERSION
// =====================================================

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

      child: AnimatedContainer(

        duration:
            const Duration(
          milliseconds: 220,
        ),

        transform:
            Matrix4.identity()
              ..translate(
                0.0,
                hovered ? -3 : 0,
              ),

        width:
            isMobile
                ? double.infinity
                : 220,

        padding:
            EdgeInsets.all(
          isMobile ? 16 : 18,
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
                    ],
                  ),

          borderRadius:
              BorderRadius.circular(
            24,
          ),

          boxShadow: [

            BoxShadow(

              color:
                  widget.color
                      .withOpacity(
                hovered
                    ? 0.24
                    : 0.16,
              ),

              blurRadius:
                  hovered
                      ? 22
                      : 14,

              offset:
                  Offset(
                0,
                hovered
                    ? 12
                    : 7,
              ),
            ),
          ],
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            // =====================================
            // TOP
            // =====================================

            Row(

              children: [

                Expanded(

                  child: Container(

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal: 10,

                      vertical: 6,
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
                          TextOverflow.ellipsis,

                      style:
                          const TextStyle(

                        color:
                            Colors.white,

                        fontWeight:
                            FontWeight.bold,

                        fontSize: 11,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                Container(

                  padding:
                      const EdgeInsets.all(
                    10,
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

            // =====================================
            // VALUE
            // =====================================

            AnimatedSwitcher(

              duration:
                  const Duration(
                milliseconds: 220,
              ),

              child: Text(

                widget.value,

                key:
                    ValueKey(
                  widget.value,
                ),

                maxLines: 1,

                overflow:
                    TextOverflow.ellipsis,

                style:
                    TextStyle(

                  color:
                      Colors.white,

                  fontSize:
                      isMobile
                          ? 24
                          : 30,

                  fontWeight:
                      FontWeight.bold,

                  height: 1,
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
                    TextOverflow.ellipsis,

                style:
                    TextStyle(

                  color:
                      Colors.white
                          .withOpacity(
                    0.80,
                  ),

                  fontSize:
                      isMobile
                          ? 11
                          : 12,

                  height: 1.35,
                ),
              ),
            ],

            SizedBox(
              height:
                  isMobile
                      ? 14
                      : 18,
            ),

            // =====================================
            // BOTTOM
            // =====================================

            Row(

              children: [

                Container(

                  padding:
                      const EdgeInsets.symmetric(

                    horizontal: 10,

                    vertical: 6,
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
                        MainAxisSize.min,

                    children: const [

                      Icon(

                        Icons
                            .trending_up_rounded,

                        size: 14,

                        color:
                            Colors.white,
                      ),

                      SizedBox(
                        width: 5,
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
                              10,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                AnimatedContainer(

                  duration:
                      const Duration(
                    milliseconds: 220,
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
                          ? 0.18
                          : 0.12,
                    ),

                    shape:
                        BoxShape.circle,
                  ),

                  child: const Icon(

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
    );
  }
}