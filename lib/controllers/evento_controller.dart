import 'dart:convert';
import '../models/evento.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://147.93.114.243:3030';

class EventoController {
  Future<List<Evento>> obtenerEventos() async {
    final url = Uri.parse('$baseUrl/eventos');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Decodificar en UTF-8
      final decodedResponse = utf8.decode(response.bodyBytes);
      final List<dynamic> decodedData = json.decode(decodedResponse);
      return decodedData.map((json) => Evento.fromJSON(json)).toList();
    } else {
      throw Exception('Fallo al cargar los eventos');
    }
  }

  Future<Evento> obtenerEvento(String id) async {
    final url = Uri.parse('$baseUrl/eventos/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final decodedData = json.decode(decodedResponse);
      return Evento.fromJSON(decodedData);
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
      'fechaInicio': fechaInicio.toIso8601String(),
      'fechaFin': fechaFin.toIso8601String(),
      'categoria': categoria,
      'lugar': lugar,
      'estado': estado,
      'imagenPath': imagenPath,
    };

    final url = Uri.parse('$baseUrl/eventos');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request),
    );

    if (response.statusCode == 201) {
      return Evento.fromJSON(json.decode(response.body));
    } else {
      throw Exception('Fallo al crear un evento: ${response.body}');
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
      'fechaInicio': fechaInicio.toIso8601String(),
      'fechaFin': fechaFin.toIso8601String(),
      'categoria': categoria,
      'lugar': lugar,
      'estado': estado,
      'imagenPath': imagenPath,
    };
    final url = Uri.parse('$baseUrl/eventos/$id');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request),
    );
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final decodedData = json.decode(decodedResponse);
      return Evento.fromJSON(decodedData);
    } else {
      throw Exception('Fallo al actualizar el evento ${response.statusCode}');
    }
  }

  Future<Evento?>? eliminarEvento(String id) async {
    final url = Uri.parse('$baseUrl/eventos/$id');
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      return null;
    } else {
      throw Exception('Error al eliminar el evento');
    }
  }

  Future<void> estadoEnCurso(String id) async {
    final url = Uri.parse('$baseUrl/eventos/$id');

    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'estado': 'en curso'}),
    );

    if (response.statusCode == 200) {
      print('Estado actualizado correctamente');
    } else {
      throw Exception('Error al actualizar el estado del evento');
    }
  }

  Future<void> estadoFinalizado(String id) async {
    final url = Uri.parse('$baseUrl/eventos/$id');

    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'estado': 'finalizado'}),
    );

    if (response.statusCode == 200) {
      print('Estado finalizado correctamente');
    } else {
      throw Exception('Error al actualizar el estado del evento');
    }
  }
}
