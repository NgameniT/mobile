import 'package:flutter/material.dart';
import 'package:untitled/services/user_service.dart'; // Assurez-vous que ce chemin est correct
import 'package:untitled/models/api_response.dart'; // Assurez-vous que ce chemin est correct

class SendScreen extends StatefulWidget {
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  final _formKey = GlobalKey<FormState>();

  // Champs du formulaire
  final TextEditingController _numeroDeCompteDestinataireController = TextEditingController();
  final TextEditingController _montantController = TextEditingController();

  // Fonction pour afficher le modal de confirmation
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
                'Numéro de compte destinataire: ${_numeroDeCompteDestinataireController.text}',
                style: const TextStyle(fontSize: 16, fontFamily: "Poppins"),
              ),
              const SizedBox(height: 10),
              Text(
                'Montant à envoyer: ${_montantController.text}',
                style: const TextStyle(fontSize: 16, fontFamily: "Poppins"),
              ),
              const SizedBox(height: 20),
              // Retrait du code de retrait car non nécessaire pour les transferts
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Confirmer'),
              onPressed: () async {
                Navigator.of(context).pop();
                await _effectuerTransfert();
              },
            ),
          ],
        );
      },
    );
  }

  // Fonction pour effectuer le transfert
  Future<void> _effectuerTransfert() async {
    final montant = _montantController.text;
    final numeroDeCompteDestinataire = _numeroDeCompteDestinataireController.text;

    ApiResponse response = await envoyerTransfert(
      montant: montant,
      numeroDeCompteDestinataire: numeroDeCompteDestinataire,
    );

    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${response.error}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transfert effectué avec succès')),
      );
      // Réinitialiser les champs après le transfert réussi
      _numeroDeCompteDestinataireController.clear();
      _montantController.clear();
    }
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
                controller: _numeroDeCompteDestinataireController,
                decoration: const InputDecoration(
                    labelText: 'Numéro de compte destinataire',
                    labelStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: "Poppins",
                        color: Colors.grey)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le numéro de compte destinataire';
                  }
                  // Vous pouvez ajouter une vérification supplémentaire ici si nécessaire
                  return null;
                },
              ),
              TextFormField(
                controller: _montantController,
                decoration: const InputDecoration(
                    labelText: 'Montant à envoyer',
                    labelStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: "Poppins",
                        color: Colors.grey)),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le montant à envoyer';
                  }
                  final montant = double.tryParse(value);
                  if (montant == null || montant <= 0) {
                    return 'Le montant doit être un nombre supérieur à 0';
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
