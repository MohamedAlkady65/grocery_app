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
    apiKey: 'AIzaSyCKwEzXQpEOTM7rMe0M6aQXFxBUWpWc6eA',
    appId: '1:31140963498:web:027c8f6199de7e1857dcd3',
    messagingSenderId: '31140963498',
    projectId: 'grocery-app-65',
    authDomain: 'grocery-app-65.firebaseapp.com',
    storageBucket: 'grocery-app-65.appspot.com',
    measurementId: 'G-VLF8EWXVK1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBEwVxEXsI7BpRtx3WZmVwklwQAfBwoC2s',
    appId: '1:31140963498:android:44a33cde60f8c40457dcd3',
    messagingSenderId: '31140963498',
    projectId: 'grocery-app-65',
    storageBucket: 'grocery-app-65.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDMVkVlSN4hMV_2J9Tjv_voXQXjJ_euzVU',
    appId: '1:31140963498:ios:d1eef944c246432657dcd3',
    messagingSenderId: '31140963498',
    projectId: 'grocery-app-65',
    storageBucket: 'grocery-app-65.appspot.com',
    iosClientId: '31140963498-4sooe962pjphimq3g00k45m1mcgm5ppf.apps.googleusercontent.com',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDMVkVlSN4hMV_2J9Tjv_voXQXjJ_euzVU',
    appId: '1:31140963498:ios:cbd16b1913238b8357dcd3',
    messagingSenderId: '31140963498',
    projectId: 'grocery-app-65',
    storageBucket: 'grocery-app-65.appspot.com',
    iosClientId: '31140963498-qmoieamlfpc2069h2t1jqqu07ofsjk8q.apps.googleusercontent.com',
    iosBundleId: 'com.example.groceryApp.RunnerTests',
  );
}
