// lib/widgets/cards/dashboard_card.dart

import 'package:flutter/material.dart';

class DashboardCard
    extends StatelessWidget {

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
  Widget build(
    BuildContext context,
  ) {

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final bool mobile =
        width < 700;

    final bool tablet =
        width >= 700 &&
            width < 1100;

    final double cardPadding =

        mobile

            ? 12

            : tablet

                ? 14

                : 18;

    final double iconBox =

        mobile

            ? 40

            : tablet

                ? 48

                : 56;

    final double iconSize =

        mobile

            ? 18

            : tablet

                ? 22

                : 26;

    final double titleFont =

        mobile

            ? 9.5

            : tablet

                ? 10.5

                : 12;

    final double valueFont =

        mobile

            ? 15

            : tablet

                ? 18

                : 22;

    final double subtitleFont =

        mobile

            ? 8.5

            : tablet

                ? 9.5

                : 10.5;

    return Material(

      color:
          Colors.transparent,

      child: InkWell(

        borderRadius:
            BorderRadius.circular(
          mobile ? 14 : 18,
        ),

        onTap:
            onTap,

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
              mobile ? 14 : 18,
            ),

            boxShadow: [

              BoxShadow(

                color:
                    Colors.black
                        .withOpacity(
                  0.02,
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

          child: Row(

            children: [

              // =====================================
              // ICON
              // =====================================

              Container(

                width: iconBox,

                height: iconBox,

                decoration:
                    BoxDecoration(

                  gradient:
                      LinearGradient(

                    colors: [

                      color,

                      color.withOpacity(
                        0.78,
                      ),
                    ],

                    begin:
                        Alignment.topLeft,

                    end:
                        Alignment.bottomRight,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    mobile ? 12 : 15,
                  ),

                  boxShadow: [

                    BoxShadow(

                      color:
                          color.withOpacity(
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

                  icon,

                  size: iconSize,

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

              // =====================================
              // INFO
              // =====================================

              Expanded(

                child: Column(

                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    // =================================
                    // TITLE
                    // =================================

                    Text(

                      title,

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
                              ? 3
                              : 5,
                    ),

                    // =================================
                    // VALUE
                    // =================================

                    Flexible(

                      child:
                          FittedBox(

                        fit:
                            BoxFit.scaleDown,

                        alignment:
                            Alignment.centerLeft,

                        child: Text(

                          value,

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
                    ),

                    // =================================
                    // SUBTITLE
                    // =================================

                    if (subtitle !=
                        null) ...[

                      SizedBox(
                        height:

                            mobile
                                ? 3
                                : 5,
                      ),

                      Text(

                        subtitle!,

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
    );
  }
}