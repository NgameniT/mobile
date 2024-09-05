import 'package:flutter/material.dart';
import 'package:untitled/main.dart'; // Assurez-vous que MyHomePage est défini ici
import 'package:untitled/screens/kioskScreen.dart'; // Assurez-vous que KioskScreen est défini ici
import 'package:untitled/services/user_service.dart'; // Assurez-vous que getUserRole est défini ici
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Déclencher la navigation après un délai
    Future.delayed(Duration(seconds: 3), () async {
      String userRole = await getUserRole();
      Widget nextPage;

      if (userRole == 'kiosque') {
        print("Redirection vers KioskScreen");
        nextPage = KioskScreen(); // Assurez-vous que ce fichier existe
      } else {
        print("Redirection vers MyHomePage");
        nextPage = MyHomePage(title: 'SWIFTPAY');
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextPage),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.attach_money,
              size: 100,
              color: Colors.deepPurple,
            ),
            SizedBox(height: 32),
            Text(
              'Bienvenue sur SWIFTPAY',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Nous vous permettons de transférer de l\'argent rapidement et en toute sécurité. Profitez d\'une expérience fluide et intuitive pour gérer vos transactions financières.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
