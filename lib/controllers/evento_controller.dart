import 'dart:convert';
import '../models/evento.dart';
import 'package:http/http.dart' as http;

class EventoController {
  /*Future<List<Evento>> obtenerEventos() async {
    final url = Uri.parse('http://localhost:3000/eventos');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes); // Asegura UTF-8
      final List<dynamic> decodedData = json.decode(decodedResponse);
      return decodedData.map((json) => Evento.fromJSON(json)).toList();
    } else {
      throw Exception(('Fallo al cargar los eventos'));
    }
  }*/

  Future<List<Evento>> obtenerEventos() async {
  final url = Uri.parse('http://localhost:3000/eventos');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // Imprimir los bytes de la respuesta
    print('Response Bytes: ${response.bodyBytes}');

    // Decodificar en UTF-8
    final decodedResponse = utf8.decode(response.bodyBytes);

    // Imprimir la respuesta decodificada para verificar los caracteres
    print('Decoded Response: $decodedResponse');

    final List<dynamic> decodedData = json.decode(decodedResponse);
    return decodedData.map((json) => Evento.fromJSON(json)).toList();
  } else {
    throw Exception('Fallo al cargar los eventos');
  }
}

  Future<Evento> obtenerEvento(String id) async {
    final url = Uri.parse('http://localhost:3000/eventos/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Evento.fromJSON(json.decode(response.body));
    } else {
      throw Exception(('Fallo al cargar el evento'));
    }
  }

  Future<Evento> crearEvento(
    String nombre,
    String descripcion,
    DateTime fechaInicio,
    DateTime fechaFin,
    String categoria,
    String lugar,
    String estado,
    String imagenPath,
  ) async {
    Map<String, dynamic> request = {
      'nombre': nombre,
      'descripcion': descripcion,
      'fechaInicio': fechaInicio,
      'fechaFin': fechaFin,
      'categoria': categoria,
      'lugar': lugar,
      'estado': estado,
      'imagenPath': imagenPath,
    };
    final url = Uri.parse('http://localhost:3000/eventos');
    final response = await http.post(url, body: request);
    if (response.statusCode == 201) {
      return Evento.fromJSON(json.decode(response.body));
    } else {
      throw Exception('Fallo al crear un evento');
    }
  }

  Future<Evento> actualizarEvento(
    String nombre,
    String descripcion,
    DateTime fechaInicio,
    DateTime fechaFin,
    String categoria,
    String lugar,
    String estado,
    String imagenPath,
    String id,
  ) async {
    Map<String, dynamic> request = {
      'nombre': nombre,
      'descripcion': descripcion,
      'fechaInicio': fechaInicio,
      'fechaFin': fechaFin,
      'categoria': categoria,
      'lugar': lugar,
      'estado': estado,
      'imagenPath': imagenPath,
    };
    final url = Uri.parse('http://localhost:3000/eventos/$id');
    final response = await http.put(url, body: request);
    if (response.statusCode == 201) {
      return Evento.fromJSON(json.decode(response.body));
    } else {
      throw Exception('Fallo al actualizar el evento');
    }
  }

  Future<Evento?>? eliminarEvento(String id) async {
    final url = Uri.parse('http://localhost:3000/eventos/1');
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      return null;
    } else {
      throw Exception('Error al eliminar el evento');
    }
  }

  void editarEvento() {
    print('Editando Evento');
  }

  void finalizarEvento() {
    print('Finalizando evento');
  }
}
