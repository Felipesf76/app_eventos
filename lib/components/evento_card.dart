import 'package:flutter/material.dart';
import '../models/evento.dart';

class EventoCard extends StatelessWidget {
  final Evento evento;

  const EventoCard({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    final bool finalizado = evento.estado.toLowerCase() == 'finalizado';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Imagen del evento
        Container(
          width: double.infinity,
          height: 200,
          color: Colors.grey[300],
          child: Image.asset(
            evento.imagenPath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.image, size: 50)),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          evento.nombre,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          evento.descripcion,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 12),
        _info("📅 Fecha de inicio", evento.fechaInicio.toLocal().toString().split(' ')[0]),
        _info("📅 Fecha de fin", evento.fechaFin.toLocal().toString().split(' ')[0]),
        _info("📍 Lugar", evento.lugar),
        _info("🏷️ Categoría", evento.categoria),
        const SizedBox(height: 20),
        if (finalizado)
          _estadoFinalizado()
        else
          const SizedBox(),
      ],
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: RichText(
        text: TextSpan(
          text: "$label: ",
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _estadoFinalizado() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'EVENTO FINALIZADO',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
