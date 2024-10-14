import 'package:flutter/material.dart';

class AlphabetScreen extends StatelessWidget {
  // Datos del abecedario con la imagen de la letra y la imagen del lenguaje de señas
  final List<Map<String, String>> alphabet = [
    {'letter': 'A', 'image': 'assets/A.png', 'sign': 'assets/sign_A.png'},
    {'letter': 'B', 'image': 'assets/B.png', 'sign': 'assets/sign_B.png'},
    {'letter': 'C', 'image': 'assets/C.png', 'sign': 'assets/sign_C.png'},
    {'letter': 'D', 'image': 'assets/D.png', 'sign': 'assets/sign_D.png'},
    {'letter': 'E', 'image': 'assets/E.png', 'sign': 'assets/sign_E.png'},
    {'letter': 'F', 'image': 'assets/F.png', 'sign': 'assets/sign_F.png'},
    {'letter': 'G', 'image': 'assets/G.png', 'sign': 'assets/sign_G.png'},
    {'letter': 'H', 'image': 'assets/H.png', 'sign': 'assets/sign_H.png'},
    {'letter': 'I', 'image': 'assets/I.png', 'sign': 'assets/sign_I.png'},
    {'letter': 'J', 'image': 'assets/J.png', 'sign': 'assets/sign_J.png'},
    {'letter': 'K', 'image': 'assets/K.png', 'sign': 'assets/sign_K.png'},
    {'letter': 'L', 'image': 'assets/L.png', 'sign': 'assets/sign_L.png'},
    {'letter': 'M', 'image': 'assets/M.png', 'sign': 'assets/sign_M.png'},
    {'letter': 'N', 'image': 'assets/N.png', 'sign': 'assets/sign_N.png'},
    {'letter': 'Ñ', 'image': 'assets/Ñ.png', 'sign': 'assets/sign_Ñ.png'},
    {'letter': 'O', 'image': 'assets/O.png', 'sign': 'assets/sign_O.png'},
    {'letter': 'P', 'image': 'assets/P.png', 'sign': 'assets/sign_P.png'},
    {'letter': 'Q', 'image': 'assets/Q.png', 'sign': 'assets/sign_Q.png'},
    {'letter': 'R', 'image': 'assets/R.png', 'sign': 'assets/sign_R.png'},
    {'letter': 'S', 'image': 'assets/S.png', 'sign': 'assets/sign_S.png'},
    {'letter': 'T', 'image': 'assets/T.png', 'sign': 'assets/sign_T.png'},
    {'letter': 'U', 'image': 'assets/U.png', 'sign': 'assets/sign_U.png'},
    {'letter': 'V', 'image': 'assets/V.png', 'sign': 'assets/sign_V.png'},
    {'letter': 'W', 'image': 'assets/W.png', 'sign': 'assets/sign_W.png'},
    {'letter': 'X', 'image': 'assets/X.png', 'sign': 'assets/sign_X.png'},
    {'letter': 'Y', 'image': 'assets/Y.png', 'sign': 'assets/sign_Y.png'},
    {'letter': 'Z', 'image': 'assets/Z.png', 'sign': 'assets/sign_Z.png'},
  ];

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abecedario'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Reducir el padding
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Mostrar 3 letras por fila
            crossAxisSpacing: 8.0, // Reducir el espaciado entre columnas
            mainAxisSpacing: 8.0, // Reducir el espaciado entre filas
          ),
          itemCount: alphabet.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Mostrar el detalle de la letra seleccionada
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
                            alphabet[index]['sign']!, // Imagen del lenguaje de señas
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Letra ${alphabet[index]['letter']}',
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
                      alphabet[index]['image']!,
                      height: 70, // Ajustar la altura para evitar desbordamiento
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      alphabet[index]['letter']!,
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
