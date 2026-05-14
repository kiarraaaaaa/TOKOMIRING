import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage
      _storage =
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
        withData: true,
        allowCompression:
            true,
      );

      if (result == null ||
          result.files.isEmpty) {
        return null;
      }

      final file =
          result.files.first;

      if (file.bytes == null ||
          file.bytes!.isEmpty) {
        throw Exception(
          'Image bytes not found',
        );
      }

      final extension =
          file.extension
                  ?.toLowerCase() ??
              '';

      final allowed = [
        'jpg',
        'jpeg',
        'png',
        'webp',
      ];

      if (!allowed.contains(
        extension,
      )) {
        throw Exception(
          'Invalid image format',
        );
      }

      final sizeInMb =
          file.size /
              (1024 * 1024);

      if (sizeInMb > 10) {
        throw Exception(
          'Image max 10MB',
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
      if (imageBytes.isEmpty) {
        throw Exception(
          'Image is empty',
        );
      }

      final safeName =
          _safeFileName(
        fileName,
      );

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
        cacheControl:
            'public,max-age=3600',
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
      if (file.bytes == null ||
          file.bytes!.isEmpty) {
        throw Exception(
          'Image data empty',
        );
      }

      final Uint8List
          imageData =
          file.bytes!;

      final safeId =
          _safeFileName(
        productId,
      );

      final ref =
          _storage
              .ref()
              .child(
                'product_images/$safeId.jpg',
              );

      final metadata =
          SettableMetadata(
        contentType:
            'image/jpeg',
        cacheControl:
            'public,max-age=3600',
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
      if (file.bytes == null ||
          file.bytes!.isEmpty) {
        throw Exception(
          'Image data empty',
        );
      }

      final Uint8List
          imageData =
          file.bytes!;

      final safeUid =
          _safeFileName(
        uid,
      );

      final ref =
          _storage
              .ref()
              .child(
                'profile_images/$safeUid.jpg',
              );

      final metadata =
          SettableMetadata(
        contentType:
            'image/jpeg',
        cacheControl:
            'public,max-age=3600',
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
      if (file.bytes == null ||
          file.bytes!.isEmpty) {
        throw Exception(
          'Image data empty',
        );
      }

      final Uint8List
          imageData =
          file.bytes!;

      final safeId =
          _safeFileName(
        orderId,
      );

      final ref =
          _storage
              .ref()
              .child(
                'payment_proofs/$safeId.jpg',
              );

      final metadata =
          SettableMetadata(
        contentType:
            'image/jpeg',
        cacheControl:
            'public,max-age=3600',
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
      if (imageUrl
          .trim()
          .isEmpty) {
        return;
      }

      if (!imageUrl.startsWith(
        'https://',
      )) {
        return;
      }

      await _storage
          .refFromURL(
            imageUrl,
          )
          .delete();
    } catch (_) {}
  }

  // =====================================================
  // GENERIC IMAGE
  // =====================================================

  Future<String> uploadImage({
    required PlatformFile file,
    required String folderName,
    required String fileName,
  }) async {
    try {
      if (file.bytes == null ||
          file.bytes!.isEmpty) {
        throw Exception(
          'Image data empty',
        );
      }

      final Uint8List
          imageData =
          file.bytes!;

      final safeFolder =
          _safeFileName(
        folderName,
      );

      final safeFile =
          _safeFileName(
        fileName,
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
        cacheControl:
            'public,max-age=3600',
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
  // SAFE FILE NAME
  // =====================================================

  String _safeFileName(
    String value,
  ) {
    return value
        .replaceAll(
          ' ',
          '_',
        )
        .replaceAll(
          '/',
          '_',
        )
        .replaceAll(
          '\\',
          '_',
        )
        .trim();
  }

  // =====================================================
  // IMAGE URL CHECK
  // =====================================================

  bool isNetworkImage(
    String value,
  ) {
    return value
            .trim()
            .startsWith(
              'https://',
            ) ||
        value
            .trim()
            .startsWith(
              'http://',
            );
  }

  // =====================================================
  // VALID IMAGE CHECK
  // =====================================================

  bool hasValidImage(
    String value,
  ) {
    return value
        .trim()
        .isNotEmpty;
  }
}