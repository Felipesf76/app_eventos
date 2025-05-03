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
    final Evento mockEvento = Evento(
      nombre: 'Rock al parque',
      descripcion: '''
Rock al Parque es uno de los festivales de música más importantes de América Latina y uno de los eventos gratuitos al aire libre más grandes del mundo. Se celebra cada año en Bogotá, Colombia, y reúne a miles de asistentes durante varios días en diferentes escenarios de la ciudad. Desde su creación en 1995, el festival ha servido como plataforma para artistas emergentes y consolidados, promoviendo géneros como el rock, metal, punk, reggae, ska y muchas otras variantes alternativas. Con una fuerte apuesta por la diversidad musical y la inclusión cultural, Rock al Parque se ha convertido en un emblema del movimiento artístico y juvenil en el país.

Durante sus ediciones, Rock al Parque ha acogido a decenas de bandas nacionales e internacionales que han dejado huella en la memoria colectiva de sus asistentes. Uno de los momentos más recordados por los fanáticos fue la participación de Mägo de Oz, una banda española de folk metal que ha cultivado un público fiel en América Latina. Con una propuesta escénica teatral y una mezcla única de rock, heavy metal y música celta, Mägo de Oz encendió los escenarios de Rock al Parque con canciones emblemáticas como Fiesta Pagana, Molinos de Viento y La Costa del Silencio.

Mägo de Oz, fundada en Madrid en 1988, ha sido una banda pionera en su género. Su estilo combina la fuerza del metal con instrumentos tradicionales como la flauta, el violín y las gaitas, creando un sonido épico y distintivo. Sus letras, cargadas de simbolismo y referencias a la literatura, la religión y la mitología, han capturado la atención de generaciones enteras. Además de su calidad musical, el grupo ha sido reconocido por su puesta en escena visualmente impactante, que en el contexto de Rock al Parque adquirió una dimensión especial al conectar con un público latinoamericano apasionado y comprometido con la cultura del rock.

La presencia de Mägo de Oz en Rock al Parque representó no solo un hito musical, sino también un puente cultural entre Europa y Latinoamérica. Su participación reafirmó la vocación internacional del festival y el poder de la música como lenguaje universal. Para muchos asistentes, ese concierto fue una experiencia inolvidable que marcó un antes y un después en su vínculo con el festival. Rock al Parque continúa evolucionando, pero momentos como ese consolidan su lugar como un referente indiscutible del panorama musical hispano.
''',

      fechaInicio: DateTime(2024, 8, 1),
      fechaFin: DateTime(2024, 8, 3),
      categoria: 'Música',
      lugar: 'Bogotá (Colombia)',
      estado: 'finalizado',
      imagenPath: 'assets/image.png',
    );

    return MaterialApp(
      //home: EventDetailsView(evento: mockEvento),
      home: EventListView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
