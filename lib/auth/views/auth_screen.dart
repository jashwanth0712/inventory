import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:inventory/auth/components/login_form.dart';
import 'package:inventory/auth/components/signup_form.dart';
import 'package:inventory/constants.dart';
import 'package:lottie/lottie.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: TabBar(
                      labelColor: Colors.black,
                      indicatorColor: AppColors.primaryColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          text: 'Login',
                        ),
                        Tab(
                          text: 'Signup',
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: TabBarView(
                    children: [
                      LoginForm(),
                      SignupForm(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
