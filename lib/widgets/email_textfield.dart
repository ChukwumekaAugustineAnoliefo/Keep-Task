import 'package:flutter/material.dart';
import 'package:keep_task/config/themes.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required this.secure,
    required this.controller,
    required this.hintTexts,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintTexts;
  final bool secure;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 325,
      height: 50,
      child: TextField(
        obscureText: secure,
        style: TodoThemes.textThemes.headline5,
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
            borderSide: BorderSide(width: 0, color: const Color(0xFF21242D)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
            borderSide: BorderSide(width: 0, color: Colors.white),
          ),
          hintText: hintTexts,
          hintStyle: TextStyle(
            color: const Color(0XFF494D58),
          ),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}


// Widget buildPassWord() => TextField(
//       style: TextStyle(color: Colors.white),
//       onChanged: (value) => setState(() => this.password = value),
//       onSubmitted: (value) => setState(() => this.password = value),
//       decoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(12.0)),
//           borderSide: BorderSide(width: 1, color: const Color(0xFF21242D)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(12.0)),
//           borderSide: BorderSide(width: 2, color: Colors.white),
//         ),
//         border: OutlineInputBorder(),
//         hintText: 'Your password...',
//         // labelText: 'Password',
//         suffixIcon: IconButton(
//           icon: isPasswordVisible
//               ? Icon(Icons.visibility_off)
//               : Icon(Icons.visibility),
//           onPressed: () =>
//               setState(() => isPasswordVisible = !isPasswordVisible),
//         ),
//       ),
//       obscureText: isPasswordVisible,
//     );
