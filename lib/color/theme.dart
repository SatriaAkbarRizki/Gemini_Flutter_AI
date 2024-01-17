import 'package:flutter/material.dart';

class MyTheme {
  get ligthTheme => ThemeData(
        brightness: Brightness.light,
        textTheme: const TextTheme(
            titleSmall: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'Urbaninst',
                fontWeight: FontWeight.w600),
            titleMedium: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontFamily: 'Urbaninst',
                fontWeight: FontWeight.w700),
            titleLarge: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily: 'Urbaninst',
                fontWeight: FontWeight.w700)),
        scaffoldBackgroundColor: const Color(0xffFFFFFF),
        cardColor: Colors.white,
        primaryColor: const Color(0xff4B3425),
        cardTheme: const CardTheme(color: Color(0xffE8DDD9)),
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(CircleBorder()),
                backgroundColor: MaterialStatePropertyAll(Color(0xff4B3425)))),
      );

  get darkTheme => ThemeData(
        brightness: Brightness.dark,
        textTheme: const TextTheme(
            titleSmall: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'Urbaninst',
                fontWeight: FontWeight.w600),
            titleMedium: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily: 'Urbaninst',
                fontWeight: FontWeight.w700),
            titleLarge: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'Urbaninst',
                fontWeight: FontWeight.w700)),
        scaffoldBackgroundColor: const Color(0xff19191b),
        cardColor: Colors.black,
        primaryColor: const Color(0xff4f4b57),
        cardTheme: const CardTheme(color: Color(0xff2c2d32)),
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(CircleBorder()),
                backgroundColor: MaterialStatePropertyAll(Color(0xff1b32aa)))),
      );
}
