import 'package:flutter/material.dart';
import 'package:keep_task/config/routes.dart';
import 'package:keep_task/config/themes.dart';
import 'package:keep_task/widgets/email_textfield.dart';
import 'package:keep_task/widgets/signup_login_btn.dart';
import 'package:keep_task/widgets/topright_clip_bg.dart';

class loginPagePage extends StatefulWidget {
  loginPagePage({Key? key}) : super(key: key);

  @override
  State<loginPagePage> createState() => _loginPagePageState();
}

class _loginPagePageState extends State<loginPagePage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopRightCliper(),
          Text(
            style: TodoThemes.textThemes.headline1,
            'Welcome Back!',
          ),
          Text(
              textAlign: TextAlign.center,
              style: TodoThemes.textThemes.headline3,
              'Let’s get you signed in.'),
          SizedBox(
            height: 38,
          ),
          Image.asset('assets/images/intro.png'),
          SizedBox(
            height: 30,
          ),
          EmailTextField(
            controller: emailcontroller,
            hintTexts: 'Enter your password',
          ),
          SizedBox(
            height: 36,
          ),
          EmailTextField(
            controller: passwordcontroller,
            hintTexts: 'Confirm Password',
          ),
          SizedBox(
            height: 26,
          ),
          Text(
              textAlign: TextAlign.center,
              style: TodoThemes.textThemes.headline4,
              'Forgot Password'),
          SizedBox(
            height: 25,
          ),
          ReUsableBtn(
            btnText: 'Login',
            onPress: () {},
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dont have an account?'),
              SizedBox(
                width: 5,
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(RouteManager.singUpPageScreen);
                  },
                  child:
                      Text(style: TodoThemes.textThemes.headline4, 'Sign up')),
            ],
          )
        ],
      ),
    );
  }
}
