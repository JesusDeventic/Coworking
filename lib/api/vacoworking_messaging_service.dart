import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vacoworking/api/firebase_web_config.dart';
import 'package:vacoworking/core/global_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vacoworking/generated/l10n.dart';
import 'package:vacoworking/styles/colors.dart';

/// Servicio centralizado de notificaciones push (Android / iOS / Web),
/// alineado con Fitcron: Firebase sin opciones en nativo, opciones solo en Web.
class VACoworkingMessagingService {
  FirebaseMessaging? _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    try {
      if (kIsWeb) {
        final o = VACoworkingFirebaseWebConfig.webFirebaseOptions;
        if (o.apiKey.isEmpty ||
            o.appId.isEmpty ||
            o.messagingSenderId.isEmpty ||
            o.projectId.isEmpty) {
          debugPrint(
            'FCM Web no configurado: rellena VACoworkingFirebaseWebConfig',
          );
          return;
        }
        await Firebase.initializeApp(options: o);
      } else {
        await Firebase.initializeApp();
      }

      _firebaseMessaging = FirebaseMessaging.instance;

      if (!kIsWeb) {
        const androidInit = AndroidInitializationSettings('ic_notification');
        const iosInit = DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
        const initSettings = InitializationSettings(
          android: androidInit,
          iOS: iosInit,
        );

        await _flutterLocalNotificationsPlugin.initialize(
          initSettings,
          onDidReceiveNotificationResponse: (NotificationResponse response) {
            debugPrint('Notificación tocada: ${response.payload}');
          },
        );
      }

      await _firebaseMessaging?.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // Modo sin login: forzar sincronización push al iniciar para
      // suscribirse al topic global en Android/iOS.
      try {
        await syncPushConfig();
      } catch (e) {
        debugPrint('Error syncPushConfig en initialize(): $e');
      }

      // Log útil para depurar dispositivos que no reciben push.
      try {
        final settings = await _firebaseMessaging?.getNotificationSettings();
        final token = kIsWeb
            ? await _firebaseMessaging?.getToken(
                vapidKey: VACoworkingFirebaseWebConfig.webVapidKey,
              )
            : await _firebaseMessaging?.getToken();
        debugPrint(
          'FCM status: ${settings?.authorizationStatus} | token: ${token == null ? 'null' : token.substring(0, token.length > 18 ? 18 : token.length)}...',
        );
      } catch (e) {
        debugPrint('Error leyendo estado/token FCM: $e');
      }

      if (!kIsWeb) {
        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
          debugPrint('Mensaje FCM en primer plano: ${message.messageId}');

          final title = message.notification?.title ?? S.current.appName;
          final body = message.notification?.body ?? S.current.notificationsLabel;

          await _showNotification(
            title: title,
            body: body,
            payload: message.data.toString(),
          );
        });
      }

      FirebaseMessaging.onBackgroundMessage(
        _VACoworkingFirebaseMessagingBackgroundHandler,
      );

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint('App abierta desde notificación: ${message.messageId}');
      });

      _firebaseMessaging?.onTokenRefresh.listen((_) async {
        try {
          await syncPushConfig();
        } catch (_) {}
      });
    } catch (e) {
      debugPrint('Error inicializando VACoworkingMessagingService: $e');
    }
  }

  Future<void> _showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    if (kIsWeb) return;

    const androidDetails = AndroidNotificationDetails(
      'VACoworking_channel',
      'VACoworking Notifications',
      channelDescription: 'Canal de notificaciones de VACoworking',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      icon: 'ic_notification',
      color: AppColors.primary,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: payload,
    );
  }
}

@pragma('vm:entry-point')
Future<void> _VACoworkingFirebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: VACoworkingFirebaseWebConfig.webFirebaseOptions,
      );
    } else {
      await Firebase.initializeApp();
    }
    debugPrint('Mensaje FCM en segundo plano: ${message.messageId}');
  } catch (e) {
    debugPrint('Error en background handler FCM VACoworking: $e');
  }
}


