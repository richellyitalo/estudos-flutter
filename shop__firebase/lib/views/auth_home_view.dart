import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import 'login_screen.dart';
import 'products_overview_screen.dart';

class AuthHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<Auth>(context).isAuth
        ? ProductOverviewScreen()
        : LoginScreen();
  }
}
