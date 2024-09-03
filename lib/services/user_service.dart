import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:untitled/constant.dart';
import 'package:untitled/models/api_response.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

// Login function
Future<ApiResponse> login(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'password': password},
    );
    switch (response.statusCode) {
      case 200:
        final userData = jsonDecode(response.body);
        final user = User.fromJson(userData);

        // Save user ID in SharedPreferences if it exists
        if (user.id != null) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setInt('userId', user.id!);
        }

        apiResponse.data = user;
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// Register function
Future<ApiResponse> register(String name, String email, String password,
    String passwordConfirmation) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(
      Uri.parse(registerUrl),
      headers: {'Accept': 'application/json'},
      body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation':
            passwordConfirmation, // Ensure password confirmation is included
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// Get User Details function
Future<ApiResponse> getuserDetail() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(userUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

Future<int> getUserId() async {
  print("Tentative de récupération de l'ID...");
  SharedPreferences pref = await SharedPreferences.getInstance();
  int? userId = pref.getInt('userId');
  if (userId != null) {
    print("ID récupéré avec succès : $userId");
    return userId;
  } else {
    print("Aucun ID trouvé, renvoi de la valeur par défaut : 0");
    return 0;
  }
}

//logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setInt('userId', 1);
  return await pref.remove('token');
}

Future<ApiResponse> envoyerTransfert({
  required String montant,
  required String numeroDeCompteDestinataire,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(
      Uri.parse(sendMoneyUrl), // Remplacez par l'URL de votre API
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${await getToken()}', // Ajoutez le token si nécessaire
      },
      body: jsonEncode({
        'montant': montant,
        'numeroDeCompteDestinataire': numeroDeCompteDestinataire,
      }),
    );

    // Log pour déboguer
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(
            response.body); // Adaptez en fonction du modèle de réponse attendu
        break;
      case 400:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error =
            jsonDecode(response.body)['message'] ?? 'Non autorisé';
        break;
      case 403:
        apiResponse.error =
            jsonDecode(response.body)['message'] ?? 'Accès interdit';
        break;
      case 404:
        apiResponse.error = 'Ressource non trouvée';
        break;
      case 500:
        apiResponse.error = 'Erreur interne du serveur: ${response.body}';
        break;
      default:
        apiResponse.error =
            'Une erreur inconnue est survenue: ${response.body}';
        break;
    }
  } catch (e) {
    apiResponse.error = 'Erreur de connexion: ${e.toString()}';
  }
  return apiResponse;
}

Future<ApiResponse> initierRetrait({
  required String montant,
}) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(
      Uri.parse(initiateWithdrawalUrl), // Remplacez par l'URL de votre API
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${await getToken()}', // Assurez-vous que getToken() est bien implémenté
      },
      body: jsonEncode({
        'montant': montant,
      }),
    );

    // Log pour déboguer
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      // Décoder la réponse JSON en tant que Map<String, dynamic>
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      apiResponse.data = responseData;
    } else {
      final Map<String, dynamic> errorData = jsonDecode(response.body);
      switch (response.statusCode) {
        case 400:
          apiResponse.error = errorData['errors']?.values?.first?.first;
          break;
        case 401:
          apiResponse.error = errorData['message'] ?? 'Non autorisé';
          break;
        case 403:
          apiResponse.error = errorData['message'] ?? 'Accès interdit';
          break;
        case 404:
          apiResponse.error = 'Ressource non trouvée';
          break;
        case 500:
          apiResponse.error = 'Erreur interne du serveur: ${response.body}';
          break;
        default:
          apiResponse.error =
              'Une erreur inconnue est survenue: ${response.body}';
          break;
      }
    }
  } catch (e) {
    apiResponse.error = 'Erreur de connexion: ${e.toString()}';
  }
  return apiResponse;
}

Future<List<Map<String, dynamic>>> fetchTransactions() async {
  final token = await getToken();
  final response = await http.get(
    Uri.parse(
        transactionHistoryUrl), // Remplacez par l'URL de votre API Laravel
    headers: {
      'Authorization': 'Bearer $token', // Ajoutez le token si nécessaire
    },
  );

  if (response.statusCode == 200) {
    try {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey('transactions')) {
        final List<dynamic> transactions = data['transactions'];
        return transactions.map((item) {
          if (item is Map<String, dynamic>) {
            return item;
          } else {
            throw Exception('Format des données de transaction invalide');
          }
        }).toList();
      } else {
        throw Exception('Clé "transactions" manquante dans la réponse');
      }
    } catch (e) {
      throw Exception('Erreur lors du traitement des données JSON: $e');
    }
  } else {
    throw Exception(
        'Erreur lors de la récupération des transactions. Code de statut: ${response.statusCode}');
  }
}
