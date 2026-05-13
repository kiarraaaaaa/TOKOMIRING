import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/order_provider.dart';
import '../../providers/product_provider.dart';

import '../../models/product_model.dart';

import '../../core/utils/app_format.dart';

import '../../widgets/admin/admin_dashboard_header.dart';

class AdminSalesReportScreen extends StatefulWidget {

  const AdminSalesReportScreen({
    super.key,
  });

  @override
  State<AdminSalesReportScreen> createState() =>
      _AdminSalesReportScreenState();
}

class _AdminSalesReportScreenState
    extends State<AdminSalesReportScreen> {

  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      context
          .read<OrderProvider>()
          .initializeOrders();

      context
          .read<ProductProvider>()
          .initializeProducts();
    });
  }

  @override
  Widget build(BuildContext context) {

    final orderProvider =
        context.watch<OrderProvider>();

    final productProvider =
        context.watch<ProductProvider>();

    final products =
        productProvider.allProducts;

    final orders =
        orderProvider.orders;

    double revenue = 0;

    int totalSold = 0;

    int completedOrders = 0;

    // =====================================================
    // REALTIME SOLD MAP
    // =====================================================

    final Map<String, int> soldMap = {};

    // =====================================================
    // DAILY CHART DATA
    // =====================================================

    final Map<int, double>
        revenuePerDay = {};

    final Map<int, int>
        transactionPerDay = {};

    for (int i = 0; i < 7; i++) {

      revenuePerDay[i] = 0;

      transactionPerDay[i] = 0;
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

            (revenuePerDay[weekday] ?? 0) +

                order.totalPrice;

        transactionPerDay[weekday] =

            (transactionPerDay[weekday] ?? 0) +

                1;

        for (final item in order.items) {

          soldMap[item.productId] =
              (soldMap[item.productId] ?? 0) +
                  item.quantity;
        }
      }
    }

    // =====================================================
    // TOP SELLING REALTIME
    // =====================================================

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

        return (b['sold'] as int)
            .compareTo(
          a['sold'] as int,
        );
      });

    return Scaffold(

      backgroundColor:
          const Color(
        0xffF8FAFC,
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          physics:
              const BouncingScrollPhysics(),

          padding:
              const EdgeInsets.all(
            24,
          ),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              const AdminDashboardHeader(),

              const SizedBox(
                height: 30,
              ),

              const Text(

                'Sales Reports',

                style: TextStyle(

                  fontSize: 34,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Text(

                'Realtime sales analytics',

                style: TextStyle(

                  fontSize: 15,

                  color:
                      Colors.grey
                          .shade600,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              // =================================================
              // ANALYTICS
              // =================================================

              Wrap(

                spacing: 20,

                runSpacing: 20,

                children: [

                  analyticsCard(

                    'Revenue',

                    AppFormat.currency(
                      revenue,
                    ),

                    Icons.payments_rounded,

                    Colors.green,
                  ),

                  analyticsCard(

                    'Transactions',

                    completedOrders
                        .toString(),

                    Icons.receipt_long_rounded,

                    Colors.blue,
                  ),

                  analyticsCard(

                    'Items Sold',

                    totalSold
                        .toString(),

                    Icons
                        .shopping_bag_rounded,

                    Colors.orange,
                  ),

                  analyticsCard(

                    'Products',

                    products.length
                        .toString(),

                    Icons.store_rounded,

                    Colors.purple,
                  ),
                ],
              ),

              const SizedBox(
                height: 40,
              ),

              // =================================================
              // REVENUE CHART
              // =================================================

              Container(

                width:
                    double.infinity,

                padding:
                    const EdgeInsets.all(
                  24,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                    30,
                  ),
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Row(

                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                      children: [

                        const Text(

                          'Realtime Revenue Chart',

                          style: TextStyle(

                            fontSize: 24,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        Container(

                          padding:
                              const EdgeInsets.symmetric(

                            horizontal: 14,

                            vertical: 8,
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
                              14,
                            ),
                          ),

                          child:
                              const Text(
                            'LIVE',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    SizedBox(

                      height: 320,

                      child: LineChart(

                        LineChartData(

                          gridData:
                              FlGridData(
                            show: true,
                          ),

                          borderData:
                              FlBorderData(
                            show: false,
                          ),

                          titlesData:
                              FlTitlesData(

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
                                      top: 12,
                                    ),

                                    child: Text(

                                      days[value
                                          .toInt()],
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

                              barWidth: 5,

                              dotData:
                                  const FlDotData(
                                show: true,
                              ),

                              belowBarData:
                                  BarAreaData(
                                show: true,
                              ),

                              spots: List.generate(

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
                height: 40,
              ),

              // =================================================
              // TRANSACTION CHART
              // =================================================

              Container(

                width:
                    double.infinity,

                padding:
                    const EdgeInsets.all(
                  24,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                    30,
                  ),
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    const Text(

                      'Realtime Transactions',

                      style: TextStyle(

                        fontSize: 24,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    SizedBox(

                      height: 280,

                      child: BarChart(

                        BarChartData(

                          borderData:
                              FlBorderData(
                            show: false,
                          ),

                          gridData:
                              FlGridData(
                            show: true,
                          ),

                          titlesData:
                              FlTitlesData(

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
                                      top: 10,
                                    ),

                                    child: Text(

                                      days[value
                                          .toInt()],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          barGroups:
                              List.generate(

                            7,

                            (index) {

                              return BarChartGroupData(

                                x: index,

                                barRods: [

                                  BarChartRodData(

                                    toY:
                                        transactionPerDay[
                                                    index]
                                                ?.toDouble() ??
                                            0,

                                    width:
                                        26,

                                    borderRadius:
                                        BorderRadius.circular(
                                      8,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              // =================================================
              // TOP SELLING
              // =================================================

              Container(

                width:
                    double.infinity,

                padding:
                    const EdgeInsets.all(
                  24,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                    30,
                  ),
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Row(

                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                      children: [

                        const Text(

                          'Top Selling Products',

                          style: TextStyle(

                            fontSize: 24,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        Container(

                          padding:
                              const EdgeInsets.symmetric(

                            horizontal: 16,

                            vertical: 10,
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
                              14,
                            ),
                          ),

                          child:
                              const Text(
                            'Realtime',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    if (topProducts
                        .isEmpty)

                      const Padding(

                        padding:
                            EdgeInsets.all(
                          40,
                        ),

                        child: Center(

                          child: Text(
                            'No products available',
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
                          );
                        },
                      ),
                  ],
                ),
              ),

              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget analyticsCard(

    String title,

    String value,

    IconData icon,

    Color color,
  ) {

    return Container(

      width: 250,

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
          24,
        ),
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          Container(

            width: 60,

            height: 60,

            decoration:
                BoxDecoration(

              color:
                  color.withOpacity(
                0.1,
              ),

              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            child: Icon(

              icon,

              color: color,
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          Text(

            value,

            maxLines: 1,

            overflow:
                TextOverflow
                    .ellipsis,

            style:
                const TextStyle(

              fontSize: 28,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 6,
          ),

          Text(title),
        ],
      ),
    );
  }

  Widget topProductCard(
    ProductModel product,
    int sold,
  ) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 18,
      ),

      padding:
          const EdgeInsets.all(
        18,
      ),

      decoration:
          BoxDecoration(

        color:
            const Color(
          0xffF8FAFC,
        ),

        borderRadius:
            BorderRadius.circular(
          22,
        ),
      ),

      child: Row(
        children: [

          productImage(product),

          const SizedBox(
            width: 20,
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
                      const TextStyle(

                    fontSize: 18,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 6,
                ),

                Text(
                  product.category,
                ),
              ],
            ),
          ),

          const SizedBox(
            width: 20,
          ),

          Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .end,

            children: [

              Text(

                '$sold Sold',

                style:
                    const TextStyle(

                  fontSize: 18,

                  fontWeight:
                      FontWeight.bold,

                  color:
                      Colors.green,
                ),
              ),

              const SizedBox(
                height: 6,
              ),

              Text(
                AppFormat.currency(
                  product.price,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget productImage(
    ProductModel product,
  ) {

    try {

      if (product.imageBase64
          .trim()
          .isEmpty) {

        return fallbackImage();
      }

      return ClipRRect(

        borderRadius:
            BorderRadius.circular(
          16,
        ),

        child: Image.memory(

          base64Decode(
            product.imageBase64,
          ),

          width: 70,

          height: 70,

          fit: BoxFit.cover,

          errorBuilder:
              (
                context,
                error,
                stackTrace,
              ) {

            return fallbackImage();
          },
        ),
      );

    } catch (_) {

      return fallbackImage();
    }
  }

  Widget fallbackImage() {

    return Container(

      width: 70,

      height: 70,

      decoration:
          BoxDecoration(

        color:
            Colors.orange
                .withOpacity(
          0.1,
        ),

        borderRadius:
            BorderRadius.circular(
          16,
        ),
      ),

      child:
          const Icon(

        Icons.image_rounded,

        color:
            Colors.orange,
      ),
    );
  }
}