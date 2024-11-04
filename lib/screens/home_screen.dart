import 'package:flutter/material.dart';
import 'package:proyecto_flutter_capscone/screens/profile_page.dart';
import 'package:proyecto_flutter_capscone/screens/about_us_page.dart';
import 'package:proyecto_flutter_capscone/screens/learning_screen.dart';
import 'package:proyecto_flutter_capscone/screens/practice_screen.dart';
import 'package:proyecto_flutter_capscone/screens/report_screen.dart'; // Importar la pantalla de reportes
import 'package:proyecto_flutter_capscone/screens/signin_screen.dart'; // Importar la pantalla de inicio de sesión

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Secciones o módulos de la app
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

  // Opciones de widget para la navegación por secciones
  List<Widget> _widgetOptions(BuildContext context) {
    return [
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
                return GestureDetector(
                  onTap: () {
                    switch (index) {
                      case 0:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LearningScreen(),
                          ),
                        );
                        break;
                      case 1:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PracticeScreen(),
                          ),
                        );
                        break;
                      case 2:
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Accediendo al módulo de Comunicación')),
                        );
                        break;
                      case 3:
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Accediendo al módulo de Materiales de Apoyo')),
                        );
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
                        Icon(
                          index == 0
                              ? Icons.school
                              : index == 1
                                  ? Icons.gamepad
                                  : index == 2
                                      ? Icons.message
                                      : Icons.library_books,
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
      ProfilePage(),
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
        actions: [
          // Botón para enviar reportes
          IconButton(
            icon: Icon(Icons.report_problem_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportIssueScreen()),
              );
            },
            tooltip: 'Enviar Reporte',
          ),
          // Botón para redirigir al SignInScreen (cerrar sesión)
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
                (route) => false,
              );
            },
            tooltip: 'Cerrar Sesión',
          ),
        ],
      ),
      body: _widgetOptions(context)[_selectedIndex],
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
        onTap: _onItemTapped,
      ),
    );
  }
}
