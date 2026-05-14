import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/order_provider.dart';
import '../../providers/product_provider.dart';

import '../../models/product_model.dart';

import '../../core/utils/app_format.dart';

class AdminSalesReportScreen
    extends StatefulWidget {

  const AdminSalesReportScreen({
    super.key,
  });

  @override
  State<AdminSalesReportScreen>
      createState() =>
          _AdminSalesReportScreenState();
}

class _AdminSalesReportScreenState
    extends State<AdminSalesReportScreen> {

  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      context
          .read<OrderProvider>()
          .initializeOrders();

      context
          .read<ProductProvider>()
          .initializeProducts();
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final orderProvider =
        context.watch<OrderProvider>();

    final productProvider =
        context.watch<ProductProvider>();

    final products =
        productProvider.allProducts;

    final orders =
        orderProvider.orders;

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final mobile =
        width < 650;

    final tablet =
        width >= 650 &&
            width < 1050;

    double revenue = 0;

    int totalSold = 0;

    int completedOrders = 0;

    final Map<String, int>
        soldMap = {};

    final Map<int, double>
        revenuePerDay = {};

    for (int i = 0; i < 7; i++) {

      revenuePerDay[i] = 0;
    }

    for (final order in orders) {

      if (order.status
              .toLowerCase() ==
          'completed') {

        revenue += order.totalPrice;

        totalSold += order.totalItems;

        completedOrders++;

        final weekday =
            order.createdAt.weekday -
                1;

        revenuePerDay[weekday] =

            (revenuePerDay[
                        weekday] ??
                    0) +

                order.totalPrice;

        for (final item in order.items) {

          soldMap[item.productId] =
              (soldMap[item.productId] ??
                      0) +
                  item.quantity;
        }
      }
    }

    final topProducts =
        products.map((product) {

      final sold =
          soldMap[product.id] ?? 0;

      return {
        'product': product,
        'sold': sold,
      };

    }).toList()

          ..sort((a, b) {

            return (b['sold']
                    as int)
                .compareTo(
              a['sold']
                  as int,
            );
          });

    int analyticsCount = 4;

    if (tablet) {

      analyticsCount = 2;
    }

    if (mobile) {

      analyticsCount = 1;
    }

    return Scaffold(

      backgroundColor:
          const Color(
        0xffF8FAFC,
      ),

      body: SafeArea(

        child:
            SingleChildScrollView(

          physics:
              const BouncingScrollPhysics(),

          padding:
              const EdgeInsets.all(
            10,
          ),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              Text(

                'Sales Reports',

                style:
                    TextStyle(

                  fontSize:

                      mobile
                          ? 20
                          : 28,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 2,
              ),

              Text(

                'Realtime revenue analytics',

                style:
                    TextStyle(

                  fontSize: 9,

                  color:
                      Colors.grey
                          .shade600,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // =============================================
              // ANALYTICS
              // =============================================

              GridView.builder(

                shrinkWrap:
                    true,

                physics:
                    const NeverScrollableScrollPhysics(),

                itemCount: 4,

                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount:
                      analyticsCount,

                  crossAxisSpacing:
                      8,

                  mainAxisSpacing:
                      8,

                  childAspectRatio:

                      mobile
                          ? 3.1
                          : tablet
                              ? 2.9
                              : 2.7,
                ),

                itemBuilder:
                    (
                      context,
                      index,
                    ) {

                  final analytics = [

                    {
                      'title':
                          'Revenue',

                      'value':
                          AppFormat.currency(
                        revenue,
                      ),

                      'icon':
                          Icons
                              .payments_rounded,

                      'color':
                          Colors.green,
                    },

                    {
                      'title':
                          'Transactions',

                      'value':
                          completedOrders
                              .toString(),

                      'icon':
                          Icons
                              .receipt_long_rounded,

                      'color':
                          Colors.blue,
                    },

                    {
                      'title':
                          'Items Sold',

                      'value':
                          totalSold
                              .toString(),

                      'icon':
                          Icons
                              .shopping_bag_rounded,

                      'color':
                          Colors.orange,
                    },

                    {
                      'title':
                          'Products',

                      'value':
                          products.length
                              .toString(),

                      'icon':
                          Icons
                              .store_rounded,

                      'color':
                          Colors.purple,
                    },
                  ];

                  final item =
                      analytics[index];

                  return analyticsCard(

                    item['title']
                        as String,

                    item['value']
                        as String,

                    item['icon']
                        as IconData,

                    item['color']
                        as Color,

                    mobile,
                  );
                },
              ),

              const SizedBox(
                height: 10,
              ),

              // =============================================
              // REVENUE CHART
              // =============================================

              Container(

                width:
                    double.infinity,

                padding:
                    EdgeInsets.all(
                  mobile
                      ? 10
                      : 12,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Row(

                      children: [

                        Expanded(

                          child: Text(

                            'Realtime Revenue',

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                TextStyle(

                              fontSize:
                                  mobile
                                      ? 13
                                      : 15,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),

                        Container(

                          padding:
                              const EdgeInsets.symmetric(

                            horizontal:
                                8,

                            vertical:
                                4,
                          ),

                          decoration:
                              BoxDecoration(

                            color:
                                Colors.green
                                    .withOpacity(
                              0.1,
                            ),

                            borderRadius:
                                BorderRadius.circular(
                              8,
                            ),
                          ),

                          child:
                              Text(

                            'LIVE',

                            style:
                                TextStyle(
                              fontSize:
                                  mobile
                                      ? 8
                                      : 9,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    SizedBox(

                      height:

                          mobile
                              ? 170
                              : tablet
                                  ? 210
                                  : 240,

                      child: LineChart(

                        LineChartData(

                          minY: 0,

                          clipData:
                              const FlClipData.all(),

                          gridData:
                              FlGridData(

                            show: true,

                            drawVerticalLine:
                                false,

                            horizontalInterval:
                                5,
                          ),

                          borderData:
                              FlBorderData(
                            show: false,
                          ),

                          titlesData:
                              FlTitlesData(

                            leftTitles:
                                AxisTitles(

                              sideTitles:
                                  SideTitles(

                                showTitles:
                                    true,

                                reservedSize:
                                    mobile
                                        ? 26
                                        : 32,

                                getTitlesWidget:
                                    (
                                      value,
                                      meta,
                                    ) {

                                  return Text(

                                    '${value.toInt()}k',

                                    style:
                                        TextStyle(
                                      fontSize:
                                          mobile
                                              ? 7
                                              : 8,
                                    ),
                                  );
                                },
                              ),
                            ),

                            rightTitles:
                                const AxisTitles(

                              sideTitles:
                                  SideTitles(
                                showTitles:
                                    false,
                              ),
                            ),

                            topTitles:
                                const AxisTitles(

                              sideTitles:
                                  SideTitles(
                                showTitles:
                                    false,
                              ),
                            ),

                            bottomTitles:
                                AxisTitles(

                              sideTitles:
                                  SideTitles(

                                showTitles:
                                    true,

                                reservedSize:
                                    24,

                                getTitlesWidget:
                                    (
                                      value,
                                      meta,
                                    ) {

                                  final days = [

                                    'Mon',

                                    'Tue',

                                    'Wed',

                                    'Thu',

                                    'Fri',

                                    'Sat',

                                    'Sun',
                                  ];

                                  return Padding(

                                    padding:
                                        const EdgeInsets.only(
                                      top: 6,
                                    ),

                                    child: Text(

                                      days[value
                                          .toInt()],

                                      style:
                                          TextStyle(
                                        fontSize:
                                            mobile
                                                ? 7
                                                : 8,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          lineBarsData: [

                            LineChartBarData(

                              isCurved:
                                  true,

                              barWidth:
                                  mobile
                                      ? 2
                                      : 3,

                              dotData:
                                  const FlDotData(
                                show: false,
                              ),

                              belowBarData:
                                  BarAreaData(
                                show: true,
                              ),

                              spots:
                                  List.generate(

                                7,

                                (index) {

                                  return FlSpot(

                                    index
                                        .toDouble(),

                                    (revenuePerDay[
                                                    index] ??
                                                0) /
                                            1000,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // =============================================
              // TOP PRODUCTS
              // =============================================

              Container(

                width:
                    double.infinity,

                padding:
                    EdgeInsets.all(
                  mobile
                      ? 10
                      : 12,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Row(

                      children: [

                        Expanded(

                          child: Text(

                            'Top Selling Products',

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                TextStyle(

                              fontSize:
                                  mobile
                                      ? 13
                                      : 15,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),

                        Container(

                          padding:
                              const EdgeInsets.symmetric(

                            horizontal:
                                8,

                            vertical:
                                4,
                          ),

                          decoration:
                              BoxDecoration(

                            color:
                                Colors.green
                                    .withOpacity(
                              0.1,
                            ),

                            borderRadius:
                                BorderRadius.circular(
                              8,
                            ),
                          ),

                          child:
                              Text(

                            'LIVE',

                            style:
                                TextStyle(
                              fontSize:
                                  mobile
                                      ? 8
                                      : 9,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    if (topProducts
                        .isEmpty)

                      const Padding(

                        padding:
                            EdgeInsets.all(
                          18,
                        ),

                        child: Center(

                          child: Text(

                            'No products available',

                            style:
                                TextStyle(
                              fontSize:
                                  10,
                            ),
                          ),
                        ),
                      )

                    else

                      ...topProducts
                          .take(5)
                          .map(
                        (
                          data,
                        ) {

                          final product =
                              data['product']
                                  as ProductModel;

                          final sold =
                              data['sold']
                                  as int;

                          return topProductCard(
                            product,
                            sold,
                            mobile,
                          );
                        },
                      ),
                  ],
                ),
              ),

              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // ANALYTICS CARD
  // =====================================================

  Widget analyticsCard(

    String title,

    String value,

    IconData icon,

    Color color,

    bool mobile,
  ) {

    return Container(

      padding:
          EdgeInsets.symmetric(

        horizontal:
            mobile
                ? 10
                : 12,

        vertical:
            mobile
                ? 8
                : 10,
      ),

      decoration:
          BoxDecoration(

        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(
          14,
        ),
      ),

      child: Row(

        children: [

          Container(

            width:
                mobile
                    ? 34
                    : 38,

            height:
                mobile
                    ? 34
                    : 38,

            decoration:
                BoxDecoration(

              color:
                  color.withOpacity(
                0.12,
              ),

              borderRadius:
                  BorderRadius.circular(
                10,
              ),
            ),

            child: Icon(

              icon,

              color: color,

              size:
                  mobile
                      ? 16
                      : 18,
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          Expanded(

            child: Column(

              mainAxisAlignment:
                  MainAxisAlignment
                      .center,

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                FittedBox(

                  fit:
                      BoxFit.scaleDown,

                  alignment:
                      Alignment.centerLeft,

                  child: Text(

                    value,

                    maxLines: 1,

                    style:
                        TextStyle(

                      fontSize:
                          mobile
                              ? 13
                              : 15,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 2,
                ),

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
                            ? 8
                            : 9,

                    color:
                        Colors.grey
                            .shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // TOP PRODUCT CARD
  // =====================================================

  Widget topProductCard(
    ProductModel product,
    int sold,
    bool mobile,
  ) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 8,
      ),

      padding:
          EdgeInsets.all(
        mobile
            ? 10
            : 12,
      ),

      decoration:
          BoxDecoration(

        color:
            const Color(
          0xffF8FAFC,
        ),

        borderRadius:
            BorderRadius.circular(
          14,
        ),
      ),

      child: Row(
        children: [

          productImage(
            product,
            mobile,
          ),

          const SizedBox(
            width: 10,
          ),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(

                  product.name,

                  maxLines: 1,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      TextStyle(

                    fontSize:
                        mobile
                            ? 11
                            : 12,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 2,
                ),

                Text(

                  product.category,

                  maxLines: 1,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      TextStyle(
                    fontSize:
                        mobile
                            ? 8
                            : 9,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            width: 8,
          ),

          Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .end,

            children: [

              Text(

                '$sold Sold',

                style:
                    TextStyle(

                  fontSize:
                      mobile
                          ? 10
                          : 11,

                  fontWeight:
                      FontWeight.bold,

                  color:
                      Colors.green,
                ),
              ),

              const SizedBox(
                height: 2,
              ),

              ConstrainedBox(

                constraints:
                    const BoxConstraints(
                  maxWidth: 80,
                ),

                child: Text(

                  AppFormat.currency(
                    product.price,
                  ),

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      TextStyle(
                    fontSize:
                        mobile
                            ? 8
                            : 9,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =====================================================
  // PRODUCT IMAGE
  // =====================================================

  Widget productImage(
    ProductModel product,
    bool mobile,
  ) {

    final size =
        mobile
            ? 44.0
            : 50.0;

    try {

      if (product.imageBase64
          .trim()
          .isEmpty) {

        return fallbackImage(
          mobile,
        );
      }

      return ClipRRect(

        borderRadius:
            BorderRadius.circular(
          10,
        ),

        child: Image.memory(

          base64Decode(
            product.imageBase64,
          ),

          width: size,

          height: size,

          fit: BoxFit.cover,

          errorBuilder:
              (
                context,
                error,
                stackTrace,
              ) {

            return fallbackImage(
              mobile,
            );
          },
        ),
      );

    } catch (_) {

      return fallbackImage(
        mobile,
      );
    }
  }

  // =====================================================
  // FALLBACK IMAGE
  // =====================================================

  Widget fallbackImage(
    bool mobile,
  ) {

    final size =
        mobile
            ? 44.0
            : 50.0;

    return Container(

      width: size,

      height: size,

      decoration:
          BoxDecoration(

        color:
            Colors.orange
                .withOpacity(
          0.1,
        ),

        borderRadius:
            BorderRadius.circular(
          10,
        ),
      ),

      child:
          Icon(

        Icons.image_rounded,

        color:
            Colors.orange,

        size:
            mobile
                ? 16
                : 18,
      ),
    );
  }
}