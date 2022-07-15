import 'package:flutter/material.dart';
import 'package:keep_task/config/routes.dart';
import 'package:keep_task/config/themes.dart';
import 'package:keep_task/widgets/email_textfield.dart';
import 'package:keep_task/widgets/signup_login_btn.dart';
import 'package:keep_task/widgets/topright_clip_bg.dart';

class singUpPage extends StatefulWidget {
  singUpPage({Key? key}) : super(key: key);

  @override
  State<singUpPage> createState() => _singUpPageState();
}

class _singUpPageState extends State<singUpPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController fullnamecontroller = TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopRightCliper(),
          SizedBox(
            height: 52,
          ),
          Text(
            style: TodoThemes.textThemes.headline1,
            'Welcome Onboard!',
          ),
          Text(
              textAlign: TextAlign.center,
              style: TodoThemes.textThemes.headline3,
              'Let’s help you meet your tasks.'),
          SizedBox(
            height: 43,
          ),
          EmailTextField(
            controller: fullnamecontroller,
            hintTexts: 'Enter your full name',
          ),
          SizedBox(
            height: 36,
          ),
          EmailTextField(
            controller: emailcontroller,
            hintTexts: 'Enter your Password',
          ),
          SizedBox(
            height: 36,
          ),
          EmailTextField(
            controller: passwordcontroller,
            hintTexts: 'Enter your Password',
          ),
          SizedBox(
            height: 36,
          ),
          EmailTextField(
            controller: confirmpasswordcontroller,
            hintTexts: 'Confirm Password',
          ),
          SizedBox(
            height: 56,
          ),
          ReUsableBtn(
            btnText: 'Register',
            onPress: () {},
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account?'),
              SizedBox(
                width: 5,
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteManager.loginPage);
                  },
                  child:
                      Text(style: TodoThemes.textThemes.headline4, 'Sign in')),
            ],
          )
        ],
      ),
    );
  }
}
