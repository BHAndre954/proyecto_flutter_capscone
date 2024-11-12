import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_flutter_capscone/screens/home_screen.dart';
import 'package:proyecto_flutter_capscone/screens/maintenance_screen.dart';
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
  bool _isLoading = false;
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  // Validación de email
  bool isValidEmail(String email) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }

  // Método para obtener el rol del usuario desde Firestore
  Future<String?> _getUserRole(String uid) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return snapshot['role'] as String?;
  }

  // Método para verificar el estado de mantenimiento
  Future<bool> _checkMaintenanceMode() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('settings')
        .doc('appConfig')
        .get();
    return snapshot['isMaintenanceMode'] ?? false;
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

                forgetPassword(context),

                ElevatedButton(
                  onPressed: () async {
                    if (_emailTextController.text.isEmpty ||
                        !isValidEmail(_emailTextController.text) ||
                        _passwordTextController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Verifica tu correo y contraseña.")),
                      );
                      return;
                    }

                    setState(() {
                      _isLoading = true;
                    });

                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text,
                      );

                      String uid = userCredential.user!.uid;
                      String? role = await _getUserRole(uid);
                      bool isMaintenanceMode = await _checkMaintenanceMode();

                      if (isMaintenanceMode && role != 'Administrador') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'La aplicación está en modo de mantenimiento')),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => role == 'Administrador'
                                ? MaintenanceScreen()
                                : HomeScreen(),
                          ),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      String errorMessage = e.code == 'wrong-password'
                          ? 'Contraseña incorrecta. Intenta nuevamente.'
                          : e.code == 'user-not-found'
                              ? 'No se encontró un usuario con ese correo.'
                              : 'Ocurrió un error. Por favor, intenta de nuevo.';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("Iniciar Sesión",
                          style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.deepPurple,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                signUpOption(context),

                const SizedBox(height: 20),

                // Botón de inicio de sesión con Google en SignInScreen
                ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await FirebaseServices().signInWithGoogle(context);
                    setState(() {
                      _isLoading = false;
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
      const Text("¿No tiene una cuenta?",
          style: TextStyle(color: Colors.white70)),
      GestureDetector(
        onTap: () {
          Navigator.push(context, createRoute(SignUpScreen()));
        },
        child: const Text(" Regístrate",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
