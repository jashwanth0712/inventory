import 'package:flutter/material.dart';
import 'package:inventory/student/auth/auth.dart';
import 'package:inventory/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Inventory Home Screen"),
          backgroundColor: AppColors.primaryColor,
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: (() {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(
                    Auth.route,
                  ),
                );
              }),
              icon: const Icon(Icons.home),
            ),
          ),
        ));
  }
}
