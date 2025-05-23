import 'package:flutter/material.dart';
import '../controllers/evento_controller.dart';
import '../models/evento.dart';
import '../components/evento_card.dart';
import './event_form_view.dart';

class EventDetailsView extends StatefulWidget {
  final Evento? evento;
  const EventDetailsView({super.key, this.evento});

  @override
  State<EventDetailsView> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetailsView> {
  Evento? _evento;
  final EventoController controller = EventoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.evento?.nombre ?? ''),
        actions: [
          TextButton(
            onPressed: () async {
              final resultado = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventFormView(evento: widget.evento),
                ),
              );
              if (resultado == true) {
                // Recargar la página con los nuevos datos
                Navigator.pop(context, true);
                // final eventoActualizado = await controller.obtenerEvento(
                //   widget.evento?.id ?? '',
                // );
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder:
                //         (context) =>
                //             EventDetailsView(evento: eventoActualizado),
                //   ),
                // );
              }
            },
            child: const Text(
              'EDITAR',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: EventoCard(evento: widget.evento!),
      ),
      bottomNavigationBar:
          widget.evento?.estado.toLowerCase() == 'finalizado'
              ? null
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () async {
                    await controller.estadoFinalizado(widget.evento?.id ?? '');
                    Navigator.pop(context, true);
                  },
                  child: const Text(
                    'FINALIZAR EVENTO',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
    );
  }
}
