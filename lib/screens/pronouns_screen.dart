import 'package:flutter/material.dart';

class PronounsScreen extends StatelessWidget {
  final List<Map<String, String>> pronouns = [
    {
      'pronoun': 'Yo',
      'image': 'assets/yo.gif',
      'description':
          'El pronombre personal que utilizamos para hablar de nosotros mismos.',
    },
    {
      'pronoun': 'Tú',
      'image': 'assets/tu.gif',
      'description':
          'El pronombre personal usado para dirigirse a la segunda persona en una conversación.',
    },
    {
      'pronoun': 'Él',
      'image': 'assets/el.gif',
      'description':
          'Este pronombre hace referencia a un individuo masculino en tercera persona.',
    },
    {
      'pronoun': 'Ella',
      'image': 'assets/ella.gif',
      'description':
          'El pronombre que usamos para hablar de una mujer en tercera persona.',
    },
    {
      'pronoun': 'Nosotros',
      'image': 'assets/nosotros.gif',
      'description':
          'Este pronombre se refiere a un grupo de personas que incluye a quien habla.',
    },
    {
      'pronoun': 'Ellos',
      'image': 'assets/ellos.gif',
      'description':
          'Este pronombre señala a un grupo de hombres o a un grupo mixto.',
    },
    {
      'pronoun': 'Ellas',
      'image': 'assets/ellas.gif',
      'description':
          'Este pronombre se usa cuando hacemos referencia a un grupo exclusivamente femenino.',
    },
    {
      'pronoun': 'Ustedes',
      'image': 'assets/ustedes.gif',
      'description':
          'Es el pronombre que usamos para dirigirnos a varias personas de manera formal o informal.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pronombres'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal, // Desplazamiento horizontal
          itemCount: pronouns.length,
          itemBuilder: (context, index) {
            return Container(
              width: 350, // Ancho de cada tarjeta ajustado
              margin: EdgeInsets.only(right: 20), // Espacio entre las tarjetas
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch, // Alinear contenido
                  children: [
                    // Ajuste en la altura del GIF para evitar que se vea tan grande
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      child: Image.asset(
                        pronouns[index]['image']!,
                        height: 300, // Reducir la altura del GIF
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50.0, horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pronouns[index]['pronoun']!,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            pronouns[index]['description']!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
