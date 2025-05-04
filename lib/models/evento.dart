class Evento {
  final String nombre;
  final String descripcion;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String categoria;
  final String lugar;
  final String estado;
  final String imagenPath;

  Evento({
    required this.nombre,
    required this.descripcion,
    required this.fechaInicio,
    required this.fechaFin,
    required this.categoria,
    required this.lugar,
    required this.estado,
    required this.imagenPath,
  });

factory Evento.fromJSON(Map<String, dynamic> json) => Evento(
    nombre: json['nombre'] ?? '',
    descripcion: json['descripcion'] ?? '',
    fechaInicio: DateTime.parse(json['fechaInicio']),
    fechaFin: DateTime.parse(json['fechaFin']),
    categoria: json['categoria'] ?? '',
    lugar: json['lugar'] ?? '',
    estado: json['estado'] ?? '',
    imagenPath: json['imagenPath'] ?? '',
);
}
