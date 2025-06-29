import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlquileresScreen extends StatefulWidget {
  const AlquileresScreen({super.key});

  @override
  State<AlquileresScreen> createState() => _AlquileresScreenState();
}

class _AlquileresScreenState extends State<AlquileresScreen> {
  List<dynamic> alquileres = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarAlquileres();
  }

  Future<void> cargarAlquileres() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('usuarioEmail') ?? '';

    if (email.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay usuario logueado')),
      );
      return;
    }

    final url = Uri.parse('http://localhost:3000/api/alquileres/$email');

    try {
      final response = await http.get(url);

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          alquileres = data;
          cargando = false;
        });
      } else {
        throw Exception('Error al cargar datos');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      setState(() => cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mis Alquileres")),
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : alquileres.isEmpty
              ? const Center(child: Text("No has alquilado vehículos aún"))
              : ListView.builder(
                  itemCount: alquileres.length,
                  itemBuilder: (context, index) {
                    final auto = alquileres[index];
                    return Card(
                      margin: const EdgeInsets.all(12),
                      child: ListTile(
                        leading: Image.network(auto['imagen'], width: 60, fit: BoxFit.cover),
                        title: Text('${auto['marca']} ${auto['modelo']}'),
                        subtitle: Text('Año: ${auto['anio']} - \$${auto['precio']}/día'),
                      ),
                    );
                  },
                ),
    );
  }
}
