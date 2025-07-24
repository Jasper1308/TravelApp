import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue[700],
    hintColor: Colors.blueAccent[400],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue[700],
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.blueGrey[50],
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(color: Colors.blueGrey[900]),
      bodyMedium: TextStyle(color: Colors.blueGrey[700]),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue[700],
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blueAccent[400],
      foregroundColor: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue[800],
    hintColor: Colors.blueAccent[100],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue[900],
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.blueGrey[900],
    cardTheme: CardThemeData(
      color: Colors.blueGrey[800],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.blueGrey[100]),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue[800],
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blueAccent[100],
      foregroundColor: Colors.blueGrey[900],
    ),
  );
}