import 'package:flutter/material.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile de l\'Agent',
          style: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Card pour l'identité de l'agent
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Nom : Dupont',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Prénom : Jean',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'N° de l\'agent : AG12345678',
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Card pour les transactions
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Transactions',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]),
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Text(
                      'Total des envois effectués : 1,500,000 XOF',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green[700],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Total des retraits effectués : 800,000 XOF',
                      style: TextStyle(fontSize: 18, color: Colors.blue[700]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Card pour la monnaie virtuelle restante
            Card(
              color: Colors.yellow[100],
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Solde restant',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]),
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Text(
                      'Solde : 700,000 XOF',
                      style: TextStyle(fontSize: 18, color: Colors.orange[700]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
