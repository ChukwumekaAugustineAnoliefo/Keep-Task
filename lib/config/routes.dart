import 'package:flutter/material.dart';
import 'package:keep_task/main.dart';
import 'package:keep_task/screens/login_page.dart';
import 'package:keep_task/screens/show_task_screen.dart';
import 'package:keep_task/screens/signup_page.dart';
import 'package:keep_task/widgets/edit_task.dart';

class RouteManager {
  static const String homePage = '/';
  static const String loginPage = '/loginPage';
  static const String singUpPageScreen = '/signUpPage';
  static const String listPage = '/TasklistPage';
  static const String editTask = '/editTask';
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
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => loginPagePage(),
        );
      case listPage:
        return MaterialPageRoute(
          builder: (context) => TaskListScreen(),
        );
      case editTask:
        return MaterialPageRoute(
          builder: (context) => EdiTask(),
        );
      default:
        throw const FormatException('Invalid Page Route');
    }
  }
}
