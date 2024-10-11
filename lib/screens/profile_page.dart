import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _nationalityController = TextEditingController();
  bool _isDeafOrMute = false;
  bool _isBirthDateEditable = true; // Editable solo la primera vez
  bool _isEditable = false; // Para habilitar o deshabilitar la edición

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Cargar los datos del usuario cuando la pantalla se inicia
  }

  // Cargar datos del usuario desde Firestore
  void _loadUserData() async {
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (userData.exists && userData.data() != null) {
      var data = userData.data() as Map<String, dynamic>;

      setState(() {
        _nameController.text = data.containsKey('name') ? data['name'] : '';
        _lastNameController.text =
            data.containsKey('lastName') ? data['lastName'] : '';
        _birthDateController.text =
            data.containsKey('birthDate') ? data['birthDate'] : '';
        _nationalityController.text =
            data.containsKey('nationality') ? data['nationality'] : '';
        _isDeafOrMute =
            data.containsKey('isDeafOrMute') ? data['isDeafOrMute'] : false;

        // Si la fecha de nacimiento ya está guardada, bloquear la edición
        _isBirthDateEditable =
            data.containsKey('birthDate') && data['birthDate'].isNotEmpty
                ? false
                : true;
      });
    }
  }

  // Guardar los datos del usuario en Firestore
  void _saveUserData() async {
    if (_birthDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Por favor selecciona una fecha de nacimiento válida.')),
      );
      return;
    }

    // Mostrar la ventana emergente de confirmación solo si la fecha es editable (primera edición)
    if (_isBirthDateEditable) {
      bool shouldSave = await _showConfirmationDialog();

      if (!shouldSave) {
        return; // Si el usuario cancela, no guardamos los datos
      }
    }

    // Guardar los datos en Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'name': _nameController.text,
      'lastName': _lastNameController.text,
      'birthDate': _birthDateController.text,
      'nationality': _nationalityController.text,
      'isDeafOrMute': _isDeafOrMute,
    });

    setState(() {
      _isEditable = false; // Deshabilitar la edición después de guardar
      _isBirthDateEditable =
          false; // Bloquear la edición de la fecha de nacimiento
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Datos guardados correctamente.')),
    );
  }

  // Mostrar el selector de fecha (DatePicker)
  Future<void> _selectDate(BuildContext context) async {
    if (_isEditable && _isBirthDateEditable) {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );

      if (pickedDate != null) {
        setState(() {
          _birthDateController.text =
              DateFormat('yyyy-MM-dd').format(pickedDate);
        });
      }
    }
  }

  // Ventana emergente para confirmar los datos antes de guardar (solo para el primer guardado)
  Future<bool> _showConfirmationDialog() async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirmar Datos'),
              content: Text(
                '¿Estás seguro de que los datos ingresados son correctos? '
                'Una vez guardados, no podrás editar la fecha de nacimiento.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // No guardar
                  },
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Guardar
                  },
                  child: Text('Guardar'),
                ),
              ],
            );
          },
        ) ??
        false; // Retornar false si el usuario cancela
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              enabled: _isEditable,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _lastNameController,
              enabled: _isEditable,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            GestureDetector(
              onTap: _isEditable && _isBirthDateEditable
                  ? () => _selectDate(
                      context) // Mostrar el DatePicker si es editable
                  : null, // Deshabilitar el DatePicker si no es editable
              child: AbsorbPointer(
                absorbing: true, // Bloquear la entrada de texto manual
                child: TextField(
                  controller: _birthDateController,
                  decoration: InputDecoration(
                    labelText: 'Fecha de Nacimiento (YYYY-MM-DD)',
                    hintText: 'YYYY-MM-DD',
                    labelStyle: TextStyle(
                      color: _isEditable && _isBirthDateEditable
                          ? Colors.black
                          : Colors
                              .grey, // Cambia el color del texto si está habilitado o no
                    ),
                  ),
                  style: TextStyle(
                    color: _isEditable && _isBirthDateEditable
                        ? Colors.black // Texto en negro si está editable
                        : Colors.grey, // Texto en gris si está deshabilitado
                    fontWeight: _isEditable && _isBirthDateEditable
                        ? FontWeight.normal // Negrita solo si está editable
                        : FontWeight.normal, // Texto normal cuando no editable
                  ),
                ),
              ),
            ),
            TextField(
              controller: _nationalityController,
              enabled: _isEditable,
              decoration: InputDecoration(labelText: 'Nacionalidad'),
            ),
            SwitchListTile(
              title: Text('¿Es sordomudo?'),
              value: _isDeafOrMute,
              onChanged: _isEditable
                  ? (value) {
                      setState(() {
                        _isDeafOrMute = value;
                      });
                    }
                  : null,
            ),
            Text(
              FirebaseAuth.instance.currentUser!.email!,
              style: TextStyle(color: Colors.grey), // Email solo de lectura
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isEditable
            ? _saveUserData
            : () {
                setState(() {
                  _isEditable =
                      true; // Habilitar la edición al hacer clic en el botón
                });
              },
        child: Icon(_isEditable ? Icons.save : Icons.edit),
      ),
    );
  }
}
