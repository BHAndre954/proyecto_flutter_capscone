import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_flutter_capscone/screens/signin_screen.dart';
import 'package:proyecto_flutter_capscone/utils/navigation_utils.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentIndex = 0;
  final List<String> imagesList = [
    'assets/image1.jpg',
    'assets/image1.jpg',
    'assets/image1.jpg',
  ];

  final List<String> titles = [
    "Traducción de Lenguaje de Señas",
    "Reconocimiento de Gestos",
    "Fácil y Accesible",
  ];

  final List<String> descriptions = [
    "Aplicación móvil que traduce el lenguaje de señas en tiempo real.",
    "Reconocimiento avanzado de gestos a través de redes neuronales.",
    "Interfaz amigable y accesible para todo tipo de usuarios.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Carousel con temporizador automático
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.45, // Reduce el espacio asignado
              enlargeCenterPage: true,
              autoPlay: true, // Habilitar la transición automática
              autoPlayInterval: const Duration(seconds: 3), // Cambiar cada 3 segundos
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: imagesList.map((item) => _buildCarouselItem(item)).toList(),
          ),
          const SizedBox(height: 20),
          // Animación de transición para el título
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Text(
              titles[_currentIndex],
              key: ValueKey(_currentIndex), // Clave única para la animación
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Animación de transición para la descripción
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Padding(
              key: ValueKey(_currentIndex), // Clave única para la animación
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                descriptions[_currentIndex],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800], // Color más oscuro para mejor legibilidad
                  fontWeight: FontWeight.w500, // Peso de fuente más grueso
                ),
              ),
            ),
          ),
          const Spacer(),
          // Botones de "Skip" y "Next/Finish"
          _buildBottomNavigation(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Método para construir cada slide del carrusel con un tamaño más controlado
  Widget _buildCarouselItem(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 300,  // Tamaño máximo de las imágenes
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.contain, // Ajuste adecuado sin ocupar demasiado espacio
          ),
        ),
      ),
    );
  }

  // Barra de navegación inferior (Skip, dots, Next/Finish)
  Widget _buildBottomNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            // Saltar el carrusel e ir a la pantalla de inicio de sesión
            Navigator.pushReplacement(
              context,
              createRoute(SignInScreen()),
            );
          },
          child: const Text("Skip"),
        ),
        // Dots indicativos del número de slide actual
        Row(
          children: imagesList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => setState(() {
                _currentIndex = entry.key;
              }),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
        TextButton(
          onPressed: () {
            // Si no es la última página, ir a la siguiente, si es la última, ir al SignInScreen
            if (_currentIndex == imagesList.length - 1) {
              Navigator.pushReplacement(
                context,
                createRoute(SignInScreen()),
              );
            } else {
              setState(() {
                _currentIndex++;
              });
            }
          },
          child: Text(_currentIndex == imagesList.length - 1 ? "Finish" : "Next"),
        ),
      ],
    );
  }
}
