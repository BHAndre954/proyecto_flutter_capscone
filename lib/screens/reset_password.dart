import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_flutter_capscone/utils/color_utils.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailTextController = TextEditingController();
  bool _isLoading = false; // Indicador de carga

  // Validación de formato de correo
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
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
          "Reestablecer contraseña",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
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
            end: Alignment.bottomCenter
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                
                // Campo de texto para el correo electrónico
                TextField(
                  controller: _emailTextController,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black.withOpacity(0.9)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined, // Ícono de correo
                      color: Colors.black.withOpacity(0.9),
                    ),
                    labelText: "Ingrese el correo electrónico",
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                
                // Botón de "Reset Password" con indicador de carga
                ElevatedButton(
                  onPressed: () async {
                    // Validar que el campo no esté vacío
                    if (_emailTextController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Por favor ingrese su correo electrónico.")),
                      );
                      return;
                    }

                    // Validar que el formato del correo sea válido
                    if (!isValidEmail(_emailTextController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Por favor ingrese un correo electrónico válido.")),
                      );
                      return;
                    }

                    // Mostrar el indicador de carga
                    setState(() {
                      _isLoading = true;
                    });

                    // Intentar enviar el correo de restablecimiento de contraseña
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: _emailTextController.text,
                      );
                      
                      // Mostrar mensaje genérico, ya que no podemos saber si el correo está registrado o no
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Si existe una cuenta para este correo electrónico, se ha enviado un enlace para restablecer la contraseña.")),
                      );
                      Navigator.of(context).pop();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: ${e.toString()}")),
                      );
                    } finally {
                      // Ocultar el indicador de carga
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  child: _isLoading 
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Restablecer contraseña",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
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
