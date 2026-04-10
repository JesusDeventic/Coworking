import 'package:flutter/material.dart';
import 'package:vacoworking/generated/l10n.dart';

class AppTranslator {
  
  /// Traduce los servicios que vienen del Backend (WordPress)
  static String translateService(BuildContext context, String key) {
    final s = S.current;
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
