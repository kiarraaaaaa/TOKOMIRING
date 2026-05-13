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
              24,
            ),
          ),

          title:
              const Text(
            'Update Status',
          ),

          content:
              StatefulBuilder(

            builder:
                (
                  context,
                  setState,
                ) {

              return SingleChildScrollView(

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

                          value:
                              status,

                          groupValue:
                              selectedStatus,

                          title:
                              Text(
                            status,
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
              ),

              onPressed:
                  () async {

                final orderProvider =
                    context.read<
                        OrderProvider>();

                // =====================================
                // UPDATE ORDER STATUS REALTIME
                // =====================================

                await orderProvider
                    .updateOrderStatus(

                  orderId:
                      order.orderId,

                  status:
                      selectedStatus,
                );

                // =====================================
                // REFRESH ORDERS REALTIME
                // =====================================

                await orderProvider
                    .initializeOrders();

                if (!mounted) {
                  return;
                }

                Navigator.pop(
                  context,
                );

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(

                  SnackBar(

                    backgroundColor:
                        Colors.green,

                    behavior:
                        SnackBarBehavior
                            .floating,

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                        16,
                      ),
                    ),

                    content:
                        Text(

                      'Order updated to $selectedStatus',
                    ),
                  ),
                );
              },

              child:
                  const Text(

                'Update',

                style:
                    TextStyle(
                  color:
                      Colors.white,
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

    int analyticsCount = 4;

    if (width < 700) {

      analyticsCount = 1;

    } else if (width < 1100) {

      analyticsCount = 2;
    }

    return Scaffold(

      backgroundColor:
          const Color(
        0xffF8FAFC,
      ),

      body:
          SingleChildScrollView(

        physics:
            const BouncingScrollPhysics(),

        padding:
            const EdgeInsets.all(
          24,
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
                    width < 700
                        ? 28
                        : 42,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Text(

              'Monitor and manage customer orders.',

              style:
                  TextStyle(

                fontSize: 15,

                color:
                    Colors.grey
                        .shade600,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

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
                    20,

                mainAxisSpacing:
                    20,

                mainAxisExtent:
                    190,
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
                );
              },
            ),

            const SizedBox(
              height: 30,
            ),

            SizedBox(

              height: 56,

              child:
                  ListView.builder(

                scrollDirection:
                    Axis.horizontal,

                itemCount:
                    statuses.length,

                itemBuilder:
                    (
                      context,
                      index,
                    ) {

                  final status =
                      statuses[index];

                  final active =
                      selectedFilter ==
                          status;

                  return Padding(

                    padding:
                        const EdgeInsets.only(
                      right: 12,
                    ),

                    child:
                        InkWell(

                      borderRadius:
                          BorderRadius.circular(
                        16,
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
                            const EdgeInsets.symmetric(

                          horizontal:
                              20,

                          vertical:
                              14,
                        ),

                        decoration:
                            BoxDecoration(

                          color:

                              active

                                  ? Colors.blue

                                  : Colors.white,

                          borderRadius:
                              BorderRadius.circular(
                            16,
                          ),
                        ),

                        child: Center(

                          child: Text(

                            status,

                            style:
                                TextStyle(

                              color:

                                  active

                                      ? Colors.white

                                      : Colors.black,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            if (filteredOrders
                .isEmpty)

              Container(

                width:
                    double.infinity,

                padding:
                    const EdgeInsets.all(
                  40,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                    28,
                  ),
                ),

                child:
                    const Center(

                  child: Text(
                    'No orders found',
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
                  );
                },
              ),

            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget orderCard(
    OrderModel order,
  ) {

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final mobile =
        width < 850;

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 20,
      ),

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
          28,
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

                      style:
                          const TextStyle(

                        fontSize: 20,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    SelectableText(
                      'Order #${order.orderId}',
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      order.status,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      'Rp ${order.totalPrice.toStringAsFixed(0)}',
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    ...order.items.map(
                      (
                        item,
                      ) {

                        return Padding(

                          padding:
                              const EdgeInsets.only(
                            bottom: 8,
                          ),

                          child: Text(

                            '${item.productName} x${item.quantity}',

                            style:
                                const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    SizedBox(

                      width:
                          double.infinity,

                      height:
                          52,

                      child:
                          ElevatedButton(

                        style:
                            ElevatedButton.styleFrom(

                          backgroundColor:
                              Colors.blue,
                        ),

                        onPressed:
                            () {

                          updateStatus(
                            order:
                                order,
                          );
                        },

                        child:
                            const Text(

                          'Update Status',

                          style:
                              TextStyle(
                            color:
                                Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )

              : Row(
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

                            style:
                                const TextStyle(

                              fontSize: 20,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          SelectableText(
                            'Order #${order.orderId}',
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
                                  bottom: 6,
                                ),

                                child: Text(

                                  '${item.productName} x${item.quantity}',
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 2,

                      child:
                          Text(
                        order.status,
                      ),
                    ),

                    Expanded(
                      flex: 2,

                      child:
                          Text(
                        'Rp ${order.totalPrice.toStringAsFixed(0)}',
                      ),
                    ),

                    SizedBox(

                      width: 140,

                      height: 48,

                      child:
                          ElevatedButton(

                        style:
                            ElevatedButton.styleFrom(

                          backgroundColor:
                              Colors.blue,
                        ),

                        onPressed:
                            () {

                          updateStatus(
                            order:
                                order,
                          );
                        },

                        child:
                            const Text(

                          'Update',

                          style:
                              TextStyle(
                            color:
                                Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget analyticsCard(

    String title,

    int value,

    IconData icon,

    Color color,
  ) {

    return Container(

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
      ),

      child:
          Column(

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
                0.12,
              ),

              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            child: Icon(

              icon,

              color: color,

              size: 30,
            ),
          ),

          const Spacer(),

          Text(

            '$value',

            style:
                const TextStyle(

              fontSize: 32,

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
}