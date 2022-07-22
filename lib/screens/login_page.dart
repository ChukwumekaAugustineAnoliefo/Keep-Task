import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keep_task/config/routes.dart';
import 'package:keep_task/config/themes.dart';
import 'package:keep_task/widgets/email_textfield.dart';
import 'package:keep_task/widgets/signup_login_btn.dart';
import 'package:keep_task/widgets/topright_clip_bg.dart';
import 'package:ndialog/ndialog.dart';

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
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
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
              secure: false,
              controller: emailcontroller,
              hintTexts: 'Enter your Email',
            ),
            SizedBox(
              height: 36,
            ),
            EmailTextField(
              secure: true,
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
              onPress: () async {
                var email = emailcontroller.text.trim();
                var password = passwordcontroller.text.trim();
                if (email.isEmpty || password.isEmpty) {
                  // show error toast
                  Fluttertoast.showToast(msg: 'Please fill all fields');
                  return;
                }
                ProgressDialog progressDialog = ProgressDialog(
                  context,
                  title: const Text('Logging In'),
                  message: const Text('Please wait'),
                );

                progressDialog.show();
                try {
                  FirebaseAuth auth = FirebaseAuth.instance;

                  UserCredential userCredential =
                      await auth.signInWithEmailAndPassword(
                          email: email, password: password);

                  if (userCredential.user != null) {
                    progressDialog.dismiss();
                    Navigator.of(context)
                        .pushReplacementNamed(RouteManager.listPage);
                  }
                } on FirebaseAuthException catch (e) {
                  progressDialog.dismiss();

                  if (e.code == 'user-not-found') {
                    Fluttertoast.showToast(msg: 'User not found');
                  } else if (e.code == 'wrong-password') {
                    Fluttertoast.showToast(msg: 'Wrong password');
                  }
                } catch (e) {
                  Fluttertoast.showToast(msg: 'Something went wrong');
                  progressDialog.dismiss();
                }
                // Navigator.of(context).pushNamed(RouteManager.listPage);
              },
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
                    child: Text(
                        style: TodoThemes.textThemes.headline4, 'Sign up')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
