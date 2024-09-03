import 'package:flutter/material.dart';
import 'package:untitled/main.dart';
import 'package:untitled/screens/registration.dart';
import 'Login.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Déclencher la navigation après un délai
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: 'SweetPay')),
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
            // Ajout d'une icône ou d'une image de présentation
            Icon(
              Icons.attach_money,
              size: 100,
              color: Colors.deepPurple,
            ),
            SizedBox(height: 32), // Espacement entre l'icône et le texte
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
