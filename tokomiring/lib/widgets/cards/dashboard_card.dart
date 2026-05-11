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

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

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

    return Material(

      color:
          Colors.transparent,

      child: InkWell(

        borderRadius:
            BorderRadius.circular(
          28,
        ),

        onTap:
            onTap,

        child: Container(

          padding:
              const EdgeInsets.all(
            22,
          ),

          decoration:
              BoxDecoration(

            color:
                Colors.white,

            borderRadius:
                BorderRadius.circular(
              28,
            ),

            boxShadow: [

              BoxShadow(

                color:
                    Colors.black
                        .withOpacity(
                  0.05,
                ),

                blurRadius:
                    20,

                offset:
                    const Offset(
                  0,
                  10,
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

                width: 68,

                height: 68,

                decoration:
                    BoxDecoration(

                  gradient:
                      LinearGradient(

                    colors: [

                      color,

                      color.withOpacity(
                        0.75,
                      ),
                    ],

                    begin:
                        Alignment
                            .topLeft,

                    end:
                        Alignment
                            .bottomRight,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    22,
                  ),

                  boxShadow: [

                    BoxShadow(

                      color:
                          color.withOpacity(
                        0.25,
                      ),

                      blurRadius:
                          18,

                      offset:
                          const Offset(
                        0,
                        8,
                      ),
                    ),
                  ],
                ),

                child: Icon(

                  icon,

                  size: 32,

                  color:
                      Colors.white,
                ),
              ),

              const SizedBox(
                width: 20,
              ),

              // =====================================
              // INFO
              // =====================================

              Expanded(

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,

                  children: [

                    // =================================
                    // TITLE
                    // =================================

                    Text(

                      title,

                      style:
                          TextStyle(

                        color:
                            Colors.grey
                                .shade600,

                        fontSize: 14,

                        fontWeight:
                            FontWeight.w500,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // =================================
                    // VALUE
                    // =================================

                    Text(

                      value,

                      maxLines: 1,

                      overflow:
                          TextOverflow
                              .ellipsis,

                      style:
                          const TextStyle(

                        fontSize: 30,

                        fontWeight:
                            FontWeight.bold,

                        height: 1,
                      ),
                    ),

                    // =================================
                    // SUBTITLE
                    // =================================

                    if (subtitle !=
                        null) ...[

                      const SizedBox(
                        height: 8,
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

                          fontSize: 13,
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