import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keep_task/config/themes.dart';
import 'package:keep_task/screens/intoScreen.dart';
import 'package:keep_task/config/routes.dart';
import 'package:keep_task/screens/show_task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: FirebaseAuth.instance.currentUser == null
          ? IntroScreen()
          : TaskListScreen(),
    );
  }
}
