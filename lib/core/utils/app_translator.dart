import 'package:flutter/material.dart';
import 'package:vacoworking/generated/l10n.dart';

class AppTranslator {
  /// Traduce los servicios que vienen del Backend (WordPress)
  static String translateService(BuildContext context, String key) {
    // Obtener el locale actual del contexto
    final currentLocale = Localizations.localeOf(context);

    // Debug para verificar el locale
    print("DEBUG: Locale del contexto: ${currentLocale.languageCode}");
    print("DEBUG: Buscando clave: '$key'");

    // Usar S.of(context) que debería tener el locale correcto
    final s = S.current;
    print("DEBUG: service_coffeedrinks = '${s.service_coffeedrinks}'");

    // Mapa de equivalencias: Backend Key -> ARB Value
    final Map<String, String> services = {
      'Café / bebidas': s.service_coffeedrinks,
      'Seguridad 24h': s.service_security,
      'Acceso 24/7': s.service_access,
    };

    final result = services[key] ?? key;
    print("DEBUG: Resultado final: '$result'");

    return result;
  }
}
