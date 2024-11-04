import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_flutter_capscone/screens/error_monitor'; // Asegúrate de que esté importado
import 'package:proyecto_flutter_capscone/screens/signin_screen.dart';

class MaintenanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panel de Mantenimiento'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Opciones de Mantenimiento',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            // Botón para la gestión de usuarios
            _buildMaintenanceOption(
              context,
              title: 'Gestión de Usuarios',
              description: 'Ver, editar o eliminar cuentas de usuario.',
              icon: Icons.people,
              onTap: () {
                // Navegar a la pantalla de gestión de usuarios
              },
            ),

            SizedBox(height: 20),

            // Botón para monitoreo de errores
            _buildMaintenanceOption(
              context,
              title: 'Monitoreo de Errores',
              description: 'Ver errores reportados por los usuarios.',
              icon: Icons.error,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ErrorMonitoringScreen()),
                );
              },
            ),

            SizedBox(height: 20),

            // Botón para actualización de la app
            _buildMaintenanceOption(
              context,
              title: 'Actualización de la App',
              description: 'Gestiona actualizaciones de la aplicación.',
              icon: Icons.update,
              onTap: () {
                // Funcionalidad de actualización de la app
              },
            ),

            SizedBox(height: 20),

            // Botón para modo de mantenimiento
            _buildMaintenanceOption(
              context,
              title: 'Modo Mantenimiento',
              description: 'Activa o desactiva el modo de mantenimiento.',
              icon: Icons.build,
              onTap: () {
                // Funcionalidad para activar o desactivar el modo mantenimiento
              },
            ),

            Spacer(), // Espacio flexible para empujar el botón hacia abajo

            // Botón de Cerrar Sesión
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                    (route) => false,
                  );
                },
                icon: Icon(Icons.logout),
                label: Text('Cerrar Sesión'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Color de fondo rojo
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para cada opción de mantenimiento
  Widget _buildMaintenanceOption(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: ListTile(
          leading: Icon(icon, size: 40, color: Colors.blue[800]),
          title: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(description),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
