class Coworking {
  final String id;
  final String name;
  final String address;
  final String description;
  final double latitude;
  final double longitude;
  final List<String> images;
  final List<String> services;
  final List<String> equipment;
  final List<Room> rooms;
  final String phone;
  final String email;
  final String website;

  Coworking({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.images,
    required this.services,
    required this.equipment,
    required this.rooms,
    required this.phone,
    required this.email,
    required this.website,
  });
}

class Room {
  final String name;
  final int capacity;
  final List<String> equipment;

  Room({required this.name, required this.capacity, required this.equipment});
}
