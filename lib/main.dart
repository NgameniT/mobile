// lib/main.dart
import 'package:flutter/material.dart';
import 'package:untitled/screens/HistoryScreen.dart';
import 'package:untitled/screens/Login.dart';
import 'package:untitled/screens/ReceiveScreen.dart';
import 'package:untitled/screens/SendScreen.dart';
import 'package:untitled/screens/clientprofil.dart';
import 'package:untitled/screens/loading.dart';
import 'package:untitled/services/auth_service.dart'; // Importez le service d'authentification

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Loading(), // Changer la page d'accueil pour LoadingScreen
        debugShowCheckedModeBanner: false
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    SendScreen(),
    ReceiveScreen(),
    HistoryScreen(),
    ProfilScreen(),
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
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _logout,
            tooltip: 'Déconnexion',
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.send_to_mobile, color: Colors.grey,),
            label: 'Envoi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.install_mobile_outlined, color: Colors.grey,),
            label: 'Retrait',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, color: Colors.grey,),
            label: 'Historique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.grey,),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
