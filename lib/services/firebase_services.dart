import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyecto_flutter_capscone/screens/maintenance_screen.dart';
import 'package:proyecto_flutter_capscone/screens/home_screen.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final _firestore = FirebaseFirestore.instance;

  // Método para iniciar sesión con Google y verificar rol y mantenimiento
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential = await _auth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          // Verificar si el usuario tiene rol asignado
          final userDoc = _firestore.collection('users').doc(user.uid);
          final docSnapshot = await userDoc.get();

          if (!docSnapshot.exists) {
            // Crear el documento de usuario con rol predeterminado "Usuario"
            await userDoc.set({
              'name': user.displayName ?? '',
              'lastName': '',
              'email': user.email,
              'birthDate': '',
              'nationality': '',
              'isDeafOrBlind': false,
              'role': 'Usuario',
              'createdAt': FieldValue.serverTimestamp(),
            });
          } else if (docSnapshot.data()?['role'] == null) {
            // Actualizar el rol a "Usuario" si el campo "role" está vacío
            await userDoc.update({'role': 'Usuario'});
          }

          // Verificar el modo de mantenimiento
          final settingsDoc = await _firestore.collection('settings').doc('appConfig').get();
          final isMaintenanceMode = settingsDoc.data()?['isMaintenanceMode'] ?? false;
          final role = (await userDoc.get()).data()?['role'];

          // Redirigir al usuario dependiendo del rol y estado de mantenimiento
          if (isMaintenanceMode && role != 'Administrador') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('La aplicación está en modo de mantenimiento')),
            );
            await _auth.signOut(); // Cerrar sesión si el usuario no es administrador
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => role == 'Administrador' ? MaintenanceScreen() : HomeScreen(),
              ),
            );
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Error al iniciar sesión con Google')),
      );
      throw e;
    }
  }

  // Método para cerrar sesión
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
