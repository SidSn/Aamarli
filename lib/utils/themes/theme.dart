// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:test_app/utils/const/colors.dart';

final ThemeData darkTheme = ThemeData(
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(
      seedColor: textColorSecondary,
      brightness: Brightness.dark,
    ),
    primaryColorDark: bgColor,
    primaryColorLight: Colors.white,
    textTheme: TextTheme(
        headlineSmall: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        labelSmall: const TextStyle(fontSize: 20),
        bodyMedium: TextStyle(
          color: Colors.white.withOpacity(0.7),
        ),
        headlineMedium: const TextStyle(
            fontSize: 28,
            color: Color(0xff26debe),
            fontWeight: FontWeight.bold),
        titleLarge: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        titleMedium: const TextStyle(
          fontWeight: FontWeight.bold,
        )));

final ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: Colors.white,
    primaryColorDark: bgColor,
    focusColor: Colors.grey,
    primaryColorLight: Colors.black,
    colorScheme: ColorScheme.fromSeed(
      seedColor: textColorThird,
      brightness: Brightness.light,
    ),
    appBarTheme:
        const AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),
    textTheme: TextTheme(
        titleMedium: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        bodySmall: const TextStyle(color: Colors.black),
        bodyMedium: TextStyle(
          color: Colors.black.withOpacity(0.7),
        ),
        headlineMedium: const TextStyle(
            fontSize: 28,
            color: Color(0xffff807f),
            fontWeight: FontWeight.bold),
        labelSmall: const TextStyle(fontSize: 20),
        headlineSmall:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        titleLarge:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)));
