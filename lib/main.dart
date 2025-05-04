import 'package:flutter/material.dart';
import 'models/evento.dart';
import 'views/event_details_view.dart';
import 'views/event_form_view.dart';
import 'views/event_list_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
  home: EventListView(),
  
  onGenerateRoute: (settings) {
    if (settings.name == '/event_details_view') {
      final evento = settings.arguments as Evento;
      return MaterialPageRoute(
        builder: (context) => EventDetailsView(evento: evento),
      );
    }

    if (settings.name == '/event_form_view') {
      return MaterialPageRoute(
        builder: (context) => const EventFormView(),
      );
    }

    // Ruta por defecto (si no coincide con ninguna)
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(child: Text('Ruta no encontrada')),
      ),
    );
  },
  debugShowCheckedModeBanner: false,
);

    }
}
