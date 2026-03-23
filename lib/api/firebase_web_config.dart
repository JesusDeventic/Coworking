import 'package:firebase_core/firebase_core.dart';

/// Solo Web necesita `FirebaseOptions` explícitas; iOS/Android usan
/// `GoogleService-Info.plist` / `google-services.json` (y en iOS `FirebaseApp.configure()`).
///
/// Clave VAPID: Firebase Console → Project settings → Cloud Messaging →
/// Web Push certificates → Key pair (la pública empieza por `B` o `BC`).
class VACoworkingFirebaseWebConfig {
  static const FirebaseOptions webFirebaseOptions = FirebaseOptions(
    apiKey: 'AIzaSyCwtcpfZSr8pQXJTMeepqBFVwTILO_NbhA',
    appId: '1:690823771522:web:a375f69d0b18a64e82cb9b',
    messagingSenderId: '690823771522',
    projectId: 'va-coworking',
    authDomain: 'va-coworking.firebaseapp.com',
    storageBucket: 'va-coworking.firebasestorage.app',
  );

  /// Web Push: misma clave pública que en Firebase → Cloud Messaging → Web Push certificates.
  static const String webVapidKey =
      'BH2E98QK4wVVFsDg83rU_1of_wm6wXgMfkH3wrwozgpEcrCTfYlw9alxp8C2APdCfwKsfnZVtvj-08ffNikOSOo';
}
