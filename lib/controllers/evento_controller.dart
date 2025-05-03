import 'dart:convert';
import '../models/evento.dart';
import 'package:http/http.dart' as http;

class EventoController {
  Future<Evento> tenerEventos() async {
    final url = Uri.parse('http://localhost:3000/eventos');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Evento.fromJSON(json.decode(response.body));
    } else {
      throw Exception(('Fallo al cargar los eventos'));
    }
  }
  
  void editarEvento() {
    print('Editando Evento');
  }

  void finalizarEvento() {
    print('Finalizando evento');
  }
}
