import 'package:flutter/material.dart';
import 'package:untitled/models/api_response.dart';
import 'package:untitled/models/user.dart';
import 'package:untitled/services/user_service.dart'; // Importez votre fichier de service

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  late Future<ApiResponse> _futureUserDetails;
  bool loading = true; // Ajouté pour gérer l'état de chargement
  User? user; // Stocker l'utilisateur récupéré

  // Méthode pour charger les détails de l'utilisateur
  void _loadUserDetails() async {
    try {
      ApiResponse response = await getuserDetail();
      if (response.error == null) {
        setState(() {
          user = response.data as User;
          loading = false; // Changer l'état de chargement
        });
        print(
            'User Data: ${user?.name}, ${user?.email}, ${user?.compte?.numeroDeCompte}, ${user?.compte?.solde}');
      } else {
        print('Error: ${response.error}');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
      }
    } catch (e) {
      print('Exception: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Une erreur est survenue')));
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserDetails(); // Charger les détails de l'utilisateur au démarrage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil de Client',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.deepPurple),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : user != null
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Carte pour les informations de l'utilisateur
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Icon(Icons.person,
                                      color: Colors.deepPurple, size: 30),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Nom : ${user!.name ?? 'N/A'}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.email,
                                      color: Colors.deepPurple, size: 30),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Email : ${user!.email ?? 'N/A'}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Icon(Icons.badge,
                                      color: Colors.deepPurple, size: 30),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Rôle : ${user!.role ?? 'N/A'}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Carte pour les informations de compte (solde et numéro)
                      if (user!.compte != null) ...[
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Icon(Icons.account_balance,
                                        color: Colors.orange[700], size: 30),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'Numéro de compte : ${user!.compte?.numeroDeCompte ?? 'N/A'}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange[700],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.monetization_on,
                                        color: Colors.green[700], size: 30),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'Solde : ${user!.compte?.solde?.toStringAsFixed(2) ?? 'N/A'} XOF',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green[700],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                )
              : const Center(child: Text('Aucune donnée disponible')),
    );
  }
}
