import 'package:vacoworking/model/user_model.dart';
import 'package:vacoworking/model/app_status_model.dart';

/// Token en memoria (se persiste en secure storage).
String globalUserToken = '';

/// Usuario actual (se rellena al validar token o al hacer login/registro).
VACoworkingUser globalCurrentUser = VACoworkingUser();

/// Versión de la app (se carga en el splash).
String globalCurrentVersionApp = '';

/// Estado de la app en el servidor (versión mínima, mantenimiento, etc.).
VACoworkingAppStatus? globalServerAppStatus;

/// Idiomas soportados (claves para el selector), orden alfabético por clave como en Fitcron.
const List<String> languageKeys = [
  'ar', 'ca', 'de', 'en', 'es', 'fr', 'hi', 'id', 'it', 'ja', 'ko',
  'nl', 'pl', 'pt', 'ro', 'ru', 'sv', 'tr', 'uk', 'zh',
];


