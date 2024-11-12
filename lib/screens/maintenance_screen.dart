import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_flutter_capscone/screens/error_monitor.dart';
import 'package:proyecto_flutter_capscone/screens/signin_screen.dart';
import 'package:proyecto_flutter_capscone/screens/user_management_screen.dart';

class MaintenanceScreen extends StatefulWidget {
  @override
  _MaintenanceScreenState createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  bool _isMaintenanceMode = false;

  @override
  void initState() {
    super.initState();
    _fetchMaintenanceModeStatus();
  }

  // Método para obtener el estado del modo mantenimiento desde Firestore
  Future<void> _fetchMaintenanceModeStatus() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('settings')
          .doc('appConfig')
          .get();

      // Si el documento existe, actualiza el estado de _isMaintenanceMode
      if (snapshot.exists) {
        setState(() {
          _isMaintenanceMode = snapshot.get('isMaintenanceMode') ?? false;
        });
      } else {
        // Si el documento no existe, lo creamos con isMaintenanceMode en false
        await FirebaseFirestore.instance
            .collection('settings')
            .doc('appConfig')
            .set({'isMaintenanceMode': false});
      }
    } catch (e) {
      print("Error al obtener el estado de mantenimiento: $e");
    }
  }

  // Método para activar o desactivar el modo mantenimiento
  Future<void> _toggleMaintenanceMode() async {
    try {
      await FirebaseFirestore.instance
          .collection('settings')
          .doc('appConfig')
          .update({'isMaintenanceMode': !_isMaintenanceMode});

      setState(() {
        _isMaintenanceMode = !_isMaintenanceMode;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isMaintenanceMode
              ? 'Modo Mantenimiento activado'
              : 'Modo Mantenimiento desactivado'),
        ),
      );
    } catch (e) {
      print("Error al actualizar el modo mantenimiento: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar el modo de mantenimiento')),
      );
    }
  }

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserManagementScreen()),
                );
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
                  MaterialPageRoute(
                      builder: (context) => ErrorMonitoringScreen()),
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

            // Opción para activar/desactivar el modo mantenimiento
            ListTile(
              leading: Icon(
                Icons.build,
                color: Colors.blue[800],
                size: 30,
              ),
              title: Text(
                'Modo Mantenimiento',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(_isMaintenanceMode
                  ? 'Modo Mantenimiento está activado'
                  : 'Modo Mantenimiento está desactivado'),
              trailing: Switch(
                value: _isMaintenanceMode,
                onChanged: (value) {
                  _toggleMaintenanceMode();
                },
              ),
            ),

            Spacer(),

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
                  backgroundColor: Colors.red,
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
