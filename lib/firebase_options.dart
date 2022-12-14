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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCedALMGgQ1nsUo142ojziP5EHe7-Exoog',
    appId: '1:930712252135:web:afbbf8136cae687de03c42',
    messagingSenderId: '930712252135',
    projectId: 'boothflutter-50442',
    authDomain: 'boothflutter-50442.firebaseapp.com',
    storageBucket: 'boothflutter-50442.appspot.com',
    measurementId: 'G-9YX7G5BRK1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBv4rj0i3q4DeikRXTfN1beGBolg-cwLrE',
    appId: '1:930712252135:android:37cd9e3f42db2963e03c42',
    messagingSenderId: '930712252135',
    projectId: 'boothflutter-50442',
    storageBucket: 'boothflutter-50442.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBkRRjgVy-Vyd8mRseoPy-gvE4E4MqRuzg',
    appId: '1:930712252135:ios:444b6b16f60d70c1e03c42',
    messagingSenderId: '930712252135',
    projectId: 'boothflutter-50442',
    storageBucket: 'boothflutter-50442.appspot.com',
    androidClientId: '930712252135-3fr630vqv9s2d5us6mqvqd27pi0bd589.apps.googleusercontent.com',
    iosClientId: '930712252135-nmt8eeir5hgpqgg0b81ktsii23jne31j.apps.googleusercontent.com',
    iosBundleId: 'com.example.mybooth',
  );
}
