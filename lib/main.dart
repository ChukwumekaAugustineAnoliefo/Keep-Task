import 'package:flutter/material.dart';
import 'package:keep_task/config/themes.dart';
import 'package:keep_task/screens/intoScreen.dart';
import 'package:keep_task/config/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouteManager.homePage,
      onGenerateRoute: RouteManager.generateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Keep Task',
      theme: TodoThemes.themes,
      home: IntroScreen(),
    );
  }
}
