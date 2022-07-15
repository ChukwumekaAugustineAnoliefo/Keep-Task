import 'package:flutter/material.dart';
import 'package:keep_task/config/themes.dart';

class LoginSignUpBtn extends StatelessWidget {
  LoginSignUpBtn({Key? key, required this.btnText, required this.onPress})
      : super(key: key);
  final String btnText;
  Function onPress;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 325,
      child: ElevatedButton(
        onPressed: () {
          onPress();
        },
        child: Text(style: TodoThemes.textThemes.headline2, btnText),
      ),
    );
  }
}
