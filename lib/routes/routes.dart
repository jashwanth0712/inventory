import 'package:flutter/material.dart';
import 'package:inventory/admin/login/admin_login.dart';
import 'package:inventory/admin/notice/notice.dart';
import 'package:inventory/login_signup.dart';
import 'package:inventory/student/auth/auth.dart';
import 'package:inventory/animations/slide_page.dart';
import 'package:inventory/home/home.dart';

Route generateAppRoute(RouteSettings settings) {
  switch (settings.name) {
    case Auth.route:
      return SlidePageRoute(
        child: const Auth(),
        duration: const Duration(milliseconds: 300),
        settings: settings,
      );
    case AdminLogin.route:
      return SlidePageRoute(
        child: const Toggler(),
        duration: const Duration(milliseconds: 300),
        settings: settings,
      );
    case Notice.route:
      return SlidePageRoute(
        child: const Notice(),
        duration: const Duration(milliseconds: 300),
        settings: settings,
      );
    case Home.route:
    default:
      return SlidePageRoute(
        child: const Home(),
        duration: const Duration(milliseconds: 300),
        settings: settings,
      );
  }
}
