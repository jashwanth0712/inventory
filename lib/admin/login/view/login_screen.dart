import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:inventory/admin/login/components/login_form.dart';
import 'package:inventory/constants.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: Blob.random(
              size: 300,
              styles: BlobStyles(
                color: AppColors.primaryColor.withOpacity(0.7),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Blob.random(
              size: 300,
              styles: BlobStyles(
                color: AppColors.primaryColor.withOpacity(0.7),
              ),
            ),
          ),
          Column(
            children: [
              Flexible(
                child: Lottie.network(
                  'https://assets3.lottiefiles.com/packages/lf20_1pxqjqps.json',
                ),
              ),
              SizedBox(
                height: 400,
                child: LoginForm(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
