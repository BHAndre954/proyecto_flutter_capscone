import 'package:cloud_firestore/cloud_firestore.dart';  // Asegúrate de importar Firestore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final _firestore = FirebaseFirestore.instance;  // Inicializa Firestore

  // Método para iniciar sesión con Google
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _auth.signInWithCredential(authCredential);

        // Crear un nuevo documento de usuario si no existe
        _createUserInFirestore();
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  // Crear un nuevo usuario en Firestore si no existe
  Future<void> _createUserInFirestore() async {
    final user = _auth.currentUser;

    if (user != null) {
      final userDoc = _firestore.collection('users').doc(user.uid);

      final docSnapshot = await userDoc.get();
      if (!docSnapshot.exists) {
        await userDoc.set({
          'name': user.displayName ?? '',
          'lastName': '',  // Campo vacío por defecto
          'email': user.email,
          'birthDate': '',
          'nationality': '',
          'isDeafOrBlind': false,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    }
  }

  // Obtener los datos del usuario desde Firestore
  Future<DocumentSnapshot> getUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      return _firestore.collection('users').doc(user.uid).get();
    }
    throw Exception("User not logged in");
  }

  // Actualizar los datos del usuario en Firestore
  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update(data);
    }
  }

  // Método para cerrar sesión
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
