import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EventFormView extends StatefulWidget {
  const EventFormView({super.key});

  @override
  State<EventFormView> createState() => _EventFormState();
}

class _EventFormState extends State<EventFormView> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _lugarController = TextEditingController();
  final _imagenController = TextEditingController();

  DateTime? _fechaInicio;
  DateTime? _fechaFin;

  String? _categoriaSeleccionada;
  String? _estadoSeleccionado;

  File? _imagenSeleccionada;

  final List<String> _categorias = ['Rock', 'Heavy Metal', 'Punk', 'Stoner'];
  final List<String> _estados = ['Pendiente', 'En curso', 'Finalizado'];

Future<void> _seleccionarFecha({
  required bool esFechaInicio,
}) async {
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
            const SnackBar(content: Text('La fecha fin no puede ser anterior a la fecha inicio')),
          );
          _fechaFin = null;
        }
      } else {
        if (_fechaInicio != null && fechaSeleccionada.isBefore(_fechaInicio!)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('La fecha fin no puede ser anterior a la fecha inicio')),
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
    setState(() {
      _imagenController.text = imagen.name; // con imagen.path se guarda la ruta completa
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
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Evento')),
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
                  text: _fechaInicio != null ? DateFormat('yyyy-MM-dd').format(_fechaInicio!) : '',
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
                  text: _fechaFin != null ? DateFormat('yyyy-MM-dd').format(_fechaFin!) : '',
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
                items: _categorias
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
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
                items: _estados
                    .map((est) => DropdownMenuItem(
                          value: est,
                          child: Text(est),
                        ))
                    .toList(),
                onChanged: (valor) {
                  setState(() {
                    _estadoSeleccionado = valor;
                  });
                },
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _elegirImagen,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _imagenController,
                    decoration: const InputDecoration(
                      labelText: 'Imagen',
                      prefixIcon: Icon(Icons.image),
                    ),
                  ),
                ),
              ),
              if (_imagenSeleccionada != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.file(
                    _imagenSeleccionada!,
                    height: 150,
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Guardar en la bdd
                    print('Formulario válido');
                  }
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 226, 226, 226),
                ),
               child: const Text(
                'Guardar Evento',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}