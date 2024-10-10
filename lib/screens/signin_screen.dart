import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_flutter_capscone/screens/home_screen.dart';
import 'package:proyecto_flutter_capscone/utils/navigation_utils.dart';
import 'package:proyecto_flutter_capscone/screens/reset_password.dart';
import 'package:proyecto_flutter_capscone/screens/signup_screen.dart';
import 'package:proyecto_flutter_capscone/services/firebase_services.dart';
import 'package:proyecto_flutter_capscone/utils/color_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoading = false; // Variable para manejar el estado de carga.
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  // Validación de email
  bool isValidEmail(String email) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 0),
            child: Column(
              children: <Widget>[
                // Logo
                Image.asset(
                  "assets/Logo.png",
                  fit: BoxFit.fitWidth,
                  width: 240,
                  height: 240,
                ),
                const SizedBox(height: 30),

                // Campo de texto para el correo electrónico
                TextField(
                  controller: _emailTextController,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black.withOpacity(0.9)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Colors.black.withOpacity(0.9),
                    ),
                    labelText: "Correo Electrónico",
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Campo de texto para la contraseña
                TextField(
                  controller: _passwordTextController,
                  obscureText: true,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black.withOpacity(0.9)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.black.withOpacity(0.9),
                    ),
                    labelText: "Contraseña",
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                // Función para recuperar contraseña
                forgetPassword(context),

                // Botón de "Iniciar Sesión" con indicador de carga
                ElevatedButton(
                  onPressed: () async {
                    // Validación específica de cada campo
                    if (_emailTextController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Por favor coloque su correo")),
                      );
                      return;
                    }

                    // Validación del formato del correo
                    if (!isValidEmail(_emailTextController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text("Por favor, ingrese un correo válido.")),
                      );
                      return;
                    }

                    if (_passwordTextController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Por favor coloque su contraseña")),
                      );
                      return;
                    }

                    // Activar indicador de carga
                    setState(() {
                      _isLoading = true;
                    });

                    // Intentar iniciar sesión
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } on FirebaseAuthException catch (e) {
                      String errorMessage;
                      if (e.code == 'wrong-password') {
                        errorMessage =
                            'Contraseña incorrecta. Intenta nuevamente.';
                      } else if (e.code == 'user-not-found') {
                        errorMessage =
                            'No se encontró un usuario con ese correo.';
                      } else if (e.code == 'invalid-email') {
                        errorMessage = 'El correo electrónico no es válido.';
                      } else if (e.code == 'too-many-requests') {
                        errorMessage =
                            'Demasiados intentos fallidos. Intenta más tarde.';
                      } else {
                        errorMessage =
                            'Ocurrió un error. Por favor, intenta de nuevo.';
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );
                    } finally {
                      // Desactivar indicador de carga al terminar el proceso
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  child:
                      _isLoading // Mostrar el indicador de carga o el texto "Iniciar Sesión"
                          ? CircularProgressIndicator(
                              color: Colors
                                  .white, // Cambiado a blanco para mayor coherencia
                            )
                          : Text(
                              "Iniciar Sesión",
                              style: const TextStyle(
                                color: Colors
                                    .white, // Cambiado a blanco para mejorar la legibilidad
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color(
                            0xFF400C5C); // Color cuando se presiona
                      }
                      return const Color(0xFF400C5C); // Color normal del botón
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Opción para registrarse
                signUpOption(context),

                const SizedBox(height: 20), // Espaciado adicional

                // Botón de inicio de sesión con Google
                ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {
                      _isLoading =
                          true; // Muestra el loading para Google Sign-In
                    });
                    await FirebaseServices().signInWithGoogle();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                    setState(() {
                      _isLoading =
                          false; // Desactiva el loading después del proceso
                    });
                  },
                  icon: Icon(Icons.account_circle_outlined),
                  label: Text("Iniciar sesión con Google"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Opción de registrarse
Row signUpOption(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "¿No tiene una cuenta?",
        style: TextStyle(color: Colors.white70),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            createRoute(SignUpScreen()),
          );
        },
        child: const Text(
          " Regístrate",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}

// Función para recuperar contraseña
Widget forgetPassword(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 35,
    alignment: Alignment.bottomRight,
    child: TextButton(
      child: const Text(
        "¿Has olvidado tu contraseña?",
        style: TextStyle(color: Colors.white70),
        textAlign: TextAlign.right,
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResetPassword()),
      ),
    ),
  );
}
