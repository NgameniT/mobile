import 'package:flutter/material.dart';

class ReceiveScreen extends StatefulWidget {
  const ReceiveScreen({super.key});

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();

  // Fonction pour afficher le modal avec les informations du retrait
  void _showRetraitInfoModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Informations de Retrait',
            style: TextStyle(fontFamily: "Poppins", fontSize: 17),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nom de l\'expéditeur: Jean Dupont',
                style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
              ),
              const SizedBox(height: 10),
              const Text(
                'Nom du receveur: Marie Dupont',
                style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
              ),
              const SizedBox(height: 10),
              const Text(
                'Adresse du receveur: 123 Rue Exemple, Paris',
                style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
              ),
              const SizedBox(height: 10),
              const Text(
                'Somme envoyée: 5000 XOF',
                style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
              ),
              const SizedBox(height: 20),
              Text('Code de retrait: ${_codeController.text}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: "Poppins")),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(fontFamily: "Poppins"),
              ),
              onPressed: () {
                Navigator.of(context).pop();
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
        title: const Text(
          'Retrait d\'argent',
          style: TextStyle(
              fontSize: 24, color: Colors.deepPurple, fontFamily: "Poppins"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(
                    labelText: 'Entrez le code de retrait',
                    labelStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: "Poppins",
                        color: Colors.grey)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le code de retrait';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _showRetraitInfoModal(context);
                  }
                },
                child: const Text(
                  'Valider',
                  style: TextStyle(fontFamily: "Poppins"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
