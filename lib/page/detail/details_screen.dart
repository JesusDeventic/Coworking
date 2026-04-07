import 'package:flutter/material.dart';
import 'package:vacoworking/generated/l10n.dart';
import '../../model/coworking.dart'; //Modelo importado
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  final Coworking coworking;

  const DetailsScreen({super.key, required this.coworking});

  //funcion para los Ontap de contacto
  Future<void> _contact(String contactText) async {
    final Uri url = Uri.parse(
      contactText,
    ); //analizo y guardo el tipo de texto en objeto URI con .parse para saber que hacer
    if (!await launchUrl(url)) {
      //intento abrir apps dependiendo del URI, de con que empezaba. Le pongo ! al principio para cambiar el booleano a false en caso de que sea true y no entre a la excepcion.
      throw Exception(S.current.couldNotOpenContact + contactText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(coworking.name)),
      body: SingleChildScrollView(
        // Para que se pueda hacer scroll si hay mucho texto
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Galería de Imágenes
            SizedBox(
              height: 250,
              child: PageView.builder(
                itemCount: coworking.images.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    coworking.images[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coworking.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    coworking.address,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Divider(height: 30),

                  Text(
                    S.current.description,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(coworking.description),
                  const SizedBox(height: 20),

                  Text(
                    S.current.services,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // 2. Chips para los servicios
                  Wrap(
                    spacing: 8,
                    children: coworking.services
                        .map((s) => Chip(label: Text(s)))
                        .toList(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    S.current.equipment,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8, // Espaciado vertical si saltan de línea
                    children: coworking.equipment
                        .map(
                          (e) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.indigo.withValues(
                                alpha: 0.05,
                              ), // Color suave del tema
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.indigo.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Text(
                              e,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.indigo,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 20),
                  Text(
                    S.current.availableRooms,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // 3. Lista de salas, con los 3 puntos iniciales transformo la lista para que children los lea uno por uno y no tener una lista dentro de otra.
                  ...coworking.rooms.map(
                    (room) => ListTile(
                      leading: const Icon(Icons.meeting_room),
                      title: Text(room.name),
                      subtitle: Text(
                        '${S.current.capacity} ${room.capacity} ${S.current.people}',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //4.Contacto
                  Text(
                    S.current.contact,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Uso ListTile para que sea interactivos con onTap
                  ListTile(
                    leading: const Icon(Icons.phone, color: Colors.indigo),
                    title: Text(coworking.phone),
                    onTap: () {
                      _contact('${S.current.tel} ${coworking.phone}');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.email, color: Colors.indigo),
                    title: Text(coworking.email),
                    onTap: () {
                      _contact(
                        "mailto:${coworking.email}?subject=${S.current.contactSubject} ${coworking.name}",
                      ); // Abre el correo con asunto                    },
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.language, color: Colors.indigo),
                    title: Text(
                      coworking.website,
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      _contact(coworking.website);
                    },
                  ),
                  const SizedBox(height: 30), // Espacio final para el scroll
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
