import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keep_task/config/routes.dart';
import 'package:keep_task/config/themes.dart';
import 'package:keep_task/screens/show_task_screen.dart';
import 'package:keep_task/widgets/email_textfield.dart';
import 'package:keep_task/widgets/signup_login_btn.dart';
import 'package:keep_task/widgets/topright_clip_bg.dart';
import 'package:ndialog/ndialog.dart';

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
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
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
              secure: false,
              controller: fullnamecontroller,
              hintTexts: 'Enter your full name',
            ),
            SizedBox(
              height: 36,
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
              hintTexts: 'Enter your Password',
            ),
            SizedBox(
              height: 36,
            ),
            EmailTextField(
              secure: true,
              controller: confirmpasswordcontroller,
              hintTexts: 'Confirm Password',
            ),
            SizedBox(
              height: 56,
            ),
            ReUsableBtn(
              btnText: 'Register',
              onPress: () async {
                var fullName = fullnamecontroller.text.trim();
                var email = emailcontroller.text.trim();
                var password = passwordcontroller.text.trim();
                var confirmPass = confirmpasswordcontroller.text.trim();
                if (fullName.isEmpty ||
                    email.isEmpty ||
                    password.isEmpty ||
                    confirmPass.isEmpty) {
                  // show error toast

                  Fluttertoast.showToast(msg: 'Please fill all fields');
                  return;
                }
                if (password.length < 6) {
                  // show error toast
                  Fluttertoast.showToast(
                      msg: 'Weak Password, at least 6 characters are required');

                  return;
                }
                if (password != confirmPass) {
                  // show error toast
                  Fluttertoast.showToast(msg: 'Passwords do not match');

                  return;
                }
                ProgressDialog progressDialog = ProgressDialog(
                  context,
                  title: const Text('Signing Up'),
                  message: const Text('Please wait'),
                );
                progressDialog.show();
                try {
                  FirebaseAuth auth = FirebaseAuth.instance;

                  UserCredential userCredential =
                      await auth.createUserWithEmailAndPassword(
                          email: email, password: password);

                  if (userCredential.user != null) {
                    // store user information in Realtime database

                    DatabaseReference userRef =
                        FirebaseDatabase.instance.ref().child('users');

                    String uid = userCredential.user!.uid;
                    int dt = DateTime.now().millisecondsSinceEpoch;

                    await userRef.child(uid).set({
                      'fullName': fullName,
                      'email': email,
                      'uid': uid,
                      'dt': dt,
                      'profileImage': ''
                    });

                    Fluttertoast.showToast(msg: 'Success');
                    // Navigator.of(context)
                    //     .pushReplacementNamed(RouteManager.listPage);
                  } else {
                    Fluttertoast.showToast(msg: 'Failed');
                  }

                  progressDialog.dismiss();
                } on FirebaseAuthException catch (e) {
                  progressDialog.dismiss();
                  if (e.code == 'email-already-in-use') {
                    Fluttertoast.showToast(msg: 'Email is already in Use');
                  } else if (e.code == 'weak-password') {
                    Fluttertoast.showToast(msg: 'Password is weak');
                  }
                } catch (e) {
                  progressDialog.dismiss();
                  Fluttertoast.showToast(msg: 'Something went wrong');
                }
              },
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
                    child: Text(
                        style: TodoThemes.textThemes.headline4, 'Sign in')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
