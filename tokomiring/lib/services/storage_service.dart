// lib/services/storage_service.dart

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage =
      FirebaseStorage.instance;

  // =====================================================
  // PICK IMAGE
  // =====================================================

  Future<PlatformFile?> pickImage() async {
    try {
      final result =
          await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );

      if (result == null) {
        return null;
      }

      return result.files.first;
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
      final ref = _storage
          .ref()
          .child(
            'products/$fileName',
          );

      final uploadTask =
          await ref.putData(
        imageBytes,
      );

      final imageUrl =
          await uploadTask.ref
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

  Future<String> uploadProductImage({
    required PlatformFile file,
    required String productId,
  }) async {
    try {
      Uint8List imageData =
          file.bytes!;

      final ref = _storage
          .ref()
          .child(
            'product_images/$productId.jpg',
          );

      UploadTask uploadTask =
          ref.putData(imageData);

      TaskSnapshot snapshot =
          await uploadTask;

      String downloadUrl =
          await snapshot.ref.getDownloadURL();

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

  Future<String> uploadProfileImage({
    required PlatformFile file,
    required String uid,
  }) async {
    try {
      Uint8List imageData =
          file.bytes!;

      final ref = _storage
          .ref()
          .child(
            'profile_images/$uid.jpg',
          );

      UploadTask uploadTask =
          ref.putData(imageData);

      TaskSnapshot snapshot =
          await uploadTask;

      String downloadUrl =
          await snapshot.ref.getDownloadURL();

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

  Future<String> uploadPaymentProof({
    required PlatformFile file,
    required String orderId,
  }) async {
    try {
      Uint8List imageData =
          file.bytes!;

      final ref = _storage
          .ref()
          .child(
            'payment_proofs/$orderId.jpg',
          );

      UploadTask uploadTask =
          ref.putData(imageData);

      TaskSnapshot snapshot =
          await uploadTask;

      String downloadUrl =
          await snapshot.ref.getDownloadURL();

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
      await _storage
          .refFromURL(imageUrl)
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
      Uint8List imageData =
          file.bytes!;

      final ref = _storage
          .ref()
          .child(
            '$folderName/$fileName.jpg',
          );

      UploadTask uploadTask =
          ref.putData(imageData);

      TaskSnapshot snapshot =
          await uploadTask;

      String downloadUrl =
          await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }
}