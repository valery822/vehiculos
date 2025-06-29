import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos simulados del usuario (luego vendrán de la base de datos)
    final String nombre = "Juan Pérez";
    final String correo = "juanperez@gmail.com";
    final String licencia = "ABC123456";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil de Usuario"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              nombre,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              correo,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.badge),
              title: const Text("Número de Licencia"),
              subtitle: Text(licencia),
            ),
            const Divider(),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Aquí rediriges a una pantalla o diálogo de cambio de contraseña
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Función aún no implementada")),
                );
              },
              icon: const Icon(Icons.lock_reset),
              label: const Text("Cambiar Contraseña"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
