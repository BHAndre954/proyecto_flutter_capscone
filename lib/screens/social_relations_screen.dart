import 'package:flutter/material.dart';

class SocialRelationsScreen extends StatelessWidget {
  final List<Map<String, String>> relations = [
    {
      'title': 'Hola',
      'image': 'assets/G1.gif',
      'description': 'Hola, no es solo una palabra, es un puente hacia la conexión.',
    },
    {
      'title': '¿Cómo estás?',
      'image': 'assets/G2.gif',
      'description': 'Es un gesto que nos recuerda que la empatía y la preocupación por los demás son fundamentales en nuestra vida.',
    },
    {
      'title': 'Bien',
      'image': 'assets/G3.gif',
      'description': 'Bien es un reflejo de la armonía, la satisfacción y el equilibrio en nuestras vidas.',
    },
    {
      'title': 'Mal',
      'image': 'assets/G4.gif',
      'description': 'El mal es un concepto que ha sido objeto de reflexión y debate a lo largo de la historia de la humanidad.',
    },
    {
      'title': 'Gracias',
      'image': 'assets/G5.gif',
      'description': 'Es una expresión de aprecio y reconocimiento hacia aquellos que han contribuido a nuestra vida.',
    },
    {
      'title': 'De nada',
      'image': 'assets/G6.gif',
      'description': 'Estamos transmitiendo un mensaje de cortesía y gratitud.',
    },
    {
      'title': 'Con permiso',
      'image': 'assets/G7.gif',
      'description': 'Es más que una simple cortesía; es una muestra de respeto y consideración hacia los demás.',
    },
    {
      'title': 'No',
      'image': 'assets/G8.gif',
      'description': 'Puede ser un límite que establecemos para proteger nuestra integridad o una decisión que tomamos.',
    },
    {
      'title': 'Sí',
      'image': 'assets/G9.gif',
      'description': 'El paso que nos acerca a nuestros sueños y metas, y la afirmación que nos impulsa a creer en nosotros mismos.',
    },
    {
      'title': 'Perdón',
      'image': 'assets/G10.gif',
      'description': 'Al perdonar, elegimos soltar el peso del resentimiento y la ira, abriendo espacio en nuestros corazones para la sanación.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relaciones Sociales'),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: relations.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4,
            margin: EdgeInsets.only(bottom: 20), // Espacio entre tarjetas
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  child: Image.asset(
                    relations[index]['image']!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        relations[index]['title']!,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        relations[index]['description']!,
                        style: TextStyle(
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
    );
  }
}
