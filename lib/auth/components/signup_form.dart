import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

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
            "Welcome!",
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
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (val) {},
            decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
              labelText: 'Roll Number',
              hintText: 'Enter your roll number',
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (val) {},
            decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
              labelText: 'Password',
              hintText: 'Enter a password',
            ),
          ),
        ),
      ],
    );
  }
}
