import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/vehicle.dart';
import 'vehicle_detail_screen.dart';
import 'profile_screen.dart';
import 'alquileres_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Vehicle> vehicles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVehicles();
  }

  Future<void> fetchVehicles() async {
    final url = Uri.parse('http://localhost:3000/api/vehicles');

    try {
      final response = await http.get(url);

      if (!mounted) return;

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Vehicle> listaVehiculos =
            data.map((item) => Vehicle.fromJson(item)).toList();

        if (!mounted) return;
        setState(() {
          vehicles = listaVehiculos;
          isLoading = false;
        });
      } else {
        throw Exception('Error al cargar vehículos');
      }
    } catch (e) {
      if (!mounted) return;

      // Este uso de context va fuera del setState
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );

      setState(() => isLoading = false);
    }
  }

  void cerrarSesion() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('usuarioEmail');

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Sesión cerrada")),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Autos Disponibles"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(child: Text("Menú")),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Perfil"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text("Mis Alquileres"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AlquileresScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Cerrar sesión"),
              onTap: cerrarSesion,
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: vehicles.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final auto = vehicles[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VehicleDetailScreen(auto: {
                          'id': auto.id,
                          'marca': auto.marca,
                          'modelo': auto.modelo,
                          'imagen': auto.imagen,
                          'anio': auto.anio,
                          'precio': auto.precio,
                          'calificacion': auto.calificacion,
                          'disponible': auto.disponible,
                        }),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: Image.network(
                            auto.imagen,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${auto.marca} ${auto.modelo}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Row(
                                children: List.generate(
                                  5,
                                  (i) => Icon(Icons.star,
                                      size: 16,
                                      color: i < auto.calificacion.round()
                                          ? Colors.orange
                                          : Colors.grey[300]),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('\$${auto.precio}/día'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
