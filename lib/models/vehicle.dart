class Vehicle {
  final int id;
  final String marca;
  final String modelo;
  final int anio;
  final String imagen;
  final double calificacion;
  final int precio;
  final bool disponible;

  Vehicle({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.anio,
    required this.imagen,
    required this.calificacion,
    required this.precio,
    required this.disponible,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      marca: json['marca'],
      modelo: json['modelo'],
      anio: json['anio'],
      imagen: json['imagen'],
      calificacion: (json['calificacion'] as num).toDouble(),
      precio: json['precio'],
      disponible: json['disponible'] == 1,
    );
  }
}
