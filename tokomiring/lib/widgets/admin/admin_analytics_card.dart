import 'package:flutter/material.dart';

class AdminAnalyticsCard
    extends StatelessWidget {

  final String title;

  final String value;

  final IconData icon;

  final Color color;

  final String? growth;

  final bool positiveGrowth;

  const AdminAnalyticsCard({

    super.key,

    required this.title,

    required this.value,

    required this.icon,

    required this.color,

    this.growth,

    this.positiveGrowth = true,
  });

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

    return Container(

      padding:
          EdgeInsets.all(
        mobile ? 16 : 18,
      ),

      decoration:
          BoxDecoration(

        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(
          24,
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black
                    .withOpacity(
              0.03,
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

      child:
          Column(
        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          // =====================================
          // TOP
          // =====================================

          Row(
            children: [

              Container(

                width:
                    mobile
                        ? 52
                        : 60,

                height:
                    mobile
                        ? 52
                        : 60,

                decoration:
                    BoxDecoration(

                  color:
                      color.withOpacity(
                    0.12,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),

                child: Icon(

                  icon,

                  color: color,

                  size:
                      mobile
                          ? 24
                          : 28,
                ),
              ),

              const Spacer(),

              if (growth != null)

                Container(

                  padding:
                      const EdgeInsets.symmetric(

                    horizontal: 8,

                    vertical: 4,
                  ),

                  decoration:
                      BoxDecoration(

                    color:
                        positiveGrowth

                            ? Colors.green
                                .withOpacity(
                              0.1,
                            )

                            : Colors.red
                                .withOpacity(
                              0.1,
                            ),

                    borderRadius:
                        BorderRadius.circular(
                      10,
                    ),
                  ),

                  child: Row(

                    mainAxisSize:
                        MainAxisSize.min,

                    children: [

                      Icon(

                        positiveGrowth

                            ? Icons
                                .trending_up

                            : Icons
                                .trending_down,

                        size: 13,

                        color:

                            positiveGrowth

                                ? Colors.green

                                : Colors.red,
                      ),

                      const SizedBox(
                        width: 3,
                      ),

                      Text(

                        growth!,

                        style:
                            TextStyle(

                          fontSize: 10,

                          fontWeight:
                              FontWeight.bold,

                          color:

                              positiveGrowth

                                  ? Colors.green

                                  : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          const Spacer(),

          // =====================================
          // VALUE
          // =====================================

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

                      mobile
                          ? 24
                          : 30,

                  fontWeight:
                      FontWeight.bold,

                  color:
                      Colors.black,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 6,
          ),

          // =====================================
          // TITLE
          // =====================================

          Text(

            title,

            maxLines: 1,

            overflow:
                TextOverflow
                    .ellipsis,

            style:
                TextStyle(

              fontSize:
                  mobile
                      ? 12
                      : 14,

              color:
                  Colors.grey
                      .shade700,

              fontWeight:
                  FontWeight.w500,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          // =====================================
          // BAR
          // =====================================

          Container(

            height: 5,

            width:
                mobile
                    ? 70
                    : 90,

            decoration:
                BoxDecoration(

              color:
                  color.withOpacity(
                0.25,
              ),

              borderRadius:
                  BorderRadius.circular(
                100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}