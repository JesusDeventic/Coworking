import 'package:vacoworking/model/coworking.dart';

final List<Coworking> mockCoworkings = [
  Coworking(
    id: "1",
    name: "Coworking Valladolid Centro",
    address: "Calle Santiago 12",
    description: "Espacio moderno en el centro de la ciudad...",
    latitude: 41.6523,
    longitude: -4.7245,
    images: [
      "https://picsum.photos/400",
      "https://picsum.photos/401"
    ],
    services: ["WiFi", "Café", "Impresora"],
    equipment: ["Proyector", "Pantalla"],
    rooms: [
      Room(
        name: "Sala 1",
        capacity: 8,
        equipment: ["TV", "Pizarra"],
      )
    ],
    phone: "123456789",
    email: "info@coworking.com",
    website: "https://coworking.com",
  ),
  Coworking(
    id: "2",
    name: "Coworking Valladolid Rio",
    address: "P° Isabel la Catolica 25",
    description: "Espacio moderno junto al rio de la ciudad...",
    latitude: 41.6574,
    longitude: -4.7316,
    images: [
      "https://picsum.photos/402",
      "https://picsum.photos/403"
    ],
    services: ["WiFi", "Café", "Impresora","Sala de reuniones", "Sala de descanso"],
    equipment: ["Proyector", "Pantalla", "Taquillas", "Sillones y Sofas"],
    rooms: [
      Room(
        name: "Sala 1",
        capacity: 12,
        equipment: ["TV", "Pizarra", "Proyector"],
      ),
      Room(
        name: "Sala 2",
        capacity: 10,
        equipment: ["TV", "Pizarra"],
      ),
      Room(
        name: "Sala 3",
        capacity: 7,
        equipment: ["TV", "Sillones y Sofas", "Taquillas"],
      )
    ],
    phone: "234567890",
    email: "info@coworking.com",
    website: "https://coworking.com",
  ),
   Coworking(
    id: "3",
    name: "Coworking Valladolid Campo Grande",
    address: "C. Acera de Recoletos 9",
    description: "Espacio moderno junto al parque Campo Grande...",
    latitude: 41.6462,
    longitude: -4.7278,
    images: [
      "https://picsum.photos/404",
      "https://picsum.photos/405"
    ],
    services: ["WiFi", "Café", "Impresora","Sala de reuniones"],
    equipment: ["Proyector", "Pantalla", "Taquillas",],
    rooms: [
      Room(
        name: "Sala 1",
        capacity: 10,
        equipment: ["TV", "Pizarra", "Proyector"],
      ),
      Room(
        name: "Sala 2",
        capacity: 8,
        equipment: ["TV", "Pizarra"],
      ),
    ],
    phone: "345678912",
    email: "info@coworking.com",
    website: "https://coworking.com",
  ),
];