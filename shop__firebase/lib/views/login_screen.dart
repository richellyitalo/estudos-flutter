import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../exceptions/auth_exception.dart';

enum AuthMode { Login, Signup }

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthMode _authMode = AuthMode.Login;
  final _textPasswordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  Map<String, String> _formData = {
    'email': '',
    'password': '',
  };

  Future<void> _showErrorDialog(String text) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ocorreu um erro'),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  return Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<void> _formSubmit() async {
    bool formIsValid = _form.currentState.validate();

    if (!formIsValid) {
      return;
    }

    _form.currentState.save();

    Auth authProvider = Provider.of<Auth>(context, listen: false);

    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        await authProvider.signin(_formData['email'], _formData['password']);
      } else {
        await authProvider.signup(_formData['email'], _formData['password']);
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog(error.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _widthSize = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [const Color(0xff867ae9), const Color(0xfffff5ab)],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _headerWidget(deviceSize),
                    Form(
                      key: _form,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: _widthSize * 0.1),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3),
                                ),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'E-mail',
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) {
                                  if (val.trim().isEmpty) {
                                    return 'Informe um e-mail';
                                  }

                                  if (!val.contains('@')) {
                                    return 'Informe um e-mail válido';
                                  }

                                  return null;
                                },
                                onSaved: (val) {
                                  _formData['email'] = val.trim();
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Senha',
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                controller: _textPasswordController,
                                validator: (val) {
                                  if (val.trim().isEmpty) {
                                    return 'Informe a senha';
                                  }

                                  if (val.length < 6) {
                                    return 'Informe pelo menos 6 caracteres';
                                  }

                                  return null;
                                },
                                onSaved: (val) {
                                  _formData['password'] = val;
                                },
                              ),
                            ),
                            _authMode == AuthMode.Signup
                                ? Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3)),
                                          color: Colors.white,
                                        ),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            labelText: 'Repetir Senha',
                                          ),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: true,
                                          validator: (val) {
                                            if (val !=
                                                _textPasswordController.text) {
                                              return 'Repita a senha';
                                            }

                                            if (val.isEmpty) {
                                              return 'É necessário informar a senha';
                                            }

                                            return null;
                                          },
                                          onSaved: (val) {
                                            _formData['password'] = val;
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            SizedBox(height: 10),
                            _isLoading
                                ? CircularProgressIndicator()
                                : SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      // style: TextButton.styleFrom(primary: Colors.purple),
                                      child: Text(_authMode == AuthMode.Login
                                          ? 'Acessar'
                                          : 'Registrar'),
                                      onPressed: _formSubmit,
                                    ),
                                  ),
                            _footerWidget(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _headerWidget(Size deviceSize) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/images/store.png',
            height: deviceSize.height * 0.2,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              'MINHA \nLOJA',
              style: TextStyle(
                fontSize: 30,
                color: const Color(0xfffff5ab),
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _footerWidget() {
    bool isLogin = _authMode == AuthMode.Login;

    if (isLogin) {
      return TextButton(
        child: Text('Não possuo conta'),
        onPressed: () {
          setState(() {
            _authMode = AuthMode.Signup;
          });
        },
      );
    }

    return TextButton(
      child: Text('Já possuo conta'),
      onPressed: () {
        setState(() {
          _authMode = AuthMode.Login;
        });
      },
    );
  }
}
