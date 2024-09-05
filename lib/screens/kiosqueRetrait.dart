import 'package:flutter/material.dart';
import 'package:untitled/services/user_service.dart';

class KioskWithdrawal extends StatefulWidget {
  @override
  _KioskWithdrawalState createState() => _KioskWithdrawalState();
}

class _KioskWithdrawalState extends State<KioskWithdrawal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  bool _loading = false;

  // Fonction pour afficher un modal de confirmation
  void _showConfirmationModal(BuildContext context, String codeRetrait) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation du Code de Retrait',
              style: TextStyle(fontSize: 17, fontFamily: "Poppins")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Code de retrait : $codeRetrait',
                  style: const TextStyle(fontSize: 16, fontFamily: "Poppins")),
              const SizedBox(height: 10),
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
                await _validateCode();
              },
            ),
          ],
        );
      },
    );
  }

  // Fonction pour valider le code de retrait
  Future<void> _validateCode() async {
    final code = _codeController.text.trim();

    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer un code de retrait')),
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    final token =
        await getToken(); // Assurez-vous d'obtenir le token correctement
    final result = await validerRetraitAuKiosque(code, token);

    setState(() {
      _loading = false;
    });

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Code de retrait validé avec succès')),
      );
      // Réinitialiser le champ après succès
      _codeController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(result['message'] ?? 'Code de retrait invalide')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Retraits',
            style: TextStyle(
                fontSize: 24, color: Colors.deepPurple, fontFamily: "Poppins")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: 'Code de retrait',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      fontSize: 15, fontFamily: "Poppins", color: Colors.grey),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un code de retrait';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _showConfirmationModal(
                              context, _codeController.text.trim());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 32.0),
                        textStyle: const TextStyle(
                            fontSize: 16, fontFamily: "Poppins"),
                      ),
                      child: const Text('Valider'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
