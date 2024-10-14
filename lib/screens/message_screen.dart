import 'dart:async';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController _messageController = TextEditingController();
  List<Map<String, String>> alphabet = [
    {'letter': 'A', 'image': 'assets/sign_A.png'},
    {'letter': 'B', 'image': 'assets/sign_B.png'},
    {'letter': 'C', 'image': 'assets/sign_C.png'},
    {'letter': 'D', 'image': 'assets/sign_D.png'},
    {'letter': 'E', 'image': 'assets/sign_E.png'},
    {'letter': 'F', 'image': 'assets/sign_F.png'},
    {'letter': 'G', 'image': 'assets/sign_G.png'},
    {'letter': 'H', 'image': 'assets/sign_H.png'},
    {'letter': 'I', 'image': 'assets/sign_I.png'},
    {'letter': 'J', 'image': 'assets/sign_J.png'},
    {'letter': 'K', 'image': 'assets/sign_K.png'},
    {'letter': 'L', 'image': 'assets/sign_L.png'},
    {'letter': 'M', 'image': 'assets/sign_M.png'},
    {'letter': 'N', 'image': 'assets/sign_N.png'},
    {'letter': 'Ñ', 'image': 'assets/sign_Ñ.png'},
    {'letter': 'O', 'image': 'assets/sign_O.png'},
    {'letter': 'P', 'image': 'assets/sign_P.png'},
    {'letter': 'Q', 'image': 'assets/sign_Q.png'},
    {'letter': 'R', 'image': 'assets/sign_R.png'},
    {'letter': 'S', 'image': 'assets/sign_S.png'},
    {'letter': 'T', 'image': 'assets/sign_T.png'},
    {'letter': 'U', 'image': 'assets/sign_U.png'},
    {'letter': 'V', 'image': 'assets/sign_V.png'},
    {'letter': 'W', 'image': 'assets/sign_W.png'},
    {'letter': 'X', 'image': 'assets/sign_X.png'},
    {'letter': 'Y', 'image': 'assets/sign_Y.png'},
    {'letter': 'Z', 'image': 'assets/sign_Z.png'},
  ];

  List<Map<String, String>> displayedLetters = [];
  int currentLetterIndex = 0;
  Timer? _timer;

  void _startDisplayingLetters(String message) {
    displayedLetters.clear();
    currentLetterIndex = 0;

    // Convertir el mensaje a mayúsculas y buscar las imágenes correspondientes
    for (int i = 0; i < message.length; i++) {
      String char = message[i].toUpperCase();
      var letter = alphabet.firstWhere(
          (element) => element['letter'] == char,
          orElse: () => {'letter': char, 'image': 'assets/default.png'});
      displayedLetters.add(letter);
    }

    // Iniciar temporizador para mostrar una letra cada 2 segundos
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (currentLetterIndex < displayedLetters.length) {
        setState(() {
          currentLetterIndex++;
        });
      } else {
        // Una vez terminado el recorrido, ocultar la palabra y borrar el texto
        setState(() {
          _timer?.cancel();
          displayedLetters.clear();
          currentLetterIndex = 0;
          _messageController.clear();  // Borrar el mensaje escrito
        });
      }
    });
  }

  void _sendMessage() {
    // Cerrar el teclado
    FocusScope.of(context).unfocus();

    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      _startDisplayingLetters(message); // Comenzar a mostrar el mensaje
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancelar el temporizador al salir de la pantalla
    _messageController.dispose(); // Limpiar el controlador del mensaje
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enviar mensaje'),
        backgroundColor: Colors.blue[800],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Mostrar la palabra completa en la parte superior, con la letra actual destacada
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (displayedLetters.isNotEmpty)
                  for (int i = 0; i < displayedLetters.length; i++)
                    Text(
                      displayedLetters[i]['letter'] ?? '',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: i == currentLetterIndex - 1
                            ? Colors.orange
                            : Colors.black, // Cambiar de color la letra actual
                      ),
                    ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Cuadro central con la imagen de la letra
          Expanded(
            child: Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: currentLetterIndex <= displayedLetters.length &&
                          displayedLetters.isNotEmpty
                      ? Image.asset(
                          displayedLetters[currentLetterIndex == 0
                              ? 0
                              : currentLetterIndex - 1]['image']!,
                          fit: BoxFit.cover,
                        )
                      : const Text(
                          'No hay mensaje',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ),
          ),

          // Campo de entrada de mensaje
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Escribe tu mensaje',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Botón de enviar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _sendMessage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Color del botón
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Enviar mensaje',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
