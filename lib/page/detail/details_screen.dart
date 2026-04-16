import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacoworking/core/utils/app_translator.dart';
import 'package:vacoworking/generated/l10n.dart';
import 'package:vacoworking/providers/language_provider.dart';
import 'package:vacoworking/widget/components_widgets.dart';
import '../../model/coworking.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  final Coworking coworking;

  const DetailsScreen({super.key, required this.coworking});

  String _cleanString(String description) {
    return description
        .replaceAll(RegExp(r'<P>', caseSensitive: false), '')
        .replaceAll(RegExp(r'</P>', caseSensitive: false), '')
        .trim();
  }

  Future<void> _contact(String contactText) async {
    final Uri url = Uri.parse(contactText);
    if (!await launchUrl(url)) {
      throw Exception(S.current.couldNotOpenContact + contactText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Scaffold(
          appBar: AppBar(title: Text(coworking.name)),
          body: 
          SafeArea(
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
                      Text(_cleanString(coworking.description)),
                      const SizedBox(height: 20),

                      Text(
                        S.current.services,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        children: coworking.services
                            .map(
                              (s) => Chip(
                                label: Text(
                                  AppTranslator.translateService(context, s),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        S.current.equipment,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: coworking.equipment
                            .map(
                              (e) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.indigo.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.indigo.withValues(alpha: 0.2),
                                  ),
                                ),
                                child: Text(
                                  AppTranslator.translateEquipment(context, e),
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
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                      Text(
                        S.current.contact,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
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
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.language,
                          color: Colors.indigo,
                        ),
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
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
