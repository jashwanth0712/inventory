import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:inventory/admin/login/components/login_form.dart';
import 'package:inventory/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:inventory/login_signup.dart';

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
              Padding(
                padding: const EdgeInsets.only(top: 58.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const toggler()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("option"),
                    ),
                  ),
                ),
              ),
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
