import 'dart:js';

import 'package:flutter/material.dart';
import 'package:keep_task/main.dart';
import 'package:keep_task/screens/signup_page.dart';

class RouteManager {
  static const String homePage = '/';
  static const String loginPage = '/loginPage';
  static const String singUpPageScreen = '/signUpPage';
  static const String listPage = '/listPage';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (context) => const MyApp(),
        );
      case singUpPageScreen:
        return MaterialPageRoute(
          builder: (context) => singUpPage(),
        );
      default:
        throw const FormatException('Invalid Page Route');
    }
  }
}
