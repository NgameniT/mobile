import 'package:flutter/material.dart';
import 'package:untitled/screens/ProfilScreen.dart';
import 'package:untitled/screens/kiosqueRetrait.dart';
import 'package:untitled/screens/kiosquehisto.dart'; // Remplacez par le chemin réel
import 'package:untitled/services/auth_service.dart'; // Assurez-vous que AuthService est importé ici
import 'package:untitled/screens/Login.dart'; // Assurez-vous que LoginScreen est importé ici

class KioskScreen extends StatefulWidget {
  const KioskScreen({Key? key}) : super(key: key);

  @override
  _KioskScreenState createState() => _KioskScreenState();
}

class _KioskScreenState extends State<KioskScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    KioskHistory(),
    KioskWithdrawal(),
    ProfilScreen(), // Assurez-vous de créer ces widgets
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout() async {
    bool success = await AuthService().logout();
    if (success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false, // Supprimer toutes les routes précédentes
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la déconnexion')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SWIFTPAY'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _logout,
            tooltip: 'Déconnexion',
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            label: 'Retrait',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
