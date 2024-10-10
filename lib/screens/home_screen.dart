import 'package:flutter/material.dart';
import 'package:proyecto_flutter_capscone/screens/profile_page.dart';
import 'package:proyecto_flutter_capscone/screens/about_us_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<String> sections = ['Traducir con voz', 'Abecedario', 'Con teclado', 'Números', 'Colores', 'Sobre nosotros'];
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

 
  void filterSearchResults(String query) {
    List<String> dummyList = [];
    if (query.isNotEmpty) {
      sections.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          dummyList.add(item);
        }
      });
      setState(() {
        filteredSections = dummyList;
      });
    } else {
      setState(() {
        filteredSections = sections;
      });
    }
  }

  
  static List<Widget> _widgetOptions(BuildContext context, List<String> filteredSections, Function filterSearchResults) {
    return [
      
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              decoration: InputDecoration(
                labelText: "Buscar",
                hintText: "Buscar sección (ej. Colores)",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
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
                    print('Sección seleccionada: ${filteredSections[index]}');
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
                              ? Icons.mic
                              : index == 1
                                  ? Icons.text_fields
                                  : index == 2
                                      ? Icons.keyboard
                                      : index == 3
                                          ? Icons.format_list_numbered
                                          : Icons.color_lens, 
                          size: 50,
                          color: Colors.blue[800],
                        ),
                        SizedBox(height: 10),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '🧏‍♂️ COMUNIMUNDO 🧏‍♀️',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
      ),
      body: _widgetOptions(context, filteredSections, filterSearchResults)[_selectedIndex], 
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
