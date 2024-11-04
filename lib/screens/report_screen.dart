import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReportIssueScreen extends StatefulWidget {
  @override
  _ReportIssueScreenState createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  TextEditingController _issueController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitIssue() async {
    if (_issueController.text.isEmpty) return;

    setState(() {
      _isSubmitting = true;
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('issues').add({
        'issue': _issueController.text,
        'timestamp': FieldValue.serverTimestamp(),
        'userId': user.uid,
        'userName': user.displayName ?? user.email, // Usar el nombre o el correo
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Reporte enviado con éxito")),
      );
      _issueController.clear();
    }

    setState(() {
      _isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reportar un Problema"),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Describe el problema o sugiere una mejora:",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _issueController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Escribe aquí...",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitIssue,
                child: _isSubmitting
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Enviar Reporte"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
