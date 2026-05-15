// =====================================================
// lib/widgets/cards/dashboard_card.dart
// CLEAN MODERN RESPONSIVE VERSION
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

    final cardPadding =

        mobile
            ? 12.0
            : tablet
                ? 14.0
                : 16.0;

    final iconBox =

        mobile
            ? 42.0
            : tablet
                ? 48.0
                : 54.0;

    final iconSize =

        mobile
            ? 18.0
            : tablet
                ? 22.0
                : 24.0;

    final titleFont =

        mobile
            ? 10.0
            : tablet
                ? 11.0
                : 12.0;

    final valueFont =

        mobile
            ? 16.0
            : tablet
                ? 19.0
                : 22.0;

    final subtitleFont =

        mobile
            ? 9.0
            : tablet
                ? 10.0
                : 11.0;

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
                hovered ? -2 : 0,
              ),

        child: Material(

          color:
              Colors.transparent,

          child: InkWell(

            borderRadius:
                BorderRadius.circular(
              mobile ? 16 : 20,
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
                  mobile ? 16 : 20,
                ),

                boxShadow: [

                  BoxShadow(

                    color:
                        Colors.black
                            .withOpacity(
                      hovered
                          ? 0.05
                          : 0.03,
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

              child: Row(

                children: [

                  // =================================
                  // ICON
                  // =================================

                  Container(

                    width:
                        iconBox,

                    height:
                        iconBox,

                    decoration:
                        BoxDecoration(

                      gradient:
                          LinearGradient(

                        colors: [

                          widget.color,

                          widget.color
                              .withOpacity(
                            0.80,
                          ),
                        ],

                        begin:
                            Alignment.topLeft,

                        end:
                            Alignment.bottomRight,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        mobile ? 12 : 16,
                      ),

                      boxShadow: [

                        BoxShadow(

                          color:
                              widget.color
                                  .withOpacity(
                            0.18,
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
                            : 14,
                  ),

                  // =================================
                  // INFO
                  // =================================

                  Expanded(

                    child: Column(

                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

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

                            color:
                                Colors.grey
                                    .shade600,

                            fontSize:
                                titleFont,

                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),

                        SizedBox(
                          height:
                              mobile
                                  ? 4
                                  : 5,
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
                                    ? 3
                                    : 5,
                          ),

                          Text(

                            widget.subtitle!,

                            maxLines: 1,

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                TextStyle(

                              color:
                                  Colors.grey
                                      .shade500,

                              fontSize:
                                  subtitleFont,

                              fontWeight:
                                  FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
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