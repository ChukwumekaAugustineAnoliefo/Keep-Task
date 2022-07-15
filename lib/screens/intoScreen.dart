import 'package:flutter/material.dart';
import 'package:keep_task/config/routes.dart';
import 'package:keep_task/config/themes.dart';
import 'package:keep_task/widgets/signup_login_btn.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keep_task/widgets/topright_clip_bg.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopRightCliper(),
          const SizedBox(
            height: 79,
          ),
          Image.asset('assets/images/intro.png'),
          const SizedBox(
            height: 85,
          ),
          Text(
            style: TodoThemes.textThemes.headline1,
            'Get things Done with TODO',
          ),
          const SizedBox(
            height: 43,
          ),
          SizedBox(
            width: 254,
            child: Text(
                textAlign: TextAlign.center,
                style: TodoThemes.textThemes.headline3,
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lacus netus elit risus tincidunt non ante.'),
          ),
          const SizedBox(height: 43),
          ReUsableBtn(
            btnText: 'Get Started',
            onPress: () {
              Navigator.of(context).pushNamed(RouteManager.singUpPageScreen);
            },
          )
        ],
      ),
    );
  }
}
