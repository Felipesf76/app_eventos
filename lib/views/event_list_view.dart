import 'package:app_eventos/controllers/evento_controller.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/evento.dart';

class EventListView extends StatefulWidget {
  const EventListView({super.key});

  @override
  _EventListViewState createState() => _EventListViewState();
}

class _EventListViewState extends State<EventListView> {
  final EventoController controller = EventoController();

  late Future<List<Evento>> futureEventos;

  @override
  void initState() {
    super.initState();
    futureEventos =
        controller.obtenerEventos(); // Llama al método del controlador
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Eventos Bogotá',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: FutureBuilder<List<Evento>>(
        future: futureEventos,
        builder: (context, snapshot) {
          // Verificando los diferentes estados de la conexión
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay eventos disponibles'));
          }

          // Lista de eventos cargada exitosamente
          final eventos = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(20.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 columnas por línea
              crossAxisSpacing: 20.0, // Espacio horizontal entre las tarjetas
              mainAxisSpacing: 20.0, // Espacio vertical entre las tarjetas
              childAspectRatio:
                  1, // Relación de aspecto cuadrada para las tarjetas
            ),
            itemCount:
                eventos.length +
                1, // 1 espacio adicional para la tarjeta de agregar
            itemBuilder: (context, index) {
              if (index == 0) {
                // Tarjeta para agregar un nuevo evento
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/event_form_view');
                  },
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, size: 40),
                          SizedBox(height: 8),
                          Text(
                            'Agregar un\nnuevo evento',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              // Mostrar las tarjetas de eventos
              final evento = eventos[index - 1];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/event_details_view',
                    arguments: evento, // Pasamos el objeto Evento
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Imagen del evento
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          evento.imagenPath,
                          width: 200.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Título del evento
                      Text(
                        evento.nombre,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // Descripción corta del evento (limitada a 2 líneas)
                      Text(
                        evento.descripcion,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
