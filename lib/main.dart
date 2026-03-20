import 'dart:io';
import 'package:filmoly/api/filmoly_messaging_service.dart';
import 'package:filmoly/core/global_functions.dart';
import 'package:filmoly/generated/l10n.dart';
import 'package:filmoly/providers/language_provider.dart';
import 'package:filmoly/providers/theme_provider.dart';
import 'package:filmoly/routes/app_router.dart';
import 'package:filmoly/styles/colors.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Cargar versión de la app SIEMPRE al arrancar (como en Fitcron),
  // para que esté disponible incluso tras reload en Web.
  await loadAppVersion();
  // Inicializar notificaciones push solo en Android / iOS / Web
  if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
    try {
      final messaging = FilmolyMessagingService();
      await messaging.initialize();
    } catch (e) {
      debugPrint('Error inicializando notificaciones de Firebase: $e');
    }
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const FilmolyApp(),
    ),
  );
}

class FilmolyApp extends StatefulWidget {
  const FilmolyApp({super.key});

  @override
  State<FilmolyApp> createState() => _FilmolyAppState();
}

class _FilmolyAppState extends State<FilmolyApp> {
  late final GoRouter _router = createAppRouter(navigatorKey);
  final AppLinks _appLinks = AppLinks();

  Uri? _lastHandledUri;

  @override
  void initState() {
    super.initState();

    // `app_links` no está implementado en Windows.
    // Para deep links nativos solo lo activamos en Android/iOS.
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      _handleInitialUri();
      _appLinks.uriLinkStream.listen((uri) {
        _handleIncomingUri(uri);
      });
    }
  }

  Future<void> _handleInitialUri() async {
    try {
      final uri = await _appLinks.getInitialLink();
      if (uri != null) _handleIncomingUri(uri);
    } catch (_) {
      // Ignoramos errores de deep link silenciosamente para no romper el arranque.
    }
  }

  void _handleIncomingUri(Uri uri) {
    if (!mounted) return;
    if (_lastHandledUri == uri) return;
    _lastHandledUri = uri;

    final path = uri.path;
    if (path.startsWith('/user/')) {
      final ctx = navigatorKey.currentContext;
      if (ctx == null) return;
      ctx.go(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LanguageProvider>(
      builder: (context, themeProvider, languageProvider, _) {
        return MaterialApp.router(
          routerConfig: _router,
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) => S.current.appName,
          theme: themeProvider.isDarkMode ? darkTheme : lightTheme,
          locale: Locale(languageProvider.currentLanguage),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}

// ============================================================================
// NOTA PARA DUPLICAR ESTE PROYECTO COMO BASE DE OTRA APP
// ============================================================================
// Si copias este proyecto para crear otra app distinta, revisa y cambia:
//
// 1) Identidad visual
//    - Logo principal y assets:
//      - Sustituir `assets/logo.png` por el logo de la nueva app.
//      - Regenerar iconos con `flutter_launcher_icons` (ver sección `flutter_launcher_icons`
//        en `pubspec.yaml` y ejecutar: `dart run flutter_launcher_icons`).
//    - Icono de notificaciones push Android:
//      - Reemplazar `android/app/src/main/res/drawable/ic_notification.png`
//        por un PNG monocromo (normalmente blanco) del nuevo logo, 24–32 px.
//
// 2) Paquete / identificadores
//    - Cambiar el identificador de paquete:
//      - Android: `applicationId` en `android/app/build.gradle(.kts)` y `package_name`
//        en `android/app/google-services.json`.
//      - iOS: `PRODUCT_BUNDLE_IDENTIFIER` en Xcode (Runner) y `bundle_id` en
//        `ios/Runner/GoogleService-Info.plist`.
//
// 3) Firebase (nuevo proyecto)
//    - Crear proyecto Firebase nuevo y descargar:
//      - `android/app/google-services.json`
//      - `ios/Runner/GoogleService-Info.plist`
//    - Para Web:
//      - Actualizar `lib/api/firebase_web_config.dart` con la nueva config web
//        (`apiKey`, `appId`, `projectId`, `messagingSenderId`, etc.).
//      - Actualizar la `webVapidKey` con la Web Push key del nuevo proyecto.
//
// 4) WordPress / API backend
//    - Cambiar la URL base en `lib/api/filmoly_api.dart`:
//      - Constante `filmolyBaseUrl` debe apuntar al nuevo dominio / namespace REST.
//    - Revisar endpoints específicos copiados de Filmoly:
//      - `wordpress_backend/*.php` (login.php, usuario.php, notificaciones.php,
//        app-status.php, recaptcha.php, etc.) y adaptar:
//        - Prefijos (`filmoly_...`) si quieres nuevos nombres.
//        - Rutas REST (`filmoly/v1/...`) si cambias el namespace.
//
// 5) Push notifications (servidor)
//    - Si usas FCM HTTP v1:
//      - Generar una nueva Service Account en el proyecto Firebase nuevo.
//      - Subir el JSON a tu servidor (ruta segura) y ajustar en `wp-config.php`:
//        - `FILMOLY_FIREBASE_PROJECT_ID` (nuevo ID de proyecto).
//        - `FILMOLY_FIREBASE_SERVICE_ACCOUNT_PATH` (ruta al JSON).
//    - Revisar `wordpress_backend/notificaciones.php` y `WebPage_NotificacionesPush.php`
//      por si quieres cambiar textos o comportamiento.
//
// 6) Branding / textos específicos
//    - Revisar ARB de localización en `lib/l10n/*.arb`:
//      - Nombre de la app (`appName`) y cualquier referencia a "Filmoly".
//      - FAQs, textos de contacto, políticas, etc.
//    - Regenerar l10n con `dart run intl_utils:generate` (o desde el IDE).
//
// 7) Otros puntos a revisar
//    - Tema de colores en `lib/styles/colors.dart`:
//      - Cambiar `AppColors.primary`, `secondary`, etc. si la nueva app usa otros colores.
//    - URLs externas (web, soporte, redes sociales) en:
//      - `lib/page/users/contact_page.dart`
//      - Cualquier otro lugar donde aparezcan dominios o paths de Filmoly.
//
// Con estos cambios, este proyecto sirve como plantilla reutilizable para nuevas apps
// que compartan la misma estructura técnica pero con otra marca / backend / Firebase.
