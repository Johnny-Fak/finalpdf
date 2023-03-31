// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const primaryColor = Color.fromARGB(255, 161, 197, 203);
const SecondaryColor = Color(0xFFFE9901);
const ContentColorLightTheme = Color.fromARGB(255,17,17,17);
const backgroundNav = Color.fromARGB(1,17,17,17);
const unselectednavBar = Color.fromRGBO(196,196,196,1);
const ContentColorDarkTheme = Color(0xFFF5FCF9);
const WarningColor = Color(0xFFF3BB1C);
const ErrorColor = Color(0xFFF03738);
const buttonColor = Color.fromARGB(255,197, 207, 214);
const upperText = Color.fromARGB(255, 175, 185, 197);
const txtColor = Color.fromARGB(255, 255, 255, 255);
const domTxtColor = Color.fromARGB(255, 161, 197, 203);
const headerColor = Colors.black87;
const lineColor = Color.fromARGB(255, 215, 202, 202);
const subTxt = Color.fromARGB(255,133, 133, 133);

const DefaultPadding = 20.0;

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: ContentColorLightTheme,
    primaryColor: Color.fromARGB(255, 161, 197, 203),
    primaryColorDark: Colors.white,
    primaryColorLight: Colors.white,
    canvasColor: Colors.white,
    secondaryHeaderColor: primaryColor,

    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: backgroundNav,
      selectedItemColor: primaryColor,
      // unselectedLabelStyle: TextStyle(),
      unselectedIconTheme: IconThemeData(color: unselectednavBar),
      unselectedItemColor: Colors.white),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: ContentColorDarkTheme,
    primaryColor: primaryColor,
    primaryColorDark: primaryColor,
    indicatorColor: Colors.white,
    // canvasColor: Colors.black,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ContentColorDarkTheme,
      selectedIconTheme: IconThemeData(color: primaryColor),
      selectedItemColor: primaryColor,
      unselectedIconTheme: IconThemeData(color: ContentColorLightTheme),
      unselectedItemColor: ContentColorLightTheme.withOpacity(0.3),)
  );
}

// return MyThemes.darkTheme().copyWith(
//   BottomNavigationBarTheme 
// )

