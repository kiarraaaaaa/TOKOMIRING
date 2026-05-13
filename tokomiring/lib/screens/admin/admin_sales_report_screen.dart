import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/order_provider.dart';
import '../../providers/product_provider.dart';

import '../../models/product_model.dart';

import '../../core/utils/app_format.dart';

import '../../widgets/admin/admin_dashboard_header.dart';
import '../../widgets/admin/admin_analytics_card.dart';

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
        productProvider.products;

    final orders =
        orderProvider.orders;

    double revenue = 0;

    int totalSold = 0;

    int completedOrders = 0;

    for (final order in orders) {

      if (order.status
              .toLowerCase() ==
          'completed') {

        revenue += order.totalPrice;

        totalSold += order.totalItems;

        completedOrders++;
      }
    }

    final topProducts =
        List<ProductModel>.from(
      products,
    )..sort(
            (
              a,
              b,
            ) {

          return b.sold.compareTo(
            a.sold,
          );
        },
      );

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

                    'Completed Orders',

                    completedOrders
                        .toString(),

                    Icons
                        .check_circle_rounded,

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
                          product,
                        ) {

                          return topProductCard(
                            product,
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

  // =====================================================
  // ANALYTICS CARD
  // =====================================================

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

  // =====================================================
  // PRODUCT CARD
  // =====================================================

  Widget topProductCard(
    ProductModel product,
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

                '${product.sold} Sold',

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

  // =====================================================
  // PRODUCT IMAGE
  // =====================================================

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

  // =====================================================
  // FALLBACK IMAGE
  // =====================================================

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