import 'package:flutter/material.dart';
import 'package:proyecto_flutter_capscone/screens/WelcomeScreen.dart';// O cambiar a SignInScreen según tu flujo

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Esperar 5 segundos y luego navegar a la pantalla de bienvenida o inicio de sesión
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()), // Cambiar a la pantalla que deseas
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo de tu aplicación
            Image.asset(
              'assets/Logo.png', // Asegúrate de tener tu logo en assets
              height: 150, // Ajustar tamaño según el logo
            ),
            const SizedBox(height: 20),
            // Nombre de la aplicación
            const Text(
              'COMUNIMUNDO',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            // Indicador de carga (círculo giratorio)
            const CircularProgressIndicator(
              color: Colors.black, // Cambiar color si es necesario
            ),
          ],
        ),
      ),
    );
  }
}
