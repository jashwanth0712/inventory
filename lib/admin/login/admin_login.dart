import 'package:flutter/material.dart';
import 'package:inventory/admin/login/view/login_screen.dart';

class AdminLogin extends StatelessWidget {
  static const route = '/login';
  const AdminLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
