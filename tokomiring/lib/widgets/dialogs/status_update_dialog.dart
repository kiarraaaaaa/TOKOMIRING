// lib/widgets/dialogs/status_update_dialog.dart

import 'package:flutter/material.dart';

class StatusUpdateDialog {
  static Future<String?> show(
    BuildContext context,
  ) async {
    String? selectedStatus;

    final statuses = [
      'Waiting Admin Validation',
      'Processing Delivery',
      'Package On Delivery',
      'Completed',
    ];

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20),
          ),

          title: const Text(
            'Update Order Status',
          ),

          content: StatefulBuilder(
            builder:
                (context, setState) {
              return Column(
                mainAxisSize:
                    MainAxisSize.min,
                children: statuses
                    .map(
                      (status) =>
                          RadioListTile<
                              String>(
                        title: Text(
                          status,
                        ),

                        value: status,

                        groupValue:
                            selectedStatus,

                        onChanged:
                            (value) {
                          setState(() {
                            selectedStatus =
                                value;
                          });
                        },
                      ),
                    )
                    .toList(),
              );
            },
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              child: const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              child: const Text(
                'Update',
              ),
            ),
          ],
        );
      },
    );

    return selectedStatus;
  }
}