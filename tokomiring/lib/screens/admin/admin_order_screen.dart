// =====================================================
// FINAL RESPONSIVE FIX STABLE
// lib/screens/admin/admin_order_screen.dart
// =====================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/order_model.dart';

import '../../providers/order_provider.dart';
import '../../providers/product_provider.dart';

class AdminOrderScreen
    extends StatefulWidget {

  const AdminOrderScreen({
    super.key,
  });

  @override
  State<AdminOrderScreen>
      createState() =>
          _AdminOrderScreenState();
}

class _AdminOrderScreenState
    extends State<AdminOrderScreen> {

  String selectedFilter =
      'All';

  final List<String> statuses = [

    'All',

    'Waiting Admin Validation',

    'Processing Delivery',

    'Package On Delivery',

    'Completed',

    'Rejected',
  ];

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

  // =====================================================
  // UPDATE STATUS
  // =====================================================

  Future<void> updateStatus({

    required OrderModel order,
  }) async {

    String selectedStatus =
        order.status;

    await showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          shape:
              RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(
              16,
            ),
          ),

          title:
              const Text(

            'Update Status',

            style:
                TextStyle(
              fontSize: 16,
            ),
          ),

          content:
              StatefulBuilder(

            builder:
                (
                  context,
                  setState,
                ) {

              return SizedBox(

                width: 320,

                child:
                    SingleChildScrollView(

                  child: Column(

                    mainAxisSize:
                        MainAxisSize.min,

                    children:

                        statuses
                            .where(
                              (
                                e,
                              ) {

                                return e !=
                                    'All';
                              },
                            )
                            .map(
                              (
                                status,
                              ) {

                          return RadioListTile<
                              String>(

                            dense: true,

                            visualDensity:
                                VisualDensity.compact,

                            contentPadding:
                                EdgeInsets.zero,

                            value:
                                status,

                            groupValue:
                                selectedStatus,

                            title:
                                Text(

                              status,

                              style:
                                  const TextStyle(
                                fontSize: 11,
                              ),
                            ),

                            onChanged:
                                (
                                  value,
                                ) {

                              setState(() {

                                selectedStatus =
                                    value!;
                              });
                            },
                          );
                        },
                            )
                            .toList(),
                  ),
                ),
              );
            },
          ),

          actions: [

            TextButton(

              onPressed:
                  () {

                Navigator.pop(
                  context,
                );
              },

              child:
                  const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(

              style:
                  ElevatedButton.styleFrom(

                backgroundColor:
                    Colors.blue,

                minimumSize:
                    const Size(
                  90,
                  40,
                ),

                shape:
                    RoundedRectangleBorder(

                  borderRadius:
                      BorderRadius.circular(
                    10,
                  ),
                ),
              ),

              onPressed:
                  () async {

                final orderProvider =
                    context.read<
                        OrderProvider>();

                await orderProvider
                    .updateOrderStatus(

                  orderId:
                      order.orderId,

                  status:
                      selectedStatus,
                );

                await orderProvider
                    .refreshOrders();

                if (!mounted) {
                  return;
                }

                Navigator.pop(
                  context,
                );
              },

              child:
                  const FittedBox(

                child: Text(

                  'Update',

                  style:
                      TextStyle(

                    color:
                        Colors.white,

                    fontSize:
                        11,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final provider =
        context.watch<
            OrderProvider>();

    final allOrders =
        provider.orders;

    final filteredOrders =

        selectedFilter ==
                'All'

            ? allOrders

            : allOrders
                .where(
                  (
                    order,
                  ) {

                return order
                        .status ==
                    selectedFilter;
              },
                )
                .toList();

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final mobile =
        width < 650;

    final tablet =
        width >= 650 &&
            width < 1050;

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

      body:
          SafeArea(

        child:
            SingleChildScrollView(

          physics:
              const BouncingScrollPhysics(),

          padding:
              const EdgeInsets.all(
            10,
          ),

          child:
              Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              Text(

                'Order Management',

                style:
                    TextStyle(

                  fontSize:

                      mobile
                          ? 21
                          : 29,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 3,
              ),

              Text(

                'Monitor and manage customer orders.',

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

              // =====================================================
              // ANALYTICS
              // =====================================================

              GridView.builder(

                shrinkWrap:
                    true,

                physics:
                    const NeverScrollableScrollPhysics(),

                itemCount: 5,

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
                          ? 3.2
                          : tablet
                              ? 2.8
                              : 2.6,
                ),

                itemBuilder:
                    (
                      context,
                      index,
                    ) {

                  final analytics = [

                    {
                      'title':
                          'Waiting',

                      'value':
                          allOrders
                              .where(
                        (
                          e,
                        ) {

                          return e.status ==
                              'Waiting Admin Validation';
                        },
                      ).length,

                      'icon':
                          Icons.pending,

                      'color':
                          Colors.orange,
                    },

                    {
                      'title':
                          'Processing',

                      'value':
                          allOrders
                              .where(
                        (
                          e,
                        ) {

                          return e.status ==
                              'Processing Delivery';
                        },
                      ).length,

                      'icon':
                          Icons.local_shipping,

                      'color':
                          Colors.blue,
                    },

                    {
                      'title':
                          'Delivery',

                      'value':
                          allOrders
                              .where(
                        (
                          e,
                        ) {

                          return e.status ==
                              'Package On Delivery';
                        },
                      ).length,

                      'icon':
                          Icons.delivery_dining,

                      'color':
                          Colors.purple,
                    },

                    {
                      'title':
                          'Completed',

                      'value':
                          allOrders
                              .where(
                        (
                          e,
                        ) {

                          return e.status ==
                              'Completed';
                        },
                      ).length,

                      'icon':
                          Icons.check_circle,

                      'color':
                          Colors.green,
                    },

                    {
                      'title':
                          'Rejected',

                      'value':
                          allOrders
                              .where(
                        (
                          e,
                        ) {

                          return e.status ==
                              'Rejected';
                        },
                      ).length,

                      'icon':
                          Icons.cancel,

                      'color':
                          Colors.red,
                    },
                  ];

                  final item =
                      analytics[index];

                  return analyticsCard(

                    item['title']
                        as String,

                    item['value']
                        as int,

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

              // =====================================================
              // FILTER CHIP
              // =====================================================

              Wrap(

                spacing: 8,

                runSpacing: 8,

                children:
                    statuses.map(
                  (
                    status,
                  ) {

                    final active =
                        selectedFilter ==
                            status;

                    return InkWell(

                      borderRadius:
                          BorderRadius.circular(
                        10,
                      ),

                      onTap: () {

                        setState(() {

                          selectedFilter =
                              status;
                        });
                      },

                      child:
                          AnimatedContainer(

                        duration:
                            const Duration(
                          milliseconds:
                              250,
                        ),

                        padding:
                            EdgeInsets.symmetric(

                          horizontal:

                              mobile
                                  ? 10
                                  : 12,

                          vertical:
                              8,
                        ),

                        constraints:
                            const BoxConstraints(
                          minHeight: 36,
                        ),

                        decoration:
                            BoxDecoration(

                          color:

                              active

                                  ? Colors.blue

                                  : Colors.white,

                          borderRadius:
                              BorderRadius.circular(
                            10,
                          ),
                        ),

                        child:
                            Text(

                          status,

                          textAlign:
                              TextAlign.center,

                          style:
                              TextStyle(

                            fontSize:

                                mobile
                                    ? 9
                                    : 10,

                            color:

                                active

                                    ? Colors.white

                                    : Colors.black,

                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),

              const SizedBox(
                height: 10,
              ),

              // =====================================================
              // ORDER LIST
              // =====================================================

              if (filteredOrders
                  .isEmpty)

                Container(

                  width:
                      double.infinity,

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
                      16,
                    ),
                  ),

                  child:
                      const Center(

                    child: Text(

                      'No orders found',

                      style:
                          TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ),
                )

              else

                ListView.builder(

                  shrinkWrap:
                      true,

                  physics:
                      const NeverScrollableScrollPhysics(),

                  itemCount:
                      filteredOrders.length,

                  itemBuilder:
                      (
                        context,
                        index,
                      ) {

                    return orderCard(

                      filteredOrders[
                          index],

                      mobile,
                    );
                  },
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
  // ORDER CARD
  // =====================================================

  Widget orderCard(
    OrderModel order,
    bool mobile,
  ) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),

      padding:
          EdgeInsets.all(
        mobile
            ? 12
            : 14,
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

      child:

          mobile

              ? Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Text(

                      order.customerName,

                      maxLines: 1,

                      overflow:
                          TextOverflow
                              .ellipsis,

                      style:
                          const TextStyle(

                        fontSize: 13,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 4,
                    ),

                    SelectableText(

                      'Order #${order.orderId}',

                      style:
                          const TextStyle(
                        fontSize: 9.5,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    Wrap(

                      spacing: 6,

                      runSpacing: 6,

                      children: [

                        statusChip(
                          order.status,
                        ),

                        priceChip(
                          'Rp ${order.totalPrice.toStringAsFixed(0)}',
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    ...order.items.map(
                      (
                        item,
                      ) {

                        return Padding(

                          padding:
                              const EdgeInsets.only(
                            bottom: 3,
                          ),

                          child: Text(

                            '${item.productName} x${item.quantity}',

                            maxLines: 1,

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                const TextStyle(
                              fontSize: 9.5,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    SizedBox(

                      width:
                          double.infinity,

                      height:
                          38,

                      child:
                          ElevatedButton(

                        style:
                            ElevatedButton.styleFrom(

                          backgroundColor:
                              Colors.blue,

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),

                        onPressed:
                            () {

                          updateStatus(
                            order:
                                order,
                          );
                        },

                        child:
                            const FittedBox(

                          child: Text(

                            'Update Status',

                            style:
                                TextStyle(

                              fontSize:
                                  10,

                              color:
                                  Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )

              : Row(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Expanded(
                      flex: 4,

                      child:
                          Column(

                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Text(

                            order.customerName,

                            maxLines: 1,

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                const TextStyle(

                              fontSize: 13,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 3,
                          ),

                          SelectableText(

                            'Order #${order.orderId}',

                            style:
                                const TextStyle(
                              fontSize: 9.5,
                            ),
                          ),

                          const SizedBox(
                            height: 6,
                          ),

                          ...order.items.map(
                            (
                              item,
                            ) {

                              return Padding(

                                padding:
                                    const EdgeInsets.only(
                                  bottom: 2,
                                ),

                                child: Text(

                                  '${item.productName} x${item.quantity}',

                                  overflow:
                                      TextOverflow
                                          .ellipsis,

                                  maxLines: 1,

                                  style:
                                      const TextStyle(
                                    fontSize:
                                        9.5,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Flexible(

                      child:
                          Column(

                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          statusChip(
                            order.status,
                          ),

                          const SizedBox(
                            height: 6,
                          ),

                          priceChip(
                            'Rp ${order.totalPrice.toStringAsFixed(0)}',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    SizedBox(

                      width: 110,

                      height: 38,

                      child:
                          ElevatedButton(

                        style:
                            ElevatedButton.styleFrom(

                          backgroundColor:
                              Colors.blue,

                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),

                        onPressed:
                            () {

                          updateStatus(
                            order:
                                order,
                          );
                        },

                        child:
                            const FittedBox(

                          child: Text(

                            'Update Status',

                            style:
                                TextStyle(

                              fontSize:
                                  9.5,

                              color:
                                  Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget statusChip(
    String status,
  ) {

    Color color =
        Colors.blue;

    if (status ==
        'Completed') {

      color =
          Colors.green;
    }

    else if (status ==
        'Rejected') {

      color =
          Colors.red;
    }

    else if (status ==
        'Package On Delivery') {

      color =
          Colors.purple;
    }

    return Container(

      padding:
          const EdgeInsets.symmetric(

        horizontal: 10,

        vertical: 6,
      ),

      decoration:
          BoxDecoration(

        color:
            color.withOpacity(
          0.1,
        ),

        borderRadius:
            BorderRadius.circular(
          8,
        ),
      ),

      child:
          Text(

        status,

        style:
            TextStyle(

          fontSize: 9,

          color:
              color,

          fontWeight:
              FontWeight.w600,
        ),
      ),
    );
  }

  Widget priceChip(
    String text,
  ) {

    return Container(

      padding:
          const EdgeInsets.symmetric(

        horizontal: 10,

        vertical: 6,
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

        text,

        overflow:
            TextOverflow
                .ellipsis,

        style:
            const TextStyle(

          fontSize: 9,

          color:
              Colors.green,

          fontWeight:
              FontWeight.w600,
        ),
      ),
    );
  }

  Widget analyticsCard(

    String title,

    int value,

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
          16,
        ),
      ),

      child:
          Row(

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

            child:
                Column(

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

                    '$value',

                    maxLines: 1,

                    style:
                        TextStyle(

                      fontSize:
                          mobile
                              ? 14
                              : 16,

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
}