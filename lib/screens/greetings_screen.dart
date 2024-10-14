import 'package:flutter/material.dart';

class GreetingsScreen extends StatelessWidget {
  final List<Map<String, String>> greetings = [
    {
      'greeting': 'Hola',
      'image': 'assets/hola.gif',
      'description': 'Un saludo simple pero poderoso que nos conecta con los demás.',
    },
    {
      'greeting': '¿Cómo estás?',
      'image': 'assets/comoestas.gif',
      'description': 'Una pregunta común que muestra interés en el bienestar de la otra persona.',
    },
    {
      'greeting': 'Gracias',
      'image': 'assets/gracias.gif',
      'description': 'Una expresión de gratitud y reconocimiento.',
    },
    {
      'greeting': 'De nada',
      'image': 'assets/denada.gif',
      'description': 'Una respuesta a un agradecimiento, mostrando cortesía.',
    },
    {
      'greeting': 'Adiós',
      'image': 'assets/adios.gif',
      'description': 'Una despedida que marca el final de una conversación o encuentro.',
    },
    {
      'greeting': 'Buenos dias',
      'image': 'assets/buenosdias.gif',
      'description': 'Un deseo de que el día sea agradable y productivo.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saludos'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: greetings.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.only(bottom: 16), // Espacio entre las tarjetas
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    child: Image.asset(
                      greetings[index]['image']!,
                      height: 200, // Ajuste de altura de la imagen
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          greetings[index]['greeting']!,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          greetings[index]['description']!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
