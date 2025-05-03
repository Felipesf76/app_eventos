import 'package:flutter/material.dart';
import '../controllers/evento_controller.dart';
import '../models/evento.dart';
import '../components/evento_card.dart';
import '../components/info_evento.dart';

class EventListView extends StatelessWidget {
  final List<Map<String, String>> eventos = [
    {'title': 'Evento 1', 'description': 'Descripción 1'},
    {'title': 'Evento 2', 'description': 'Descripción 2'},
    {'title': 'Evento 3', 'description': 'Descripción 3'},
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
          Container(
            width: 200.0,
            height: 200.0,
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                // Sombra
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
          // Tarjetas de evento usando componente
          ...eventos.map(
            (e) =>
                ListEvento(title: e['title']!, description: e['description']!),
          ),
        ],
      ),
    );
  }
}
