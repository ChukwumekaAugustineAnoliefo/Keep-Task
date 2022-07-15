import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/color_constants.dart';
import '../constants/styles_constants.dart';

class TodoThemes {
  static ThemeData themes = ThemeData(
    primaryColor: primaryColors,
    hintColor: hintTextColor,
    scaffoldBackgroundColor: scaffoldColor,
    splashColor: splashColors,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
    fontFamily: 'Georgia',
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.yellow),
  );
  static TextTheme textThemes = TextTheme(
      headline1: introHeader,
      headline2: loginBtnChildText,
      headline3: subHeaderText);
  static AppBarTheme appBarthem = AppBarTheme();
}
// Container(
// color: Theme.of(context).accentColor,
// child: Text(
// 	'Hello Geeks!',
// 	style: Theme.of(context).textTheme.headline6,
// ),
// );

