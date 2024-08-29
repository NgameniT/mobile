import 'package:flutter/material.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  final _formKey = GlobalKey<FormState>();

  // Champs du formulaire
  final TextEditingController _expediteurController = TextEditingController();
  final TextEditingController _receveurController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _sommeController = TextEditingController();

  // Fonction pour afficher le modale
  void _showConfirmationModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirmation de Transfert',
            style: TextStyle(fontSize: 17, fontFamily: "Poppins"),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nom de l\'expéditeur: ${_expediteurController.text}',
                style: const TextStyle(fontSize: 16, fontFamily: "Poppins"),
              ),
              const SizedBox(height: 10),
              Text(
                'Nom du receveur: ${_receveurController.text}',
                style: const TextStyle(fontSize: 16, fontFamily: "Poppins"),
              ),
              const SizedBox(height: 10),
              Text(
                'Adresse du receveur: ${_adresseController.text}',
                style: const TextStyle(fontSize: 16, fontFamily: "Poppins"),
              ),
              const SizedBox(height: 10),
              Text(
                'Somme à envoyer: ${_sommeController.text}',
                style: const TextStyle(fontSize: 16, fontFamily: "Poppins"),
              ),
              const SizedBox(height: 20),
              const Text('Code de retrait: 8665688965668686',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: "Poppins")),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
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
          'Transfert d\'argent',
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
                controller: _expediteurController,
                decoration: const InputDecoration(
                    labelText: 'Nom complet de l\'expéditeur',
                    labelStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: "Poppins",
                        color: Colors.grey)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom de l\'expéditeur';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _receveurController,
                decoration: const InputDecoration(
                    labelText: 'Nom complet du receveur',
                    labelStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: "Poppins",
                        color: Colors.grey)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom du receveur';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _adresseController,
                decoration: const InputDecoration(
                    labelText: 'Adresse du receveur',
                    labelStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: "Poppins",
                        color: Colors.grey)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer l\'adresse du receveur';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sommeController,
                decoration: const InputDecoration(
                    labelText: 'Somme à envoyer',
                    labelStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: "Poppins",
                        color: Colors.grey)),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la somme à envoyer';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _showConfirmationModal(context);
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
