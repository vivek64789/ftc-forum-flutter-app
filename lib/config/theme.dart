import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(244, 244, 244, 244),
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: textTheme(),
    colorScheme: colorScheme(),
  );
}

ColorScheme colorScheme() {
  return const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromRGBO(255, 0, 154, 1),
      onPrimary: Colors.white,
      secondary: Colors.grey,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black);
}

TextTheme textTheme() {
  return const TextTheme(
    headline1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 36,
      // fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    headline2: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 22,
      // fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    headline3: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
      // fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    headline4: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16,
      // fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    headline5: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
      // fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    headline6: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 14,
      // fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    bodyText1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      height: 1.75,
      fontSize: 12,
      // fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    bodyText2: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 10,
      // fontFamily: GoogleFonts.poppins().fontFamily,
    ),
  );
}
