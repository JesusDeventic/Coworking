import 'package:vacoworking/core/utils/app_translator.dart';
import 'package:vacoworking/generated/l10n.dart';
import 'package:vacoworking/page/detail/details_screen.dart'; //Pantalla detalles importada
import 'package:flutter/material.dart';
import 'dart:async'; // Para Timer
import 'package:flutter_map/flutter_map.dart'; // El paquete del mapa
import 'package:latlong2/latlong.dart'; // Para manejar coordenadas
import 'package:vacoworking/model/coworking.dart'; //Modelo importado
import 'package:vacoworking/api/vacoworking_api.dart';
import 'package:vacoworking/widget/components_widgets.dart';

// Clase para representar coincidencias de búsqueda
class SearchResult {
  final Coworking coworking;
  final String matchType; // 'name', 'address', 'service', 'equipment', 'room'
  final String matchText;
  final String matchDetail;

  SearchResult({
    required this.coworking,
    required this.matchType,
    required this.matchText,
    required this.matchDetail,
  });
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Coworking> filteredCoworkings = []; // Lista que se muestra actualmente
  List<Coworking> allCoworkings = []; // Todos los coworkings del backend
  bool isLoading = true;
  String? errorMessage;

  final TextEditingController _controller =
      TextEditingController(); // Controlador para el texto que escribe el usuario

  Timer? _debounceTimer;

  // Función para eliminar acentos y caracteres especiales
  String _removeDiacritics(String text) {
    const accents = 'áÁéÉíÍóÓúÚñÑüÜ';
    const withoutAccents = 'aAeEiIoOuUnNuU';

    String result = text;
    for (int i = 0; i < accents.length; i++) {
      result = result.replaceAll(accents[i], withoutAccents[i]);
    }
    return result;
  }

  // Función de búsqueda normalizada (sin acentos y en minúsculas)
  bool _matchesSearch(String text, String search) {
    final normalizedText = _removeDiacritics(text.toLowerCase());
    final normalizedSearch = _removeDiacritics(search.toLowerCase());
    return normalizedText.contains(normalizedSearch);
  }

  @override
  void initState() {
    super.initState();
    _loadCoworkings();

    // Configurar debounce para búsqueda
    _controller.addListener(() {
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        _searchResults(_controller.text);
      });
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  // Obtener coincidencias para un coworking específico
  List<SearchResult> _getMatchesForCoworking(
    Coworking coworking,
    String query,
  ) {
    final matches = <SearchResult>[];
    final capacityFilter = _extractCapacityFromQuery(query);
    final searchTerms = _extractSearchTerms(query, capacityFilter);

    // 1. Coincidencia en capacidad
    if (capacityFilter != null) {
      final hasMatchingCapacity =
          coworking.totalCapacity >= capacityFilter ||
          coworking.salaMaxCapacity >= capacityFilter ||
          coworking.rooms.any((room) => room.capacity >= capacityFilter);

      if (hasMatchingCapacity) {
        matches.add(
          SearchResult(
            coworking: coworking,
            matchType: 'capacity',
            matchText: 'Capacidad $capacityFilter+',
            matchDetail: 'Capacidad disponible',
          ),
        );
      }
    }

    // 2. Coincidencia en nombre (búsqueda mejorada sin acentos)
    if (searchTerms.isNotEmpty && _matchesSearch(coworking.name, searchTerms)) {
      matches.add(
        SearchResult(
          coworking: coworking,
          matchType: 'name',
          matchText: coworking.name,
          matchDetail: 'Nombre del espacio',
        ),
      );
    }

    // 3. Coincidencia en dirección (búsqueda sin acentos)
    if (searchTerms.isNotEmpty &&
        _matchesSearch(coworking.address, searchTerms)) {
      matches.add(
        SearchResult(
          coworking: coworking,
          matchType: 'address',
          matchText: coworking.address,
          matchDetail: 'Dirección',
        ),
      );
    }

    // 4. Coincidencias en servicios (búsqueda sin acentos)
    if (searchTerms.isNotEmpty) {
      for (final service in coworking.services) {
        if (_matchesSearch(service, searchTerms)) {
          matches.add(
            SearchResult(
              coworking: coworking,
              matchType: 'service',
              matchText: service,
              matchDetail: 'Servicio disponible',
            ),
          );
        }
      }
    }

    // 5. Coincidencias en equipamientos (búsqueda sin acentos)
    if (searchTerms.isNotEmpty) {
      for (final equipment in coworking.equipment) {
        if (_matchesSearch(equipment, searchTerms)) {
          matches.add(
            SearchResult(
              coworking: coworking,
              matchType: 'equipment',
              matchText: equipment,
              matchDetail: 'Equipamiento',
            ),
          );
        }
      }
    }

    // 6. Coincidencias en salas (búsqueda sin acentos)
    if (searchTerms.isNotEmpty) {
      for (final room in coworking.rooms) {
        if (_matchesSearch(room.name, searchTerms) ||
            room.equipment.any((equip) => _matchesSearch(equip, searchTerms))) {
          matches.add(
            SearchResult(
              coworking: coworking,
              matchType: 'room',
              matchText: room.name,
              matchDetail: 'Sala (${room.capacity} personas)',
            ),
          );
        }
      }
    }

    return matches;
  }

  // Cargar todos los coworkings del backend
  Future<void> _loadCoworkings() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await VACoworkingApi.getCoworkingSpaces(perPage: 200);

      if (result['success'] == true) {
        final coworkings = result['coworkings'] as List<Coworking>;
        setState(() {
          allCoworkings = coworkings;
          filteredCoworkings = List.from(coworkings);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "";
          isLoading = false;
        });
        showCustomSnackBar(S.current.errorAuthGeneric, type: -1);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showCustomSnackBar("${S.current.errorAuthGeneric} $e", type: -1);
    }
  }

  // Función de búsqueda con filtrado local completo
  Future<void> _searchResults(String query) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Siempre cargamos todos los datos para filtrar localmente
      if (allCoworkings.isEmpty) {
        final result = await VACoworkingApi.getCoworkingSpaces(perPage: 200);
        if (result['success'] == true) {
          final coworkings = result['coworkings'] as List<Coworking>;
          setState(() {
            allCoworkings = coworkings;
          });
        }
      }

      // Extraer capacidad y términos de búsqueda
      final capacityFilter = _extractCapacityFromQuery(query);

      // Filtrar localmente por TODO: servicios, equipamientos, capacidad, nombre, dirección
      final filtered = _filterCoworkingsLocally(
        allCoworkings,
        query,
        capacityFilter,
      );

      setState(() {
        filteredCoworkings = filtered;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        filteredCoworkings = List.from(allCoworkings);
      });

      // Mensaje de error de búsqueda
      showCustomSnackBar(
        '${S.current.dialogErrorServerConnection}: $e',
        type: -1,
      );
    }
  }

  // Extraer capacidad numérica de la consulta (ej: "12", "capacidad 12", "12 personas")
  int? _extractCapacityFromQuery(String query) {
    final lowerQuery = query.toLowerCase();

    // Patrones comunes para capacidad
    final patterns = [
      RegExp(
        r'(\d+)\s*(?:personas|puestos|lugares|sillas|capi|capacidad)?',
        caseSensitive: false,
      ),
      RegExp(r'capacidad\s*(?:de\s*)?(\d+)', caseSensitive: false),
      RegExp(r'(\d+)(?=\s|$)', caseSensitive: false),
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(lowerQuery);
      if (match != null) {
        return int.tryParse(match.group(1) ?? '');
      }
    }

    return null;
  }

  // Extraer términos de búsqueda excluyendo números para capacidad
  String _extractSearchTerms(String query, int? capacityFilter) {
    if (capacityFilter != null) {
      // Remover patrones de capacidad de la búsqueda
      String searchTerms = query.toLowerCase();
      searchTerms = searchTerms.replaceAll(
        RegExp(
          r'\d+\s*(?:personas|puestos|lugares|sillas|capi|capacidad)?',
          caseSensitive: false,
        ),
        '',
      );
      searchTerms = searchTerms.replaceAll(
        RegExp(r'capacidad\s*(?:de\s*)?\d+', caseSensitive: false),
        '',
      );
      searchTerms = searchTerms.replaceAll(
        RegExp(r'\d+', caseSensitive: false),
        '',
      );
      return searchTerms.trim();
    }
    return query.trim();
  }

  // Filtrar coworkings localmente por servicios, equipamientos y capacidad
  List<Coworking> _filterCoworkingsLocally(
    List<Coworking> coworkings,
    String originalQuery,
    int? capacityFilter,
  ) {
    final searchTerms = _extractSearchTerms(originalQuery, capacityFilter);
    final filtered = <Coworking>[];

    for (final coworking in coworkings) {
      bool matches = true;

      // Filtrar por capacidad si se especificó
      if (capacityFilter != null) {
        final hasMatchingCapacity =
            coworking.totalCapacity >= capacityFilter ||
            coworking.salaMaxCapacity >= capacityFilter ||
            coworking.rooms.any((room) => room.capacity >= capacityFilter);

        if (!hasMatchingCapacity) {
          matches = false;
        }
      }

      // Filtrar por términos de búsqueda (servicios, equipamientos, etc.)
      if (searchTerms.isNotEmpty) {
        final hasNameMatch = _matchesSearch(coworking.name, searchTerms);
        final hasAddressMatch = _matchesSearch(coworking.address, searchTerms);
        final hasServiceMatch = coworking.services.any(
          (service) => _matchesSearch(service, searchTerms),
        );
        final hasEquipmentMatch = coworking.equipment.any(
          (equipment) => _matchesSearch(equipment, searchTerms),
        );
        final hasRoomMatch = coworking.rooms.any(
          (room) =>
              _matchesSearch(room.name, searchTerms) ||
              room.equipment.any((equip) => _matchesSearch(equip, searchTerms)),
        );

        // Si no hay coincidencias en NINGÚN campo, excluir
        if (!hasNameMatch &&
            !hasAddressMatch &&
            !hasServiceMatch &&
            !hasEquipmentMatch &&
            !hasRoomMatch) {
          matches = false;
        }
      }

      if (matches) {
        filtered.add(coworking);
      }
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(S.current.titleAppBar),
        ),
        actions: [
          if (errorMessage != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadCoworkings,
              tooltip: S.current.tryAgain,
            ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          //uso stack para poner el buscador encima del mapa
          children: [
            // Mostrar loading o error
            if (isLoading && allCoworkings.isEmpty)
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator(), SizedBox(height: 16)],
                ),
              )
            else if (errorMessage != null && allCoworkings.isEmpty)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      S.current.dialogErrorServerConnection,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(errorMessage!),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadCoworkings,
                      child: Text(S.current.tryAgain),
                    ),
                  ],
                ),
              )
            else
              SizedBox(
                width: MediaQuery.of(context).size.width, //ocupa todo el ancho
                height: MediaQuery.of(context).size.height, //ocupa todo el alto
                child: FlutterMap(
                  options: MapOptions(
                    // 1. Centro el mapa en Valladolid
                    initialCenter: const LatLng(41.6523, -4.7245),
                    initialZoom: 14.0,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                    ),
                  ),
                  children: [
                    // 2. La capa del mapa (el dibujo de las calles)
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.deventic.app_coworking',
                    ),
                    // 3. La capa de los marcadores, recorro la lista para crear los marcadores
                    MarkerLayer(
                      markers: filteredCoworkings.map((coworking) {
                        //uso la lista filtrada
                        return Marker(
                          point: LatLng(
                            coworking.latitude,
                            coworking.longitude,
                          ),
                          width: 40,
                          height: 40,
                          child: GestureDetector(
                            onTap: () {
                              _showCoworkingSummary(context, coworking);
                            },
                            child: const Icon(
                              Icons.location_on,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

            // --- BARRA DE BÚSQUEDA ---
            Positioned(
              top: 10,
              left: 15,
              right: 15,
              child: Card(
                elevation: 7,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize
                      .min, // Hace que la tarjeta solo crezca lo necesario
                  children: [
                    TextField(
                      controller: _controller,
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        hintText: S.current.searchByKeyWord,
                        prefixIcon: isLoading && _controller.text.isNotEmpty
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : const Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(15),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                            _searchResults(''); // Restaura la lista al borrar
                            FocusScope.of(context).unfocus();
                          },
                        ),
                      ),
                      // onChanged: (query) => _searchResults(query), // Ahora manejado por debounce
                    ),

                    // Indicador de carga durante búsqueda
                    if (isLoading &&
                        _controller.text.isNotEmpty &&
                        allCoworkings.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                      ),

                    // Solo aparece si hay texto y si hay resultados
                    if (_controller.text.isNotEmpty &&
                        filteredCoworkings.isNotEmpty &&
                        !isLoading)
                      Container(
                        constraints: const BoxConstraints(
                          maxHeight: 300,
                        ), // Límite de altura del desplegable
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.black12),
                          ), // Una rayita separadora
                        ),
                        child: ListView.builder(
                          shrinkWrap:
                              true, // Para que no ocupe toda la pantalla
                          itemCount: filteredCoworkings.length,
                          itemBuilder: (context, index) {
                            final coworking = filteredCoworkings[index];
                            final query = _controller.text.toLowerCase();

                            // Obtener coincidencias para este coworking
                            final matches = _getMatchesForCoworking(
                              coworking,
                              query,
                            );
                            final bestMatch = matches.isNotEmpty
                                ? matches.first
                                : null;

                            // Determinar icono y color según el tipo de coincidencia
                            Color matchColor = Colors.blueGrey;
                            String matchText = coworking.address;
                            String matchDetail = '';

                            if (bestMatch != null) {
                              switch (bestMatch.matchType) {
                                case 'capacity':
                                  matchText = bestMatch.matchText;
                                  break;
                                case 'name':
                                  break;
                                case 'service':
                                  matchText = bestMatch.matchText;
                                  break;
                                case 'equipment':
                                  matchText = bestMatch.matchText;
                                  break;
                                case 'room':
                                  matchText = bestMatch.matchText;
                                  break;
                                case 'address':
                                  break;
                              }
                            }

                            return ListTile(
                              leading: Icon(Icons.location_on, color: matchColor),
                              title: Text(
                                coworking.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    matchText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: matchColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (matchDetail.isNotEmpty)
                                    Text(
                                      matchDetail,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                ],
                              ),
                              trailing: matchDetail.isNotEmpty
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: matchColor.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        matchDetail,
                                        style: TextStyle(
                                          color: matchColor,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  : null,
                              onTap: () {
                                // 1. Limpiar el buscador
                                _controller.clear();
                                _searchResults(
                                  '',
                                ); // Restaura la lista completa

                                // 2. Mostrar directamente el modal completo
                                _showCoworkingSummary(context, coworking);
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Función de UI para mostrar detalles completos del coworking
  void _showCoworkingSummary(BuildContext context, Coworking coworking) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom:
                  MediaQuery.of(context).padding.bottom +
                  10, // Altura del sistema + margen extra
              left: 16,
              right: 16,
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header con imagen y nombre
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200],
                      ),
                      child: coworking.featuredThumb.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                coworking.featuredThumb,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.business,
                                    size: 30,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            )
                          : const Icon(
                              Icons.business,
                              size: 30,
                              color: Colors.grey,
                            ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coworking.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            coworking.address,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Información de capacidad
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.group, color: Colors.blue, size: 20),
                          const SizedBox(height: 5),
                          Text(
                            '${coworking.totalCapacity}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            S.current.total,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.meeting_room,
                            color: Colors.green,
                            size: 20,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${coworking.salaMaxCapacity}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            S.current.mainRoom,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Servicios principales
                if (coworking.services.isNotEmpty) ...[
                  Text(
                    S.current.services,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: coworking.services
                        .take(6)
                        .map(
                          (service) =>
                              AppTranslator.translateService(context, service),
                        )
                        .map((service) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              service,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        })
                        .toList(),
                  ),
                  if (coworking.services.length > 6)
                    Text(
                      '+${coworking.services.length - 6} ${S.current.moreServices}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  const SizedBox(height: 20),
                ],

                // Botones de acción
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        child: Text(S.current.close),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);

                          try {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsScreen(coworking: coworking),
                              ),
                            );
                          } catch (e) {
                            showCustomSnackBar(
                              S.current.dialogErrorServerConnection,
                              type: -1,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(S.current.seeAllDetails),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
