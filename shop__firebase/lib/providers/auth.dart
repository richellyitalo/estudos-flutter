import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  Future<void> signup(String email, String password) async {
    final _urlSignup =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCwurBrzLDFWVr4DgB0JoGe86XYxfbLGK4';
    final response = await http.post(
      Uri.parse(_urlSignup),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final responseBody = jsonDecode(response.body);
    if (responseBody['error'] != null) {
      throw AuthException(responseBody['error']['message']);
    }

    if (response.statusCode >= 400) {
      throw Exception('Ocorreu um erro inesperado.');
    }

    print(jsonDecode(response.body));

    return Future.value();
  }

  Future<void> signin(String email, String password) async {
    final _urlSignup =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCwurBrzLDFWVr4DgB0JoGe86XYxfbLGK4';

    final response = await http.post(
      Uri.parse(_urlSignup),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final responseBody = jsonDecode(response.body);
    if (responseBody['error'] != null) {
      throw AuthException(responseBody['error']['message']);
    }

    if (response.statusCode >= 400) {
      throw Exception('Ocorreu um erro inesperado.');
    }

    print(jsonDecode(response.body));

    return Future.value();
  }
}
