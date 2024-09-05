import 'package:flutter/material.dart';
import 'package:untitled/services/user_service.dart';

class KioskHistory extends StatefulWidget {
  @override
  _KioskHistoryState createState() => _KioskHistoryState();
}

class _KioskHistoryState extends State<KioskHistory> {
  late Future<List<Map<String, dynamic>>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = HistoriqueTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Historique des transactions',
          style: TextStyle(
            fontSize: 18,
            color: Colors.deepPurple,
            fontFamily: "Poppins",
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucune transaction trouvée.'));
          } else {
            final transactions = snapshot.data!;
            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final trans = transaction['transaction'] ?? {};
                final expediteur = transaction['expediteur'] ?? {};
                final destinataire = transaction['destinataire'] ?? {};

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(
                          trans['type'] == 'envoi' ? Icons.send : Icons.download,
                          color: trans['type'] == 'envoi' ? Colors.green : Colors.blue,
                        ),
                        title: Text(
                          '${trans['type']} - ${trans['montant']}',
                          style: const TextStyle(fontFamily: "Poppins"),
                        ),
                        subtitle: Text(
                          trans['type'] == 'retrait'
                              ? 'Expéditeur: ${expediteur['name'] ?? 'Non disponible'}'
                              : 'Expéditeur: ${expediteur['name'] ?? 'Non disponible'}\nReceveur: ${destinataire['name'] ?? 'Non disponible'}',
                          style: const TextStyle(fontFamily: "Poppins"),
                        ),
                        trailing: Text(
                          trans['date'] ?? 'Date non disponible',
                          style: const TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      if (trans['type'] == 'retrait')
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Code de retrait: ${trans['code_retrait'] ?? 'Non disponible'}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Statut: ${trans['statut'] ?? 'Statut non disponible'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
