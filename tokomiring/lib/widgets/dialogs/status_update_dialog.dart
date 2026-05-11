// lib/widgets/dialogs/status_update_dialog.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class StatusUpdateDialog {

  // =====================================================
  // SHOW
  // =====================================================

  static Future<String?> show(

    BuildContext context, {

    String? currentStatus,
  }) async {

    String? selectedStatus =
        currentStatus;

    final statuses = [

      'Waiting Admin Validation',

      'Processing Delivery',

      'Package On Delivery',

      'Completed',
    ];

    final Map<String, IconData>
        statusIcons = {

      'Waiting Admin Validation':
          Icons.access_time_rounded,

      'Processing Delivery':
          Icons.inventory_2_rounded,

      'Package On Delivery':
          Icons.local_shipping_rounded,

      'Completed':
          Icons.check_circle_rounded,
    };

    final Map<String, Color>
        statusColors = {

      'Waiting Admin Validation':
          AppColors.warning,

      'Processing Delivery':
          AppColors.primary,

      'Package On Delivery':
          Colors.purple,

      'Completed':
          AppColors.success,
    };

    final result =
        await showDialog<String>(

      context: context,

      builder: (_) {

        return StatefulBuilder(

          builder: (

            context,

            setState,

          ) {

            return Dialog(

              backgroundColor:
                  Colors.white,

              shape:
                  RoundedRectangleBorder(

                borderRadius:
                    BorderRadius.circular(
                  30,
                ),
              ),

              child: Padding(

                padding:
                    const EdgeInsets.all(
                  26,
                ),

                child: Column(

                  mainAxisSize:
                      MainAxisSize.min,

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    // ===============================
                    // TITLE
                    // ===============================

                    const Text(

                      'Update Order Status',

                      style: TextStyle(

                        fontSize: 24,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(

                      'Select the latest order status.',

                      style:
                          TextStyle(

                        color:
                            Colors.grey
                                .shade700,

                        height: 1.5,
                      ),
                    ),

                    const SizedBox(
                      height: 26,
                    ),

                    // ===============================
                    // STATUS LIST
                    // ===============================

                    ...statuses.map(

                      (status) {

                        final isSelected =
                            selectedStatus ==
                                status;

                        return GestureDetector(

                          onTap: () {

                            setState(() {

                              selectedStatus =
                                  status;
                            });
                          },

                          child: AnimatedContainer(

                            duration:
                                const Duration(
                              milliseconds:
                                  220,
                            ),

                            margin:
                                const EdgeInsets.only(
                              bottom: 14,
                            ),

                            padding:
                                const EdgeInsets.all(
                              16,
                            ),

                            decoration:
                                BoxDecoration(

                              color:
                                  isSelected

                                      ? statusColors[
                                              status]!
                                          .withOpacity(
                                        0.1,
                                      )

                                      : Colors
                                          .grey
                                          .shade50,

                              borderRadius:
                                  BorderRadius.circular(
                                20,
                              ),

                              border:
                                  Border.all(

                                color:
                                    isSelected

                                        ? statusColors[
                                            status]!

                                        : Colors.grey
                                            .shade200,

                                width:
                                    1.5,
                              ),
                            ),

                            child: Row(

                              children: [

                                // ===================
                                // ICON
                                // ===================

                                Container(

                                  width: 46,

                                  height: 46,

                                  decoration:
                                      BoxDecoration(

                                    color:
                                        statusColors[
                                                status]!
                                            .withOpacity(
                                      0.12,
                                    ),

                                    borderRadius:
                                        BorderRadius.circular(
                                      14,
                                    ),
                                  ),

                                  child: Icon(

                                    statusIcons[
                                        status],

                                    color:
                                        statusColors[
                                            status],
                                  ),
                                ),

                                const SizedBox(
                                  width: 16,
                                ),

                                // ===================
                                // TEXT
                                // ===================

                                Expanded(

                                  child: Text(

                                    status,

                                    style:
                                        TextStyle(

                                      fontWeight:
                                          FontWeight
                                              .bold,

                                      fontSize:
                                          15,

                                      color:
                                          isSelected

                                              ? statusColors[
                                                  status]

                                              : Colors
                                                  .black87,
                                    ),
                                  ),
                                ),

                                // ===================
                                // RADIO
                                // ===================

                                AnimatedContainer(

                                  duration:
                                      const Duration(
                                    milliseconds:
                                        220,
                                  ),

                                  width: 24,

                                  height: 24,

                                  decoration:
                                      BoxDecoration(

                                    shape:
                                        BoxShape.circle,

                                    border:
                                        Border.all(

                                      color:
                                          isSelected

                                              ? statusColors[
                                                  status]!

                                              : Colors.grey
                                                  .shade400,

                                      width:
                                          2,
                                    ),

                                    color:
                                        isSelected

                                            ? statusColors[
                                                status]

                                            : Colors
                                                .transparent,
                                  ),

                                  child:
                                      isSelected

                                          ? const Icon(

                                              Icons.check,

                                              size:
                                                  15,

                                              color:
                                                  Colors.white,
                                            )

                                          : null,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    // ===============================
                    // BUTTONS
                    // ===============================

                    Row(

                      children: [

                        // ===========================
                        // CANCEL
                        // ===========================

                        Expanded(

                          child: OutlinedButton(

                            style:
                                OutlinedButton
                                    .styleFrom(

                              padding:
                                  const EdgeInsets.symmetric(
                                vertical: 16,
                              ),

                              shape:
                                  RoundedRectangleBorder(

                                borderRadius:
                                    BorderRadius.circular(
                                  18,
                                ),
                              ),
                            ),

                            onPressed: () {

                              Navigator.pop(
                                context,
                              );
                            },

                            child:
                                const Text(

                              'Cancel',

                              style: TextStyle(

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 14,
                        ),

                        // ===========================
                        // UPDATE
                        // ===========================

                        Expanded(

                          child: ElevatedButton(

                            style:
                                ElevatedButton
                                    .styleFrom(

                              elevation: 0,

                              backgroundColor:
                                  AppColors.primary,

                              foregroundColor:
                                  Colors.white,

                              padding:
                                  const EdgeInsets.symmetric(
                                vertical: 16,
                              ),

                              shape:
                                  RoundedRectangleBorder(

                                borderRadius:
                                    BorderRadius.circular(
                                  18,
                                ),
                              ),
                            ),

                            onPressed:

                                selectedStatus ==
                                        null

                                    ? null

                                    : () {

                                        Navigator.pop(

                                          context,

                                          selectedStatus,
                                        );
                                      },

                            child:
                                const Text(

                              'Update',

                              style: TextStyle(

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    return result;
  }
}