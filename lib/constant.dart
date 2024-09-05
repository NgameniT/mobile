//------Strings---------//

// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

const String localUrl = 'http://192.168.1.76:8000/';

const String baseURL = 'http://192.168.1.76:8000/api';
const String loginUrl = '$baseURL/login';
const String registerUrl = '$baseURL/register';
const String logoutUrl = '$baseURL/logout';
const String userUrl = '$baseURL/user';
// Routes for transactions
const String sendMoneyUrl = '$baseURL/transactions/envoyer';
const String initiateWithdrawalUrl = '$baseURL/transactions/initier-retrait';
const String validateWithdrawalUrl = '$baseURL/transactions/valider-retrait';
const String transactionHistoryUrl = '$baseURL/transactions/historique';
const String transactionHistoryValiderUrl =
    '$baseURL/transactions/historiquevalider';

//------Errors-----------//
const String serverError = 'Server error';
const String unauthorized = 'Unauthorized';
const String somethingWentWrong = 'Something went wrong, please try again!';
const String somethingWentWrongFr1 =
    'Une erreur s\'est produite, veuillez réessayer !';
const String somethingWentWrongFr2 =
    'Une erreur s\'est produite, veuillez réessayer !';
const String somethingWentWrongFr3 =
    'Une erreur s\'est produite, veuillez réessayer !';
