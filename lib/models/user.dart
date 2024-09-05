import 'package:untitled/models/compte.dart';

class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? role;
  String? token;
  Compte? compte; // Ajout de l'objet Compte

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.role,
    this.token,
    this.compte, // Ajout ici
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      token: json['token'],
      // Initialiser l'objet Compte si disponible dans les données JSON
      compte: json['compte'] != null ? Compte.fromJson(json['compte']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'token': token,
      'compte': compte?.toJson(), // Ajout ici pour serialiser l'objet Compte
    };
  }
}
