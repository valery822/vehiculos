import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class VehicleDetailScreen extends StatelessWidget {
  final Map<String, dynamic> auto;

  const VehicleDetailScreen({super.key, required this.auto});

  Future<void> alquilarVehiculo(BuildContext context, int vehiculoId) async {
    final prefs = await SharedPreferences.getInstance();
    final emailUsuario = prefs.getString('usuarioEmail') ?? '';

    if (emailUsuario.isEmpty) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: usuario no autenticado')),
      );
      return;
    }

    var url = Uri.parse('http://localhost:3000/api/alquileres');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'vehiculo_id': vehiculoId,
          'email_usuario': emailUsuario,
        }),
      );

      if (!context.mounted) return;

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vehículo alquilado con éxito')),
        );
      } else {
        final message = jsonDecode(response.body)['message'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $message')),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool disponible = auto['disponible'];
    final String marca = auto['marca'];
    final String modelo = auto['modelo'];
    final int anio = auto['anio'] ?? 2023;
    final int vehiculoId = auto['id'] ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del Vehículo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                auto['imagen'],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '$marca $modelo',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Año: $anio',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  'Disponibilidad: ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  disponible ? 'Disponible' : 'No disponible',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: disponible ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: disponible
                    ? () => alquilarVehiculo(context, vehiculoId)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: disponible ? Colors.blue : Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Alquilar Vehículo", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
