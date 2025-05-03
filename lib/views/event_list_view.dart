import 'package:flutter/material.dart';
import '../controllers/evento_controller.dart';
import '../models/evento.dart';
import '../components/evento_card.dart';
import '../components/info_evento.dart';

class EventListView extends StatelessWidget {
final List<Map<String, String>> eventos = [
  {
    'title': 'Evento 1',
    'description': 'Descripción 1',
    'fechaInicio': '2025-05-10',
    'fechaFin': '2025-05-12',
    'categoria': 'Conferencia',
    'lugar': 'Ciudad A',
    'estado': 'Activo',
    'imagenPath': 'assets/evento1.jpg',
  },
  {
    'title': 'Evento 2',
    'description': 'Descripción 2',
    'fechaInicio': '2025-06-01',
    'fechaFin': '2025-06-03',
    'categoria': 'Taller',
    'lugar': 'Ciudad B',
    'estado': 'Finalizado',
    'imagenPath': 'assets/evento2.jpg',
  },
  {
    'title': 'Evento 3',
    'description': 'Descripción 3',
    'fechaInicio': '2025-07-15',
    'fechaFin': '2025-07-17',
    'categoria': 'Seminario',
    'lugar': 'Ciudad C',
    'estado': 'Pendiente',
    'imagenPath': 'assets/evento3.jpg',
  },
];

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
      body: Wrap(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/event_form_view');
            },
            child: Container(
              width: 200.0,
              height: 200.0,
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, size: 40),
                    SizedBox(height: 8),
                    Text('Agregar un\nnuevo evento', textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ),
          // Tarjetas de evento con navegación
          ...eventos.map(
            (e) => GestureDetector(
              onTap: () {
                // Construimos un objeto Evento y lo pasamos como argumento
                Evento evento = Evento(
                nombre: e['title']!,
                descripcion: e['description']!,
                fechaInicio: DateTime.parse(e['fechaInicio']!),
                fechaFin: DateTime.parse(e['fechaFin']!),
                categoria: e['categoria']!,
                lugar: e['lugar']!,
                estado: e['estado']!,
                imagenPath: e['imagenPath']!,
              );
                Navigator.pushNamed(
                  context,
                  '/event_details_view',
                  arguments: evento, // Pasamos el objeto Evento
                );
              },
              child: ListTile(
                title: Text(e['title']!),
                subtitle: Text(e['description']!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
