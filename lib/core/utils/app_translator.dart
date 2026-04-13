import 'package:flutter/material.dart';
import 'package:vacoworking/generated/l10n.dart';

class AppTranslator {
  
  /// Traduce los servicios que vienen del Backend (WordPress)
  static String translateService(BuildContext context, String key) {
    final s = S.current;
    // Mapa de equivalencias: Backend Key -> ARB Value
    final Map<String, String> services = {
      'Acceso 24/7': s.service_access,
      'Domiciliación Fiscal': s.service_fiscal_domiciliation,
      'Limpieza': s.service_cleaning,
      'WiFi': s.service_wifi,
      'Acceso autónomo': s.service_autonomous_access,
      'Domiciliación Social': s.service_social_domiciliation,
      'Networking': s.service_networking,
      'Workshops': s.service_workshops,
      'Atención telefónica': s.service_phone_support,
      'Eventos': s.service_events,
      'Recepción': s.service_reception,
      'Zona relax': s.service_relax_zone,
      'Café / bebidas': s.service_coffee_beverages,
      'Formación': s.service_training,
      'Recepción de correo': s.service_mail_reception,
      'Catering': s.service_catering,
      'Gestión administrativa': s.service_administrative_management,
      'Seguridad 24h': s.service_security,
    };

    final result = services[key] ?? key;
    return result;
  }
}
