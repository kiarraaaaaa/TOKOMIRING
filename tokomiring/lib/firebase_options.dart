// lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/foundation.dart'
    show
        defaultTargetPlatform,
        kIsWeb,
        TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions
      get currentPlatform {
    // =====================================================
    // WEB
    // =====================================================

    if (kIsWeb) {
      return web;
    }

    // =====================================================
    // MOBILE / DESKTOP
    // =====================================================

    switch (
        defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;

      case TargetPlatform.iOS:
        return ios;

      case TargetPlatform.macOS:
        return macos;

      case TargetPlatform.windows:
        return windows;

      case TargetPlatform.linux:
        return linux;

      default:
        throw UnsupportedError(
          'This platform is not supported.',
        );
    }
  }

  // =====================================================
  // WEB
  // =====================================================

  static const FirebaseOptions web =
      FirebaseOptions(
    apiKey:
        'AIzaSyDWWXS8EFOQCtlawn8e1A-KZjlnuNvlHFU',

    appId:
        '1:306441052093:web:e18cbc866001bfd562bcd4',

    messagingSenderId:
        '306441052093',

    projectId:
        'tokomiring-b6e1b',

    authDomain:
        'tokomiring-b6e1b.firebaseapp.com',

    storageBucket:
        'tokomiring-b6e1b.firebasestorage.app',

    measurementId:
        'G-51JRG9LCEQ',

    databaseURL:
        'https://tokomiring-b6e1b-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  // =====================================================
  // ANDROID
  // =====================================================

  static const FirebaseOptions android =
      FirebaseOptions(
    apiKey:
        'AIzaSyDWWXS8EFOQCtlawn8e1A-KZjlnuNvlHFU',

    appId:
        '1:306441052093:android:e18cbc866001bfd562bcd4',

    messagingSenderId:
        '306441052093',

    projectId:
        'tokomiring-b6e1b',

    storageBucket:
        'tokomiring-b6e1b.firebasestorage.app',

    databaseURL:
        'https://tokomiring-b6e1b-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  // =====================================================
  // IOS
  // =====================================================

  static const FirebaseOptions ios =
      FirebaseOptions(
    apiKey:
        'AIzaSyDWWXS8EFOQCtlawn8e1A-KZjlnuNvlHFU',

    appId:
        '1:306441052093:ios:e18cbc866001bfd562bcd4',

    messagingSenderId:
        '306441052093',

    projectId:
        'tokomiring-b6e1b',

    storageBucket:
        'tokomiring-b6e1b.firebasestorage.app',

    iosBundleId:
        'com.tokomiring.web',

    databaseURL:
        'https://tokomiring-b6e1b-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  // =====================================================
  // MACOS
  // =====================================================

  static const FirebaseOptions macos =
      FirebaseOptions(
    apiKey:
        'AIzaSyDWWXS8EFOQCtlawn8e1A-KZjlnuNvlHFU',

    appId:
        '1:306441052093:macos:e18cbc866001bfd562bcd4',

    messagingSenderId:
        '306441052093',

    projectId:
        'tokomiring-b6e1b',

    storageBucket:
        'tokomiring-b6e1b.firebasestorage.app',

    iosBundleId:
        'com.tokomiring.web',

    databaseURL:
        'https://tokomiring-b6e1b-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  // =====================================================
  // WINDOWS
  // =====================================================

  static const FirebaseOptions windows =
      FirebaseOptions(
    apiKey:
        'AIzaSyDWWXS8EFOQCtlawn8e1A-KZjlnuNvlHFU',

    appId:
        '1:306441052093:web:e18cbc866001bfd562bcd4',

    messagingSenderId:
        '306441052093',

    projectId:
        'tokomiring-b6e1b',

    authDomain:
        'tokomiring-b6e1b.firebaseapp.com',

    storageBucket:
        'tokomiring-b6e1b.firebasestorage.app',

    measurementId:
        'G-51JRG9LCEQ',

    databaseURL:
        'https://tokomiring-b6e1b-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  // =====================================================
  // LINUX
  // =====================================================

  static const FirebaseOptions linux =
      FirebaseOptions(
    apiKey:
        'AIzaSyDWWXS8EFOQCtlawn8e1A-KZjlnuNvlHFU',

    appId:
        '1:306441052093:web:e18cbc866001bfd562bcd4',

    messagingSenderId:
        '306441052093',

    projectId:
        'tokomiring-b6e1b',

    authDomain:
        'tokomiring-b6e1b.firebaseapp.com',

    storageBucket:
        'tokomiring-b6e1b.firebasestorage.app',

    measurementId:
        'G-51JRG9LCEQ',

    databaseURL:
        'https://tokomiring-b6e1b-default-rtdb.asia-southeast1.firebasedatabase.app',
  );
}