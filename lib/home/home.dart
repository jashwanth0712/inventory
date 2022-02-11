import 'package:flutter/material.dart';
import 'package:inventory/home/views/home_screen.dart';

class Home extends StatelessWidget {
  static const route = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
