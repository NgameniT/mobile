import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/services/user_service.dart';


class ReceiveScreen extends StatefulWidget {
  const ReceiveScreen({super.key});

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _montantController = TextEditingController();
  String? _codeRetrait;
  String? _errorMessage;
  String? _successMessage;

  Future<void> _submitRetrait() async {
    if (_formKey.currentState!.validate()) {
      final montant = _montantController.text;

      // Appel API pour initier le retrait
      final response = await initierRetrait(montant: montant);

      if (response.error != null) {
        setState(() {
          _errorMessage = response.error;
          _successMessage = null;
        });
      } else {
        setState(() {
          _successMessage = 'Retrait initié avec succès. Utilisez le code pour finaliser au kiosque.';
          _codeRetrait = (response.data as Map<String, dynamic>)['code_retrait']; // Assurez-vous que response.data est bien une Map
          _errorMessage = null;
        });
        // Afficher les informations du retrait dans un modal
        _showRetraitInfoModal(context);
      }
    }
  }

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
              const SizedBox(height: 10),
              Text(
                'Somme envoyée: ${_montantController.text} XOF',
                style: const TextStyle(fontSize: 16, fontFamily: "Poppins"),
              ),
              const SizedBox(height: 20),
              Text(
                'Code de retrait: ${_codeRetrait ?? 'Non disponible'}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: "Poppins"),
              ),
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
                controller: _montantController,
                decoration: const InputDecoration(
                    labelText: 'Entrez le montant du retrait',
                    labelStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: "Poppins",
                        color: Colors.grey)),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le montant';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitRetrait,
                child: const Text(
                  'Valider',
                  style: TextStyle(fontFamily: "Poppins"),
                ),
              ),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              if (_successMessage != null)
                Text(
                  _successMessage!,
                  style: TextStyle(color: Colors.green),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
