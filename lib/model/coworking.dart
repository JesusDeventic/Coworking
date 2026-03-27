class Coworking {
  final String id;
  final String name;
  final String address;
  final String description;
  final String excerpt;
  final String content;
  final double latitude;
  final double longitude;
  final List<String> images;
  final List<String> services;
  final List<String> equipment;
  final List<Room> rooms;
  final String phone;
  final String email;
  final String website;
  final String schedule;
  final int totalCapacity;
  final int salaMinCapacity;
  final int salaMaxCapacity;
  final String featuredImage;
  final String featuredThumb;

  Coworking({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    this.excerpt = '',
    this.content = '',
    required this.latitude,
    required this.longitude,
    required this.images,
    required this.services,
    required this.equipment,
    required this.rooms,
    required this.phone,
    required this.email,
    required this.website,
    this.schedule = '',
    this.totalCapacity = 0,
    this.salaMinCapacity = 0,
    this.salaMaxCapacity = 0,
    this.featuredImage = '',
    this.featuredThumb = '',
  });

  // Factory constructor para crear desde JSON del backend
  factory Coworking.fromJson(Map<String, dynamic> json) {
    // Extraer datos de ubicación
    final location = json['location'] as Map<String, dynamic>? ?? {};
    final contact = json['contact'] as Map<String, dynamic>? ?? {};
    final capacity = json['capacity'] as Map<String, dynamic>? ?? {};
    final media = json['media'] as Map<String, dynamic>? ?? {};

    // Convertir servicios
    final servicesList = <String>[];
    final servicios = json['servicios'] as List<dynamic>? ?? [];
    for (final servicio in servicios) {
      if (servicio is Map<String, dynamic> && servicio['name'] is String) {
        servicesList.add(servicio['name'] as String);
      }
    }

    // Convertir equipamientos
    final equipmentList = <String>[];
    final equipamientos = json['equipamientos'] as List<dynamic>? ?? [];
    for (final equipamiento in equipamientos) {
      if (equipamiento is Map<String, dynamic> &&
          equipamiento['name'] is String) {
        equipmentList.add(equipamiento['name'] as String);
      }
    }

    // Convertir salas
    final roomsList = <Room>[];
    final salas = json['salas'] as List<dynamic>? ?? [];
    for (final sala in salas) {
      if (sala is Map<String, dynamic>) {
        final roomEquipment = <String>[];
        // Extraer equipamiento de la sala si existe
        if (sala['equipamiento'] is List) {
          for (final equip in sala['equipamiento']) {
            if (equip is String) roomEquipment.add(equip);
          }
        }

        roomsList.add(
          Room(
            name: sala['nombre'] as String? ?? '',
            capacity: sala['capacidad'] as int? ?? 0,
            equipment: roomEquipment,
          ),
        );
      }
    }

    // Convertir imágenes
    final imagesList = <String>[];
    final gallery = media['gallery'] as List<dynamic>? ?? [];
    for (final image in gallery) {
      if (image is String) imagesList.add(image);
    }
    // Añadir imagen destacada si existe
    if (media['featured'] is String &&
        media['featured'].toString().isNotEmpty) {
      imagesList.insert(0, media['featured'] as String);
    }

    return Coworking(
      id: json['id'].toString(),
      name: json['name'] as String? ?? '',
      address: location['direccion'] as String? ?? '',
      description: json['content'] as String? ?? '',
      excerpt: json['excerpt'] as String? ?? '',
      content: json['content'] as String? ?? '',
      latitude: (location['lat'] as num?)?.toDouble() ?? 0.0,
      longitude: (location['lng'] as num?)?.toDouble() ?? 0.0,
      images: imagesList,
      services: servicesList,
      equipment: equipmentList,
      rooms: roomsList,
      phone: contact['telefono'] as String? ?? '',
      email: contact['email'] as String? ?? '',
      website: contact['web'] as String? ?? '',
      schedule: contact['horario'] as String? ?? '',
      totalCapacity: capacity['total'] as int? ?? 0,
      salaMinCapacity: capacity['sala_min'] as int? ?? 0,
      salaMaxCapacity: capacity['sala_max'] as int? ?? 0,
      featuredImage: media['featured'] as String? ?? '',
      featuredThumb: media['featured_thumb'] as String? ?? '',
    );
  }
}

class Room {
  final String name;
  final int capacity;
  final List<String> equipment;

  Room({required this.name, required this.capacity, required this.equipment});
}
