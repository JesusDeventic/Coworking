import 'package:vacoworking/page/detail/details_screen.dart'; //Pantalla detalles importada
import 'package:flutter/material.dart';
import 'dart:async'; // Para Timer
import 'package:flutter_map/flutter_map.dart'; // El paquete del mapa
import 'package:latlong2/latlong.dart'; // Para manejar coordenadas
import 'package:vacoworking/model/coworking.dart'; //Modelo importado
import 'package:collection/collection.dart';
import 'package:vacoworking/api/vacoworking_api.dart';

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
          errorMessage =
              result['message'] as String? ?? 'Error al cargar los datos';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error de conexión: $e';
        isLoading = false;
      });
    }
  }

  // Función de búsqueda con debounce usando backend
  Future<void> _searchResults(String query) async {
    if (query.isEmpty) {
      setState(() {
        filteredCoworkings = List.from(allCoworkings);
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await VACoworkingApi.getCoworkingSpaces(
        search: query,
        perPage: 50,
      );

      if (result['success'] == true) {
        final coworkings = result['coworkings'] as List<Coworking>;
        setState(() {
          filteredCoworkings = coworkings;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = result['message'] as String? ?? 'Error en la búsqueda';
          isLoading = false;
          // En caso de error, mostrar todos los coworkings
          filteredCoworkings = List.from(allCoworkings);
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error de conexión: $e';
        isLoading = false;
        // En caso de error, mostrar todos los coworkings
        filteredCoworkings = List.from(allCoworkings);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: const Text('Coworkings en Valladolid'),
        ),
        actions: [
          if (errorMessage != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadCoworkings,
              tooltip: 'Reintentar',
            ),
        ],
      ),
      body: Stack(
        //uso stack para poner el buscador encima del mapa
        children: [
          // Mostrar loading o error
          if (isLoading && allCoworkings.isEmpty)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando espacios de coworking...'),
                ],
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
                    'Error al cargar los datos',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(errorMessage!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadCoworkings,
                    child: const Text('Reintentar'),
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
                        point: LatLng(coworking.latitude, coworking.longitude),
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
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Hace que la tarjeta solo crezca lo necesario
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Buscar por nombre o servicio',
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
                          Text('Buscando...'),
                        ],
                      ),
                    ),

                  // Solo aparece si hay texto y si hay resultados
                  if (_controller.text.isNotEmpty &&
                      filteredCoworkings.isNotEmpty &&
                      !isLoading)
                    Container(
                      constraints: const BoxConstraints(
                        maxHeight: 250,
                      ), // Límite de altura del desplegable
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.black12),
                        ), // Una rayita separadora
                      ),
                      child: ListView.builder(
                        shrinkWrap: true, // Para que no ocupe toda la pantalla
                        itemCount: filteredCoworkings.length,
                        itemBuilder: (context, index) {
                          final coworking = filteredCoworkings[index];

                          final query = _controller.text.toLowerCase();
                          // Subtitulo variable
                          String matchText = coworking
                              .address; // Por defecto muestro la dirección

                          if (query.isNotEmpty) {
                            {
                              final service = coworking.services.firstWhereOrNull(
                                //uso firstWhereOrnull para verificar si es true y capturar la coincidencia en el mismo codigo, en vez de any y luego firstWhere.
                                (s) => s.toLowerCase().contains(query),
                              );
                              if (service != null) {
                                matchText = service;
                              }
                            }
                            {
                              final equip = coworking.equipment
                                  .firstWhereOrNull(
                                    (e) => e.toLowerCase().contains(query),
                                  );
                              if (equip != null) {
                                matchText = equip;
                              }
                            }
                            final roomCoincidente = coworking.rooms
                                .firstWhereOrNull(
                                  (r) => r.name.toLowerCase().contains(query),
                                );
                            if (roomCoincidente != null) {
                              matchText = roomCoincidente.name;
                            }
                          }

                          return ListTile(
                            leading: Icon(Icons.location_on, color: Colors.red),
                            title: Text(
                              coworking.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              matchText, // Aquí mostramos dinámicamente la coincidencia
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight:
                                    matchText.startsWith(coworking.address)
                                    ? FontWeight.normal
                                    : FontWeight.w500,
                              ),
                            ),
                            onTap: () {
                              // Lo que pasa cuando tocan una sugerencia:

                              // 1. Ocultar el teclado
                              FocusScope.of(context).unfocus();

                              // 2. Borro el texto
                              _controller.text = "";

                              // 3. Abrir el Modal con los detalles
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
    );
  }

  // Función de UI para mostrar un aviso rápido al tocar
  void _showCoworkingSummary(BuildContext context, Coworking coworking) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 200,
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
              const SizedBox(height: 10),
              Text(coworking.address),
              const SizedBox(height: 10),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    ); //cierro el mensaje que estoy mostrando
                    Navigator.push(
                      //abro la pagina con los detalles completos
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(coworking: coworking),
                      ),
                    );
                  },
                  child: const Text('Ver más detalles'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
