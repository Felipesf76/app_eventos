import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../controllers/evento_controller.dart';
import '../models/evento.dart';
import 'package:path_provider/path_provider.dart';

class EventFormView extends StatefulWidget {
  final Evento? evento;
  const EventFormView({super.key, this.evento});

  @override
  State<EventFormView> createState() => _EventFormState();
}

class _EventFormState extends State<EventFormView> {
  Evento? _evento;
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nombreController;
  late final TextEditingController _descripcionController;
  late final TextEditingController _lugarController;
  late final TextEditingController _imagenController;

  DateTime? _fechaInicio;
  DateTime? _fechaFin;

  String? _categoriaSeleccionada;
  String? _estadoSeleccionado;
  String? _eventId;

  File? _imagenSeleccionada;

  final Map<String, String> _categorias = {
    'festival': 'Festival',
    'teatro': 'Obra de teatro',
    'conciertos': 'Concierto',
    'eventos_capital': 'Eventos Públicos',
    'default': 'Otros',
  };
  final List<String> _estados = ['Pendiente', 'En curso', 'Finalizado'];

  @override
  void initState() {
    super.initState();
    _eventId = widget.evento?.id;
    _nombreController = TextEditingController(
      text: widget.evento?.nombre ?? '',
    );
    _descripcionController = TextEditingController(
      text: widget.evento?.descripcion ?? '',
    );
    _lugarController = TextEditingController(text: widget.evento?.lugar ?? '');
    _imagenController = TextEditingController(
      text: widget.evento?.imagenPath ?? '',
    );

    _fechaInicio = widget.evento?.fechaInicio;
    _fechaFin = widget.evento?.fechaFin;

    _categoriaSeleccionada = widget.evento?.categoria;
    if (_categoriaSeleccionada == null ||
        !_categorias.containsKey(_categoriaSeleccionada)) {
      _categoriaSeleccionada = 'default'; // Valor por defecto
    }

    _estadoSeleccionado = widget.evento?.estado;
    if (_estadoSeleccionado == null ||
        !_estados.contains(_estadoSeleccionado)) {
      _estadoSeleccionado = 'Pendiente'; // Valor por defecto
    }
    // ... inicializar otros controladores con widget.evento ...
  }

  Future<void> _seleccionarFecha({required bool esFechaInicio}) async {
    final DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (fechaSeleccionada != null) {
      setState(() {
        if (esFechaInicio) {
          _fechaInicio = fechaSeleccionada;
          if (_fechaFin != null && _fechaFin!.isBefore(_fechaInicio!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'La fecha fin no puede ser anterior a la fecha inicio',
                ),
              ),
            );
            _fechaFin = null;
          }
        } else {
          if (_fechaInicio != null &&
              fechaSeleccionada.isBefore(_fechaInicio!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'La fecha fin no puede ser anterior a la fecha inicio',
                ),
              ),
            );
          } else {
            _fechaFin = fechaSeleccionada;
          }
        }
      });
    }
  }

  Future<void> _elegirImagen() async {
    final picker = ImagePicker();
    final XFile? imagen = await picker.pickImage(source: ImageSource.gallery);

    if (imagen != null) {
      final directory = await getApplicationDocumentsDirectory();
      final String nombreArchivo = path.basename(imagen.path);
      final File nuevaImagen = await File(
        imagen.path,
      ).copy('${directory.path}/$nombreArchivo');
      setState(() {
        _imagenSeleccionada = nuevaImagen;
        _imagenController.text = nombreArchivo;
      });
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _lugarController.dispose();
    _imagenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool esEdicion = widget.evento != null;
    return Scaffold(
      appBar: AppBar(title: Text(esEdicion ? "Editar Evento" : 'Crear Evento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text:
                      _fechaInicio != null
                          ? DateFormat('yyyy-MM-dd').format(_fechaInicio!)
                          : '',
                ),
                decoration: InputDecoration(
                  labelText: 'Fecha inicio',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _seleccionarFecha(esFechaInicio: true),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text:
                      _fechaFin != null
                          ? DateFormat('yyyy-MM-dd').format(_fechaFin!)
                          : '',
                ),
                decoration: InputDecoration(
                  labelText: 'Fecha fin',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _seleccionarFecha(esFechaInicio: false),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _lugarController,
                decoration: const InputDecoration(
                  labelText: 'Lugar',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                ),
                value: _categoriaSeleccionada,
                items:
                    _categorias.keys
                        .map(
                          (cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(_categorias[cat]!),
                          ),
                        )
                        .toList(),
                onChanged: (valor) {
                  setState(() {
                    _categoriaSeleccionada = valor;
                  });
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Estado',
                  border: OutlineInputBorder(),
                ),
                value: _estadoSeleccionado,
                items:
                    _estados
                        .map(
                          (est) =>
                              DropdownMenuItem(value: est, child: Text(est)),
                        )
                        .toList(),
                onChanged: (valor) {
                  setState(() {
                    _estadoSeleccionado = valor;
                  });
                },
              ),
              //
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_fechaInicio == null ||
                        _fechaFin == null ||
                        _categoriaSeleccionada == null ||
                        _estadoSeleccionado == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor completa todos los campos'),
                        ),
                      );
                      return;
                    }

                    final imagenPath =
                        _imagenController.text.isNotEmpty
                            ? 'assets/$_imagenController'
                            : 'assets/default.png';
                    if (esEdicion) {
                      try {
                        await EventoController().actualizarEvento(
                          _nombreController.text,
                          _descripcionController.text,
                          _fechaInicio!,
                          _fechaFin!,
                          _categoriaSeleccionada!,
                          _lugarController.text,
                          _estadoSeleccionado!.toLowerCase(),
                          imagenPath,
                          _eventId!,
                        );
                        

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Evento editado exitosamente'),
                          ),
                        );
                        Navigator.pop(context, true);
                        
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error al editar el evento: $e'),
                          ),
                        );
                      }
                    } else {
                      try {
                        await EventoController().crearEvento(
                          _nombreController.text,
                          _descripcionController.text,
                          _fechaInicio!,
                          _fechaFin!,
                          _categoriaSeleccionada!,
                          _lugarController.text,
                          _estadoSeleccionado!.toLowerCase(),
                          imagenPath,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Evento creado exitosamente'),
                          ),
                        );
                        Navigator.pop(context, true);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error al crear el evento: $e'),
                          ),
                        );
                      }
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 226, 226, 226),
                ),
                child: Text(
                  esEdicion ? 'Editar Evento' : 'Crear Evento',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
