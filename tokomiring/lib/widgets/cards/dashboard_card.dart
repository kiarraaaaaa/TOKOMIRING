// =====================================================
// lib/widgets/cards/dashboard_card.dart
// ULTRA COMPACT PREMIUM ANALYTICS CARD
// =====================================================

import 'package:flutter/material.dart';

class DashboardCard
    extends StatefulWidget {

  final String title;

  final String value;

  final IconData icon;

  final Color color;

  final String? subtitle;

  final VoidCallback? onTap;

  const DashboardCard({

    super.key,

    required this.title,

    required this.value,

    required this.icon,

    required this.color,

    this.subtitle,

    this.onTap,
  });

  @override
  State<DashboardCard>
      createState() =>
          _DashboardCardState();
}

class _DashboardCardState
    extends State<DashboardCard> {

  bool hovered = false;

  @override
  Widget build(
    BuildContext context,
  ) {

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final mobile =
        width < 700;

    final tablet =
        width >= 700 &&
            width < 1100;

    // =====================================
    // RESPONSIVE SIZE
    // =====================================

    final cardPadding =

        mobile
            ? 10.0
            : tablet
                ? 12.0
                : 14.0;

    final iconBox =

        mobile
            ? 36.0
            : tablet
                ? 40.0
                : 44.0;

    final iconSize =

        mobile
            ? 16.0
            : tablet
                ? 18.0
                : 20.0;

    final titleFont =

        mobile
            ? 9.0
            : tablet
                ? 10.0
                : 11.0;

    final valueFont =

        mobile
            ? 15.0
            : tablet
                ? 17.0
                : 19.0;

    final subtitleFont =

        mobile
            ? 8.0
            : tablet
                ? 9.0
                : 10.0;

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

        transform:
            Matrix4.identity()
              ..translate(
                0.0,
                hovered ? -2 : 0,
              ),

        child: Material(

          color:
              Colors.transparent,

          child: InkWell(

            borderRadius:
                BorderRadius.circular(
              18,
            ),

            onTap:
                widget.onTap,

            child: Container(

              padding:
                  EdgeInsets.all(
                cardPadding,
              ),

              decoration:
                  BoxDecoration(

                color:
                    Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  18,
                ),

                border: Border.all(

                  color:

                      hovered

                          ? widget.color
                              .withOpacity(
                            0.10,
                          )

                          : Colors
                              .grey
                              .shade100,
                ),

                boxShadow: [

                  BoxShadow(

                    color:
                        Colors.black
                            .withOpacity(
                      hovered
                          ? 0.05
                          : 0.025,
                    ),

                    blurRadius:
                        hovered
                            ? 18
                            : 10,

                    offset:
                        Offset(
                      0,
                      hovered
                          ? 10
                          : 5,
                    ),
                  ),
                ],
              ),

              child: Row(

                children: [

                  // =================================
                  // ICON
                  // =================================

                  AnimatedContainer(

                    duration:
                        const Duration(
                      milliseconds:
                          220,
                    ),

                    width:
                        iconBox,

                    height:
                        iconBox,

                    decoration:
                        BoxDecoration(

                      gradient:
                          LinearGradient(

                        begin:
                            Alignment.topLeft,

                        end:
                            Alignment.bottomRight,

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
                        14,
                      ),

                      boxShadow: [

                        BoxShadow(

                          color:
                              widget.color
                                  .withOpacity(
                            0.16,
                          ),

                          blurRadius: 10,

                          offset:
                              const Offset(
                            0,
                            4,
                          ),
                        ),
                      ],
                    ),

                    child: Icon(

                      widget.icon,

                      size:
                          iconSize,

                      color:
                          Colors.white,
                    ),
                  ),

                  SizedBox(
                    width:
                        mobile
                            ? 10
                            : 12,
                  ),

                  // =================================
                  // CONTENT
                  // =================================

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,

                      children: [

                        // =============================
                        // TITLE
                        // =============================

                        Text(

                          widget.title,

                          maxLines: 1,

                          overflow:
                              TextOverflow
                                  .ellipsis,

                          style:
                              TextStyle(

                            fontSize:
                                titleFont,

                            fontWeight:
                                FontWeight.w600,

                            color:
                                Colors.grey
                                    .shade500,
                          ),
                        ),

                        SizedBox(
                          height:
                              mobile
                                  ? 3
                                  : 4,
                        ),

                        // =============================
                        // VALUE
                        // =============================

                        FittedBox(

                          fit:
                              BoxFit.scaleDown,

                          alignment:
                              Alignment.centerLeft,

                          child: Text(

                            widget.value,

                            maxLines: 1,

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                TextStyle(

                              fontSize:
                                  valueFont,

                              fontWeight:
                                  FontWeight.bold,

                              height: 1,
                            ),
                          ),
                        ),

                        // =============================
                        // SUBTITLE
                        // =============================

                        if (widget.subtitle !=
                            null) ...[

                          SizedBox(
                            height:
                                mobile
                                    ? 2
                                    : 4,
                          ),

                          Text(

                            widget.subtitle!,

                            maxLines: 1,

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                TextStyle(

                              fontSize:
                                  subtitleFont,

                              color:
                                  Colors.grey
                                      .shade500,

                              fontWeight:
                                  FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // =================================
                  // DOT
                  // =================================

                  Container(

                    width: 8,

                    height: 8,

                    decoration:
                        BoxDecoration(

                      color:
                          widget.color,

                      shape:
                          BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}