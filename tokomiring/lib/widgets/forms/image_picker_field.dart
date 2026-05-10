// lib/widgets/forms/image_picker_field.dart

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ImagePickerField
    extends StatelessWidget {
  final PlatformFile? file;

  final VoidCallback onPick;

  final String title;

  const ImagePickerField({
    super.key,
    required this.file,
    required this.onPick,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPick,

      child: Container(
        width: double.infinity,
        height: 220,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(20),

          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),

        child: file == null
            ? Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.image,
                    size: 70,
                    color: Colors.grey,
                  ),

                  const SizedBox(height: 14),

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              )
            : ClipRRect(
                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
                child: Image.memory(
                  file!.bytes!,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
