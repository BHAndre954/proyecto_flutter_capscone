import 'package:flutter/material.dart';

class NumbersScreen extends StatelessWidget {
  final List<Map<String, String>> numbers = [
    {'number': '1', 'image': 'assets/1.png', 'sign': 'assets/sign_1.png'},
    {'number': '2', 'image': 'assets/2.png', 'sign': 'assets/sign_2.png'},
    {'number': '3', 'image': 'assets/3.png', 'sign': 'assets/sign_3.png'},
    {'number': '4', 'image': 'assets/4.png', 'sign': 'assets/sign_4.png'},
    {'number': '5', 'image': 'assets/5.png', 'sign': 'assets/sign_5.png'},
    {'number': '6', 'image': 'assets/6.png', 'sign': 'assets/sign_6.png'},
    {'number': '7', 'image': 'assets/7.png', 'sign': 'assets/sign_7.png'},
    {'number': '8', 'image': 'assets/8.png', 'sign': 'assets/sign_8.png'},
    {'number': '9', 'image': 'assets/9.png', 'sign': 'assets/sign_9.png'},
    {'number': '10', 'image': 'assets/10.png', 'sign': 'assets/sign_10.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Números'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Reducir el padding
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Mostrar 3 números por fila
            crossAxisSpacing: 8.0, // Reducir el espaciado entre columnas
            mainAxisSpacing: 8.0, // Reducir el espaciado entre filas
          ),
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Mostrar el detalle del número seleccionado
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            numbers[index]['sign']!, // Imagen del lenguaje de señas
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Número ${numbers[index]['number']}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cerrar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      numbers[index]['image']!,
                      height: 70, // Ajustar la altura para evitar desbordamiento
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      numbers[index]['number']!,
                      style: const TextStyle(
                        fontSize: 20, // Ajustar el tamaño de la fuente
                        fontWeight: FontWeight.bold,
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