// lib/widgets/cards/order_card.dart

import 'package:flutter/material.dart';

import '../../models/order_model.dart';

import '../../core/utils/app_format.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({
    super.key,
    required this.order,
  });

  Color getStatusColor() {
    switch (order.status) {
      case 'Waiting Admin Validation':
        return Colors.orange;

      case 'Processing Delivery':
        return Colors.blue;

      case 'Package On Delivery':
        return Colors.purple;

      case 'Completed':
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Order #${order.orderId.substring(0, 8)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: getStatusColor()
                        .withOpacity(0.1),
                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      color:
                          getStatusColor(),
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              'Customer: ${order.customerName}',
            ),

            const SizedBox(height: 10),

            Text(
              'Items: ${order.totalItems}',
            ),

            const SizedBox(height: 10),

            Text(
              AppFormat.currency(
                order.totalPrice,
              ),
              style: const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              AppFormat.date(
                order.createdAt,
              ),
            ),
          ],
        ),
      ),
    );
  }
}