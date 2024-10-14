import 'package:flutter/material.dart';

class WordByKeyboardScreen extends StatefulWidget {
  @override
  _WordByKeyboardScreenState createState() => _WordByKeyboardScreenState();
}

class _WordByKeyboardScreenState extends State<WordByKeyboardScreen> {
  TextEditingController _messageController = TextEditingController();
  List<String> letterImages = [];

  // Alfabeto con las imágenes correspondientes a cada letra
  final Map<String, String> alphabet = {
    'A': 'assets/sign_A.png',
    'B': 'assets/sign_B.png',
    'C': 'assets/sign_C.png',
    'D': 'assets/sign_D.png',
    'E': 'assets/sign_E.png',
    'F': 'assets/sign_F.png',
    'G': 'assets/sign_G.png',
    'H': 'assets/sign_H.png',
    'I': 'assets/sign_I.png',
    'J': 'assets/sign_J.png',
    'K': 'assets/sign_K.png',
    'L': 'assets/sign_L.png',
    'M': 'assets/sign_M.png',
    'N': 'assets/sign_N.png',
    'Ñ': 'assets/sign_Ñ.png',
    'O': 'assets/sign_O.png',
    'P': 'assets/sign_P.png',
    'Q': 'assets/sign_Q.png',
    'R': 'assets/sign_R.png',
    'S': 'assets/sign_S.png',
    'T': 'assets/sign_T.png',
    'U': 'assets/sign_U.png',
    'V': 'assets/sign_V.png',
    'W': 'assets/sign_W.png',
    'X': 'assets/sign_X.png',
    'Y': 'assets/sign_Y.png',
    'Z': 'assets/sign_Z.png',
  };

  // Función para actualizar las imágenes basado en la palabra ingresada
  void _updateImages(String message) {
    List<String> images = [];

    // Convertir el mensaje a mayúsculas
    String uppercaseMessage = message.toUpperCase();

    // Recorremos cada letra del mensaje y añadimos la imagen correspondiente
    for (int i = 0; i < uppercaseMessage.length; i++) {
      String letter = uppercaseMessage[i];
      if (letter == ' ') {
        images.add('SPACE'); // Marcador para espacio
      } else if (alphabet.containsKey(letter)) {
        images.add(alphabet[letter]!); // Agregar la imagen correspondiente
      }
    }

    setState(() {
      letterImages = images; // Actualizamos la lista de imágenes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palabra por teclado'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de texto donde se escribe el mensaje
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Escribe tu palabra',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Mostrar las imágenes de cada letra si están presentes
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Cantidad de columnas en la cuadrícula
                  crossAxisSpacing: 10, // Espaciado entre las columnas
                  mainAxisSpacing: 10, // Espaciado entre las filas
                  childAspectRatio: 0.8, // Ajustar el aspecto para las imágenes
                ),
                itemCount: letterImages.length,
                itemBuilder: (context, index) {
                  if (letterImages[index] == 'SPACE') {
                    // Mostrar un contenedor vacío para el espacio
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: Center(
                        child: Text(
                          ' ', // Representación del espacio visual
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  } else {
                    // Mostrar la imagen correspondiente
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: Image.asset(
                        letterImages[index],
                        fit: BoxFit.cover, // Ajustar imagen al espacio
                      ),
                    );
                  }
                },
              ),
            ),

            // Botón para enviar la palabra
            ElevatedButton.icon(
              onPressed: () {
                // Actualizar las imágenes basadas en la palabra ingresada solo cuando se presione el botón
                _updateImages(_messageController.text);

                // Cerrar el teclado automáticamente
                FocusScope.of(context).unfocus();
              },
              icon: Icon(Icons.send),
              label: const Text('Enviar palabra'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Color de fondo del botón
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
