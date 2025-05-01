import 'package:flutter/material.dart';
import '../controllers/evento_controller.dart';
import '../models/evento.dart';
import '../components/evento_card.dart';

class EventDetailsView extends StatelessWidget {
  final Evento evento;
  final EventoController controller = EventoController();

  EventDetailsView({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(evento.nombre),
        actions: [
          TextButton(
            onPressed: controller.editarEvento,
            child: const Text(
              'EDITAR',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: EventoCard(evento: evento),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: controller.finalizarEvento,
          child: const Text(
            'FINALIZAR EVENTO',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
