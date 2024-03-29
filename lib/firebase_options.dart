// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBLOw8156y4m_-vf0nV1ScaAX1FRVjreDU',
    appId: '1:1090521934554:web:8db6cc7f9b700c969813e3',
    messagingSenderId: '1090521934554',
    projectId: 'projectfirebase-f7d00',
    authDomain: 'projectfirebase-f7d00.firebaseapp.com',
    databaseURL: 'https://projectfirebase-f7d00.firebaseio.com',
    storageBucket: 'projectfirebase-f7d00.appspot.com',
    measurementId: 'G-7EXFM70LZE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSCCmV1h-s7if7GUNJIEHJo3Ji_LvryNo',
    appId: '1:1090521934554:android:3c7a253da692ebef9813e3',
    messagingSenderId: '1090521934554',
    projectId: 'projectfirebase-f7d00',
    databaseURL: 'https://projectfirebase-f7d00.firebaseio.com',
    storageBucket: 'projectfirebase-f7d00.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCzcBr98yAAq6b4g7BTix8xumMVg513N4Q',
    appId: '1:1090521934554:ios:ffeb3b490fab0feb9813e3',
    messagingSenderId: '1090521934554',
    projectId: 'projectfirebase-f7d00',
    databaseURL: 'https://projectfirebase-f7d00.firebaseio.com',
    storageBucket: 'projectfirebase-f7d00.appspot.com',
    androidClientId: '1090521934554-9pbcducdvej472a4cktadulpjli45n49.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseLogin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCzcBr98yAAq6b4g7BTix8xumMVg513N4Q',
    appId: '1:1090521934554:ios:b957ea43a6bf1c8c9813e3',
    messagingSenderId: '1090521934554',
    projectId: 'projectfirebase-f7d00',
    databaseURL: 'https://projectfirebase-f7d00.firebaseio.com',
    storageBucket: 'projectfirebase-f7d00.appspot.com',
    androidClientId: '1090521934554-9pbcducdvej472a4cktadulpjli45n49.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseLogin.RunnerTests',
  );
}
