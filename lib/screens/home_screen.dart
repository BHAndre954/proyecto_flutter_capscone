import 'package:flutter/material.dart';
import 'package:proyecto_flutter_capscone/screens/profile_page.dart';
import 'package:proyecto_flutter_capscone/screens/about_us_page.dart';
import 'package:proyecto_flutter_capscone/screens/learning_screen.dart'; // Importar la nueva pantalla de aprendizaje

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Actualizar las secciones para los nuevos módulos
  List<String> sections = ['Aprendizaje', 'Práctica', 'Comunicación', 'Materiales de Apoyo'];
  List<String> filteredSections = [];

  @override
  void initState() {
    super.initState();
    filteredSections = sections;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions(BuildContext context, List<String> filteredSections) {
    return [
      // Pantalla principal con los cuatro módulos
      Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: filteredSections.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
              ),
              itemBuilder: (context, index) {
                // Manejar la acción al tocar cada uno de los módulos
                return GestureDetector(
                  onTap: () {
                    switch (index) {
                      case 0:
                        // Navegar al módulo de Aprendizaje
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LearningScreen(),
                          ),
                        );
                        break;
                      case 1:
                        // Navegar al módulo de Práctica
                        print('Módulo de Práctica seleccionado');
                        break;
                      case 2:
                        // Navegar al módulo de Comunicación
                        print('Módulo de Comunicación seleccionado');
                        break;
                      case 3:
                        // Navegar al módulo de Materiales de Apoyo
                        print('Módulo de Materiales de Apoyo seleccionado');
                        break;
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Definir iconos específicos para cada módulo
                        Icon(
                          index == 0
                              ? Icons.school // Aprendizaje
                              : index == 1
                                  ? Icons.gamepad // Práctica o Juegos
                                  : index == 2
                                      ? Icons.message // Comunicación
                                      : Icons.library_books, // Materiales de Apoyo
                          size: 50,
                          color: Colors.blue[800],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          filteredSections[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Página de perfil
      ProfilePage(),

      // Página de información "Sobre Nosotros"
      AboutUsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🧏‍♂️ COMUNIMUNDO 🧏‍♀️',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
      ),
      body: _widgetOptions(context, filteredSections)[_selectedIndex], // Renderizar el contenido
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Sobre Nosotros',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped, // Cambiar entre inicio, perfil y sobre nosotros
      ),
    );
  }
}
