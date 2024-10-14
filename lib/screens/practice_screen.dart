import 'package:flutter/material.dart';
import 'package:proyecto_flutter_capscone/screens/message_screen.dart'; // Importa tu MessageScreen
import 'package:proyecto_flutter_capscone/screens/word_by_keyboard_screen.dart'; // Importa la nueva pantalla para "Palabra por teclado"

class PracticeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Práctica'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tarjeta para "Enviar mensaje"
            GestureDetector(
              onTap: () {
                // Navegar a la pantalla MessageScreen cuando se presione el botón
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MessageScreen()),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Icono o imagen
                      Icon(
                        Icons.send, // Icono de "Enviar mensaje"
                        size: 50,
                        color: Colors.blue[800],
                      ),
                      const SizedBox(width: 16), // Espacio entre el icono y el texto
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Enviar mensaje',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Barra de progreso (opcional)
                            LinearProgressIndicator(
                              value: 0.7, // Valor arbitrario
                              backgroundColor: Colors.purple[100],
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 16), // Espacio entre las tarjetas
            
            // Nueva tarjeta para "Palabra por teclado"
            GestureDetector(
              onTap: () {
                // Navegar a la pantalla WordByKeyboard cuando se presione el botón
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordByKeyboardScreen()),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Icono o imagen
                      Icon(
                        Icons.keyboard, // Icono para "Palabra por teclado"
                        size: 50,
                        color: Colors.blue[800],
                      ),
                      const SizedBox(width: 16), // Espacio entre el icono y el texto
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Palabra por teclado',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Barra de progreso (opcional)
                            LinearProgressIndicator(
                              value: 0.5, // Valor arbitrario
                              backgroundColor: Colors.purple[100],
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
