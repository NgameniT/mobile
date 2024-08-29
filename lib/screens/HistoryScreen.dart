import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  static const List<Map<String, String>> transactions = [
    {
      'type': 'Envoi',
      'expediteur': 'Jean Dupont',
      'receveur': 'Marie Dupont',
      'montant': '5000 XOF',
      'date': '2024-08-25',
    },
    {
      'type': 'Retrait',
      'expediteur': 'Jean Dupont',
      'receveur': 'Marie Dupont',
      'montant': '3000 XOF',
      'date': '2024-08-26',
    },
    {
      'type': 'Envoi',
      'expediteur': 'Alice Durand',
      'receveur': 'Paul Martin',
      'montant': '7000 XOF',
      'date': '2024-08-27',
    },
  ];

  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Historique des transactions',
          style: TextStyle(
              fontSize: 18, color: Colors.deepPurple, fontFamily: "Poppins"),
        ),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            child: ListTile(
              leading: Icon(
                transaction['type'] == 'Envoi' ? Icons.send : Icons.download,
                color:
                    transaction['type'] == 'Envoi' ? Colors.green : Colors.blue,
              ),
              title: Text(
                '${transaction['type']} - ${transaction['montant']}',
                style: const TextStyle(fontFamily: "Poppins"),
              ),
              subtitle: Text(
                'Expéditeur: ${transaction['expediteur']}\nReceveur: ${transaction['receveur']}',
                style: const TextStyle(fontFamily: "Poppins"),
              ),
              trailing: Text(
                transaction['date']!,
                style: const TextStyle(fontFamily: "Poppins"),
              ),
            ),
          );
        },
      ),
    );
  }
}
