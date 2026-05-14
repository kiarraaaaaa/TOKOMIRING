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

                : 16;

    final double iconBox =

        mobile

            ? 34

            : tablet

                ? 38

                : 42;

    final double iconSize =

        mobile

            ? 16

            : tablet

                ? 18

                : 20;

    final double valueFont =

        mobile

            ? 15

            : tablet

                ? 17

                : 20;

    final double titleFont =

        mobile

            ? 9

            : tablet

                ? 10

                : 11;

    return Container(

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
          mobile ? 14 : 16,
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black
                    .withOpacity(
              0.02,
            ),

            blurRadius: 8,

            offset:
                const Offset(
              0,
              3,
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

              Container(

                width: iconBox,

                height: iconBox,

                decoration:
                    BoxDecoration(

                  color:
                      color.withOpacity(
                    0.12,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    mobile
                        ? 10
                        : 12,
                  ),
                ),

                child: Icon(

                  icon,

                  color: color,

                  size: iconSize,
                ),
              ),

              const Spacer(),

              if (growth != null)

                Flexible(

                  child: Container(

                    padding:
                        EdgeInsets.symmetric(

                      horizontal:
                          mobile
                              ? 6
                              : 8,

                      vertical:
                          mobile
                              ? 3
                              : 4,
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
                        8,
                      ),
                    ),

                    child: Row(

                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        Icon(

                          positiveGrowth

                              ? Icons
                                  .trending_up_rounded

                              : Icons
                                  .trending_down_rounded,

                          size:
                              mobile
                                  ? 10
                                  : 12,

                          color:

                              positiveGrowth

                                  ? Colors.green

                                  : Colors.red,
                        ),

                        const SizedBox(
                          width: 3,
                        ),

                        Flexible(
                          child: Text(

                            growth!,

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            maxLines:
                                1,

                            style:
                                TextStyle(

                              fontSize:

                                  mobile
                                      ? 8
                                      : 9,

                              fontWeight:
                                  FontWeight.bold,

                              color:

                                  positiveGrowth

                                      ? Colors.green

                                      : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                      valueFont,

                  fontWeight:
                      FontWeight.bold,

                  color:
                      Colors.black,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 2,
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
                  titleFont,

              color:
                  Colors.grey
                      .shade700,

              fontWeight:
                  FontWeight.w500,
            ),
          ),

          SizedBox(
            height:
                mobile
                    ? 6
                    : 8,
          ),

          // =====================================
          // BOTTOM BAR
          // =====================================

          Container(

            height:
                mobile
                    ? 4
                    : 5,

            width:

                mobile

                    ? 55

                    : tablet

                        ? 70

                        : 85,

            decoration:
                BoxDecoration(

              color:
                  color.withOpacity(
                0.22,
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