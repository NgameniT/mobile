// lib/services/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('token'); // Assurez-vous de supprimer le token pour la déconnexion
    return true;
  }
}
