import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop/data/store.dart';

import '../exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  String _userId;
  String _token;
  DateTime _expireDate;
  Timer _timerLogout;

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_token != null &&
        _expireDate != null &&
        _expireDate.isAfter(DateTime.now())) {
      return _token;
    }

    return null;
  }

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

    _saveAuthData(
      responseBody['idToken'],
      responseBody['localId'],
      responseBody['expiresIn'],
    );

    notifyListeners();

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

    _saveAuthData(
      responseBody['idToken'],
      responseBody['localId'],
      int.parse(responseBody['expiresIn']),
    );

    notifyListeners();

    return Future.value();
  }

  void logout() async {
    _userId = null;
    _token = null;
    _expireDate = null;

    if (_timerLogout != null) {
      _timerLogout.cancel();
    }

    await Store.remove('auth');

    notifyListeners();
  }

  void _saveAuthData(String token, String userId, int seconds) {
    _token = token;
    _expireDate = DateTime.now().add(Duration(seconds: seconds));
    _userId = userId;

    Store.saveMap('auth', {
      'token': token,
      'userId': userId,
      'expireDate': _expireDate.toIso8601String(),
    });

    _setAutoLogout();
  }

  void _setAutoLogout() {
    if (_timerLogout != null) {
      _timerLogout.cancel();
    }

    int secondsToLogout = _expireDate.difference(DateTime.now()).inSeconds;
    _timerLogout = Timer(Duration(seconds: secondsToLogout), logout);
  }

  Future<void> autoLogin() async {
    if (isAuth) {
      return Future.value();
    }

    final authData = await Store.getMap('auth');
    if (authData == null) {
      return Future.value();
    }

    DateTime expireDate = DateTime.parse(authData['expireDate']);
    if (expireDate.isBefore(DateTime.now())) {
      return Future.value();
    }

    int secondsToExpire = expireDate.difference(DateTime.now()).inSeconds;
    _saveAuthData(authData['token'], authData['userId'], secondsToExpire);

    notifyListeners();

    return Future.value();
  }
}
