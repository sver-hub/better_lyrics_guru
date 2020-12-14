import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';

final appTheme = ThemeData(
  textTheme: textTheme,
  bottomNavigationBarTheme: bottomNavigationBarTheme,
);

final textTheme = TextTheme(
  // headline1: GoogleFonts.cabin(
  //   fontSize: 104,
  //   fontWeight: FontWeight.w300,
  //   letterSpacing: -1.5,
  // ),
  headline2: GoogleFonts.cabin(
    fontSize: 30,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  headline3: GoogleFonts.cabin(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  // headline4: GoogleFonts.cabin(
  //   fontSize: 37,
  //   fontWeight: FontWeight.w500,
  //   letterSpacing: 0.25,
  // ),
  headline5: GoogleFonts.cabin(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color(0xFF555555),
  ),
  // headline6: GoogleFonts.cabin(
  //   fontSize: 22,
  //   fontWeight: FontWeight.w500,
  //   letterSpacing: 0.15,
  // ),
  subtitle1: GoogleFonts.cabin(
    fontSize: 14,
    // fontWeight: FontWeight.w500,
    // letterSpacing: 0.15,
    color: Color(0xFF888888),
  ),
  subtitle2: GoogleFonts.cabin(
    fontSize: 15,
    // fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyText1: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    // letterSpacing: 0.5,
  ),
  bodyText2: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    // letterSpacing: 0.25,
  ),
  button: GoogleFonts.cabin(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    // letterSpacing: 1.25,
  ),
  caption: GoogleFonts.cabin(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    // letterSpacing: 0.4,
  ),
  overline: GoogleFonts.roboto(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);

final bottomNavigationBarTheme = BottomNavigationBarThemeData(
  selectedItemColor: Palette.blue,
  unselectedItemColor: Color(0xFFAAAAAA),
  showSelectedLabels: false,
  showUnselectedLabels: false,
  type: BottomNavigationBarType.fixed,
);
