import 'package:flutter/material.dart';
import 'package:proyecto_flutter_capscone/screens/alphabet_screen.dart'; // Pantalla del abecedario
import 'package:proyecto_flutter_capscone/screens/numbers_screen.dart'; // Pantalla de los números
import 'package:proyecto_flutter_capscone/screens/colors_screen.dart';
import 'package:proyecto_flutter_capscone/screens/social_relations_screen.dart';
import 'package:proyecto_flutter_capscone/screens/pronouns_screen.dart';
import 'package:proyecto_flutter_capscone/screens/greetings_screen.dart';

class LearningScreen extends StatelessWidget {
  final List<Map<String, String>> learningCategories = [
    {'name': 'Abecedario', 'image': 'assets/alphabet.png'},
    {'name': 'Números', 'image': 'assets/numbers.png'},
    {'name': 'Colores', 'image': 'assets/colors.png'},
    {'name': 'Relaciones Sociales', 'image': 'assets/social.png'},
    {'name': 'Pronombres', 'image': 'assets/pronouns.png'},
    {'name': 'Saludos', 'image': 'assets/greetings.png'},
    {'name': 'Otros', 'image': 'assets/others.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Módulo de Aprendizaje'),
        backgroundColor: Colors.blue[800],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: learningCategories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                // Navegar a la pantalla del Abecedario
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlphabetScreen(),
                  ),
                );
              } else if (index == 1) {
                // Navegar a la pantalla de Números
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NumbersScreen(), // Redirige a la pantalla de Números
                  ),
                );
              } else if (index == 3) {
                // Navegar a la pantalla de Relaciones Sociales
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SocialRelationsScreen(),
                  ),
                );
              } else if (index == 2) {
                // Navegar a la pantalla de los colores
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ColorsScreen(),
                  ),
                );
              } else if (index == 4) {
                // Navegar a la pantalla de Pronombres
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PronounsScreen(),
                  ),
                );
              } else if (index == 5) {
                // Navegar a la pantalla de Saludos
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GreetingsScreen(),
                  ),
                );
              } else {
                // Puedes manejar otras secciones aquí
                print(
                    'Sección seleccionada: ${learningCategories[index]['name']}');
              }
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      learningCategories[index]['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    learningCategories[index]['name']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
