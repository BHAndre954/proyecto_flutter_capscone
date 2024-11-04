import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  final String githubUrl =
      "https://github.com/BHAndre954/proyecto_flutter_capscone";
  final String contactNumber = "+51972936216";
  final String email = "andre.bolanoshernandez@hotmail.com";

  void _launchURL(String url) async {
  try {
    await launch(url);
  } catch (e) {
    print('No se pudo abrir el enlace: $url');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Comunimundo',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Comunimundo es una aplicación educativa creada para ayudar a las personas a aprender y practicar el lenguaje de señas. Nuestro objetivo es facilitar el acceso a esta forma de comunicación para promover la inclusión y el entendimiento entre oyentes y personas con discapacidad auditiva.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Objetivos del Proyecto',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '• Fomentar el aprendizaje del lenguaje de señas.\n'
              '• Ofrecer recursos interactivos y educativos accesibles a todos.\n'
              '• Apoyar la inclusión y la igualdad de comunicación.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Características Principales',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '• Módulo de Aprendizaje: Aprende el alfabeto y palabras básicas en señas.\n'
              '• Módulo de Práctica: Envía mensajes y participa en juegos interactivos.\n'
              '• Módulo de Material de Apoyo: Recursos adicionales para ampliar el conocimiento.\n'
              '• Reconocimiento de Señales: Reconocimiento de gestos a través de la cámara (en desarrollo).',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Equipo de Desarrollo',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Somos estudiantes de la Universidad Privada del Norte de la carrera de Ingeniería de Sistemas. Este proyecto fue desarrollado por el siguiente equipo:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '• CANDIA URBANO MICHAEL DANGELO\n'
              '• CORCUERA VALVERDE ALNICK\n'
              '• BOLAÑOS HERNANDEZ JOSEPH ANDRE (Líder)\n'
              '• FABRIZIO JAMED CASTRO BARRIENTOS',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Agradecimientos',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Expresamos nuestro agradecimiento a nuestros docentes, quienes nos han brindado orientación y apoyo fundamental durante el desarrollo de este proyecto:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '• Wilson Ricardo Marín Verástegui, profesor del curso CAPSTONE PROJECT SISTEMAS.\n'
              '• Guido Trujillo Valdiviezo, asesor de tesis.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Contacto',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Si deseas más información sobre Comunimundo, puedes contactarnos a través de los siguientes medios:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Teléfono: $contactNumber\nCorreo: $email',
              style: TextStyle(fontSize: 16, color: Colors.blue[800]),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  _launchURL(githubUrl);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                icon: Icon(Icons.code),
                label: Text('Visitar GitHub del Proyecto'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
