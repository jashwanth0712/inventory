import 'package:flutter/material.dart';
import 'package:inventory/auth/auth.dart';
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
    case Home.route:
    default:
      return SlidePageRoute(
        child: const Home(),
        duration: const Duration(milliseconds: 300),
        settings: settings,
      );
  }
}
