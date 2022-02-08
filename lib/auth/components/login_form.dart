import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Text(
            "Welcome back!",
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (val) {},
            decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
              labelText: 'Mail ID',
              hintText: 'Enter your college mail ID',
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (val) {},
            decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
              labelText: 'Password',
              hintText: 'Enter your password',
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Text("Forgot Password?"),
        )
      ],
    );
  }
}
