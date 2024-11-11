// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD_FUV3lVWPsCGDASA0-41diFquSw8Ez-s',
    appId: '1:541612893658:web:14faaacbfdf8b5ddd0cce3',
    messagingSenderId: '541612893658',
    projectId: 'oxdo-auth',
    authDomain: 'oxdo-auth.firebaseapp.com',
    storageBucket: 'oxdo-auth.firebasestorage.app',
    measurementId: 'G-441S583JGP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA61kCv9JJqTayTYIIfNbPuVjXnP5qBWKU',
    appId: '1:541612893658:android:6421c18f1c2f2792d0cce3',
    messagingSenderId: '541612893658',
    projectId: 'oxdo-auth',
    storageBucket: 'oxdo-auth.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAz9jemKPB8-ZyzN9518x3CAY0betsYXfo',
    appId: '1:541612893658:ios:50a23881a4f16394d0cce3',
    messagingSenderId: '541612893658',
    projectId: 'oxdo-auth',
    storageBucket: 'oxdo-auth.firebasestorage.app',
    iosBundleId: 'com.oxdotechnologies.oxdoAuth',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAz9jemKPB8-ZyzN9518x3CAY0betsYXfo',
    appId: '1:541612893658:ios:50a23881a4f16394d0cce3',
    messagingSenderId: '541612893658',
    projectId: 'oxdo-auth',
    storageBucket: 'oxdo-auth.firebasestorage.app',
    iosBundleId: 'com.oxdotechnologies.oxdoAuth',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD_FUV3lVWPsCGDASA0-41diFquSw8Ez-s',
    appId: '1:541612893658:web:95848ae87cd7f461d0cce3',
    messagingSenderId: '541612893658',
    projectId: 'oxdo-auth',
    authDomain: 'oxdo-auth.firebaseapp.com',
    storageBucket: 'oxdo-auth.firebasestorage.app',
    measurementId: 'G-S4Q77QT15Z',
  );
}
