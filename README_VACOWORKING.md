# VACoworking (clon desde proyecto base)

Proyecto Flutter con paquete Dart **`VACoworking`**.

## API / backend WordPress

- **URL base en la app:** `lib/api/VACoworking_api.dart` → `VACoworkingBaseUrl`  
  Por defecto: `https://TU-DOMINIO/wp-json/VACoworking/v1`
- **Namespace REST en PHP:** todos los `register_rest_route` usan **`VACoworking/v1`**.

## wp-config.php (constantes nuevas)

Define en **`wp-config.php`** (antes de `require wp-settings.php`):

```php
define('VACoworking_FIREBASE_PROJECT_ID', 'VACoworking');
define('VACoworking_FIREBASE_SERVICE_ACCOUNT_PATH', ABSPATH . 'wp-content/VACoworking-firebase-adminsdk.json');
define('VACoworking_RECAPTCHA_SECRET_KEY', 'tu_secret_recaptcha_v3');
```

(Ajusta rutas y valores a tu entorno; el nombre del JSON de service account es el que subas desde Firebase.)

## Firebase (app)

- Android: `android/app/google-services.json`
- iOS: `ios/Runner/GoogleService-Info.plist`
- Web: `lib/api/firebase_web_config.dart` + `webVapidKey`

## Otros

- Tras editar ARBs: `dart run intl_utils:generate`
- Deep links de ejemplo: `app.VACoworking.com` (Android manifest + iOS associated domains)
- Preferencias locales: claves `VACoworking_*` en `user_preferences` / `secure_storage` (no comparten datos con el proyecto base)

Los **metadatos de usuario en WordPress** (p. ej. `VACoworking_language`, tablas `wp_VACoworking_*`, etc.) se esperan con el prefijo nuevo en PHP.

