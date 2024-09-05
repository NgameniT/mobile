import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importer le package shared_preferences
import 'package:untitled/main.dart';
import 'package:untitled/models/api_response.dart';
import 'package:untitled/models/user.dart';
import 'package:untitled/services/user_service.dart';
import 'package:untitled/screens/home.dart'; // Assurez-vous que Home est le bon écran de destination
import 'package:untitled/screens/registration.dart'; // Assurez-vous que Registration est le bon écran

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtEmail = TextEditingController();
  final TextEditingController _txtPassword = TextEditingController();
  bool _loading = false;

  void _loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
    });

    ApiResponse response = await login(_txtEmail.text, _txtPassword.text);

    if (response.error == null) {
      _saveRedirectionToken(response.data as User);
    } else {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${response.error}')),
      );
    }
  }

  void _saveRedirectionToken(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', user.token ?? '');
    await prefs.setInt('userId', user.id ?? 0);
    if (user.role != null && user.role!.isNotEmpty) {
      await prefs.setString('userRole', user.role!);
    } else {
      await prefs.remove('userRole'); // Supprimer la clé si le rôle est vide
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
          (route) => false,
    );
  }


  void _navigateToRegistration() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.login,
                  size: 100,
                  color: Colors.deepPurple,
                ),
                SizedBox(height: 32),
                Text(
                  'Connectez-vous à votre compte',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _txtEmail,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _txtPassword,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un mot de passe';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),
                      _loading
                          ? CircularProgressIndicator() // Afficher un indicateur de chargement si nécessaire
                          : ElevatedButton(
                        onPressed: _loginUser,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurple,
                          padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 32.0),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                        child: Text('Se connecter'),
                      ),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: _navigateToRegistration,
                        child: Text(
                          "Pas encore de compte? Inscrivez-vous",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
