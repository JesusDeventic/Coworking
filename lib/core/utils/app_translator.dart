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

   /// Traduce los equipamientos que vienen del Backend (WordPress)
  static String translateEquipment(BuildContext context, String key) {
    final s = S.current;
    // Mapa de equivalencias: Backend Key -> ARB Value
    final Map<String, String> equipment = {
      'Aire acondicionado': s.equipment_air_conditioning,
      'Despacho privado': s.equipment_private_office,
      'Jardín': s.equipment_garden,
      'Pizarras': s.equipment_whiteboards,
      'Sillas ergonómicas': s.equipment_ergonomic_chairs,
      'Armarios': s.equipment_closets,
      'Escáner': s.equipment_scanner,
      'Mesas individuales': s.equipment_individual_tables,
      'Proyector': s.equipment_projector,
      'Taquillas': s.equipment_lockers,
      'Cajoneras con llave': s.equipment_lockers_with_keys,
      'Fibra óptica': s.equipment_fiber_optic,
      'Pantallas/Monitores': s.equipment_screens_monitors,
      'Red cableada': s.equipment_wired_network,
      'Televisión': s.equipment_television,
      'Calefacción': s.equipment_heating,
      'Fotocopiadora': s.equipment_copier,
      'Parking': s.equipment_parking,
      'Sala de juegos': s.equipment_game_room,
      'Terraza': s.equipment_terrace,
      'Cocina': s.equipment_kitchen,
      'Impresora': s.equipment_printer,
      'Parking bicicletas': s.equipment_bike_parking,
      'Salas de reuniones': s.equipment_meeting_rooms,
    };

    final result = equipment[key] ?? key;
    return result;
  }
}
