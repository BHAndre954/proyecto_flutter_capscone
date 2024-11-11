import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserManagementScreen extends StatefulWidget {
  @override
  _UserManagementScreenState createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  // Método para mostrar el diálogo de edición del usuario
  void _showEditUserDialog(BuildContext context, String userId, Map<String, dynamic> userData) {
    TextEditingController nameController = TextEditingController(text: userData['name'] ?? '');
    TextEditingController lastNameController = TextEditingController(text: userData['lastName'] ?? '');
    TextEditingController emailController = TextEditingController(text: userData['email'] ?? '');
    TextEditingController roleController = TextEditingController(text: userData['role'] ?? 'Usuario');
    TextEditingController birthDateController = TextEditingController(text: userData['birthDate'] ?? '');
    TextEditingController nationalityController = TextEditingController(text: userData['nationality'] ?? '');
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editar Usuario"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Nombre"),
                ),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(labelText: "Apellido"),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Correo"),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: roleController,
                  decoration: InputDecoration(labelText: "Rol"),
                ),
                TextField(
                  controller: birthDateController,
                  decoration: InputDecoration(labelText: "Fecha de Nacimiento"),
                ),
                TextField(
                  controller: nationalityController,
                  decoration: InputDecoration(labelText: "Nacionalidad"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Guardar"),
              onPressed: () async {
                // Actualizar la información en Firestore
                await usersCollection.doc(userId).update({
                  'name': nameController.text,
                  'lastName': lastNameController.text,
                  'email': emailController.text,
                  'role': roleController.text,
                  'birthDate': birthDateController.text,
                  'nationality': nationalityController.text,
                });
                
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Usuario actualizado exitosamente")),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestión de Usuarios"),
        backgroundColor: Colors.blue[800],
      ),
      body: StreamBuilder(
        stream: usersCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          return ListView(
            children: snapshot.data!.docs.map((userDoc) {
              var userData = userDoc.data() as Map<String, dynamic>;

              return Card(
                child: ListTile(
                  title: Text(userData['name'] ?? "Sin Nombre"),
                  subtitle: Text(userData['email'] ?? "Sin Correo"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.info, color: Colors.blue),
                        onPressed: () => _showEditUserDialog(context, userDoc.id, userData), // Mostrar diálogo de edición
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await usersCollection.doc(userDoc.id).delete();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Usuario eliminado")),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
