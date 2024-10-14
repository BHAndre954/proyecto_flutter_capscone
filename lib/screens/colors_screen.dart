import 'package:flutter/material.dart';

class ColorsScreen extends StatelessWidget {
  final List<Map<String, String>> colors = [
    {'color': 'Amarillo', 'image': 'assets/amarillo.png', 'sign': 'assets/sign_amarillo.PNG'},
    {'color': 'Anaranjado', 'image': 'assets/anaranjado.jpg', 'sign': 'assets/sign_anaranjado.PNG'},
    {'color': 'Azul', 'image': 'assets/azul.png', 'sign': 'assets/sign_azul.PNG'},
    {'color': 'Blanco', 'image': 'assets/blanco.jpg', 'sign': 'assets/sign_blanco.PNG'},
    {'color': 'Café', 'image': 'assets/cafe.png', 'sign': 'assets/sign_cafe.PNG'},
    {'color': 'Morado', 'image': 'assets/morado.png', 'sign': 'assets/sign_morado.PNG'},
    {'color': 'Negro', 'image': 'assets/negro.png', 'sign': 'assets/sign_negro.PNG'},
    {'color': 'Oro', 'image': 'assets/oro.jpg', 'sign': 'assets/sign_oro.PNG'},
    {'color': 'Plata', 'image': 'assets/plata.jpg', 'sign': 'assets/sign_plata.PNG'},
    {'color': 'Plomo', 'image': 'assets/plomo.jpg', 'sign': 'assets/sign_plomo.PNG'},
    {'color': 'Rojo', 'image': 'assets/rojo.png', 'sign': 'assets/sign_rojo.PNG'},
    {'color': 'Rosado', 'image': 'assets/rosado.jpg', 'sign': 'assets/sign_rosado.PNG'},
    {'color': 'Verde', 'image': 'assets/verde.jpg', 'sign': 'assets/sign_verde.PNG'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colores'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Reducir el padding
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Mostrar 3 colores por fila
            crossAxisSpacing: 8.0, // Reducir el espaciado entre columnas
            mainAxisSpacing: 8.0, // Reducir el espaciado entre filas
          ),
          itemCount: colors.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Mostrar el detalle del color seleccionado
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
                            colors[index]['sign']!, // Imagen del lenguaje de señas para el color
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Color ${colors[index]['color']}',
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
                      colors[index]['image']!,
                      height: 70, // Ajustar la altura para evitar desbordamiento
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      colors[index]['color']!,
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
