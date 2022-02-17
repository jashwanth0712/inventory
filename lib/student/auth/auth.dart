import 'package:flutter/material.dart';
import 'package:inventory/student/auth/views/auth_screen.dart';

class Auth extends StatelessWidget {
  static const route = '/auth';
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AuthScreen();
  }
}
