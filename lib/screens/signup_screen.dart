import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_flutter_capscone/screens/home_screen.dart';
import 'package:proyecto_flutter_capscone/utils/color_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  bool _isLoading = false;

  // Validación de formato de correo
  bool isValidEmail(String email) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Registrarce",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                // Campo para el nombre de usuario
                TextField(
                  controller: _userNameTextController,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black.withOpacity(0.9)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Colors.black.withOpacity(0.9),
                    ),
                    labelText: "Ingrese su nombre",
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

                // Campo para el correo electrónico
                TextField(
                  controller: _emailTextController,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black.withOpacity(0.9)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined, // Cambié a un ícono de correo
                      color: Colors.black.withOpacity(0.9),
                    ),
                    labelText: "Ingrese su correo",
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

                // Campo para la contraseña
                TextField(
                  controller: _passwordTextController,
                  obscureText: true,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black.withOpacity(0.9)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outlined,
                      color: Colors.black.withOpacity(0.9),
                    ),
                    labelText: "Ingrese su contraseña",
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

                // Botón de "Sign Up" con indicador de carga
                ElevatedButton(
                  onPressed: () async {
                    // Validación de los campos
                    if (_userNameTextController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Por favor ingrese su nombre.")),
                      );
                      return;
                    }

                    if (_emailTextController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Por favor ingrese su correo.")),
                      );
                      return;
                    }

                    if (!isValidEmail(_emailTextController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text("Por favor, ingrese un correo válido.")),
                      );
                      return;
                    }

                    if (_passwordTextController.text.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                "La contraseña debe contener al menos 6 caracteres.")),
                      );
                      return;
                    }

                    // Activar el estado de carga
                    setState(() {
                      _isLoading = true;
                    });

                    // Intentar crear la cuenta
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text,
                      );
                      print("Nueva cuenta creada");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } on FirebaseAuthException catch (e) {
                      String errorMessage;
                      if (e.code == 'email-already-in-use') {
                        errorMessage = 'El correo ya está registrado.';
                      } else if (e.code == 'weak-password') {
                        errorMessage = 'La contraseña es demasiado débil.';
                      } else if (e.code == 'invalid-email') {
                        errorMessage = 'El correo electrónico no es válido.';
                      } else {
                        errorMessage = 'Error al registrar: ${e.message}';
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );
                    } finally {
                      // Desactivar el estado de carga
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Registrate",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color(0xFF400C5C);
                      }
                      return const Color(0xFF400C5C);
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}