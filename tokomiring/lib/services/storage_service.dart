// lib/services/storage_service.dart

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {

  // =====================================================
  // STORAGE
  // =====================================================

  final FirebaseStorage _storage =
      FirebaseStorage.instance;

  // =====================================================
  // PICK IMAGE
  // =====================================================

  Future<PlatformFile?> pickImage()
      async {

    try {

      final result =
          await FilePicker.platform
              .pickFiles(

        type:
            FileType.image,

        allowMultiple:
            false,

        withData:
            true,
      );

      if (result == null ||
          result.files.isEmpty) {

        return null;
      }

      final file =
          result.files.first;

      // ===============================================
      // VALIDATE EMPTY
      // ===============================================

      if (file.bytes == null) {

        throw Exception(
          'Image data not found',
        );
      }

      return file;

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // WEB IMAGE UPLOAD
  // =====================================================

  Future<String> uploadWebImage({

    required Uint8List imageBytes,

    required String fileName,

  }) async {

    try {

      final safeName =
          fileName
              .replaceAll(
                ' ',
                '_',
              )
              .trim();

      final ref =
          _storage
              .ref()
              .child(

                'products/$safeName.jpg',
              );

      final metadata =
          SettableMetadata(

        contentType:
            'image/jpeg',
      );

      final snapshot =
          await ref.putData(

        imageBytes,

        metadata,
      );

      final imageUrl =
          await snapshot.ref
              .getDownloadURL();

      return imageUrl;

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // PRODUCT IMAGE
  // =====================================================

  Future<String>
      uploadProductImage({

    required PlatformFile file,

    required String productId,

  }) async {

    try {

      if (file.bytes == null) {

        throw Exception(
          'Image data is empty',
        );
      }

      final Uint8List
          imageData =
          file.bytes!;

      final ref =
          _storage
              .ref()
              .child(

                'product_images/$productId.jpg',
              );

      final metadata =
          SettableMetadata(

        contentType:
            'image/jpeg',
      );

      final uploadTask =
          ref.putData(

        imageData,

        metadata,
      );

      final snapshot =
          await uploadTask;

      final downloadUrl =
          await snapshot.ref
              .getDownloadURL();

      return downloadUrl;

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // PROFILE IMAGE
  // =====================================================

  Future<String>
      uploadProfileImage({

    required PlatformFile file,

    required String uid,

  }) async {

    try {

      if (file.bytes == null) {

        throw Exception(
          'Image data is empty',
        );
      }

      final Uint8List
          imageData =
          file.bytes!;

      final ref =
          _storage
              .ref()
              .child(

                'profile_images/$uid.jpg',
              );

      final metadata =
          SettableMetadata(

        contentType:
            'image/jpeg',
      );

      final uploadTask =
          ref.putData(

        imageData,

        metadata,
      );

      final snapshot =
          await uploadTask;

      final downloadUrl =
          await snapshot.ref
              .getDownloadURL();

      return downloadUrl;

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // PAYMENT PROOF
  // =====================================================

  Future<String>
      uploadPaymentProof({

    required PlatformFile file,

    required String orderId,

  }) async {

    try {

      if (file.bytes == null) {

        throw Exception(
          'Image data is empty',
        );
      }

      final Uint8List
          imageData =
          file.bytes!;

      final ref =
          _storage
              .ref()
              .child(

                'payment_proofs/$orderId.jpg',
              );

      final metadata =
          SettableMetadata(

        contentType:
            'image/jpeg',
      );

      final uploadTask =
          ref.putData(

        imageData,

        metadata,
      );

      final snapshot =
          await uploadTask;

      final downloadUrl =
          await snapshot.ref
              .getDownloadURL();

      return downloadUrl;

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // DELETE IMAGE
  // =====================================================

  Future<void> deleteImage(
    String imageUrl,
  ) async {

    try {

      if (imageUrl.isEmpty) {

        return;
      }

      await _storage
          .refFromURL(
            imageUrl,
          )
          .delete();

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // GENERIC IMAGE UPLOAD
  // =====================================================

  Future<String> uploadImage({

    required PlatformFile file,

    required String folderName,

    required String fileName,

  }) async {

    try {

      if (file.bytes == null) {

        throw Exception(
          'Image data is empty',
        );
      }

      final Uint8List
          imageData =
          file.bytes!;

      final safeFolder =
          folderName
              .replaceAll(
                ' ',
                '_',
              );

      final safeFile =
          fileName
              .replaceAll(
                ' ',
                '_',
              );

      final ref =
          _storage
              .ref()
              .child(

                '$safeFolder/$safeFile.jpg',
              );

      final metadata =
          SettableMetadata(

        contentType:
            'image/jpeg',
      );

      final uploadTask =
          ref.putData(

        imageData,

        metadata,
      );

      final snapshot =
          await uploadTask;

      final downloadUrl =
          await snapshot.ref
              .getDownloadURL();

      return downloadUrl;

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }
}