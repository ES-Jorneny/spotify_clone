import 'package:flutter/material.dart';
import 'package:spotify_clone/core/utils/theme/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    fontFamily: "Satoshi",
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      hintStyle: TextStyle(
          color: Color(0xff383838),
          fontWeight: FontWeight.w500
      ),
      contentPadding: const EdgeInsets.all(30),
      border:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: Colors.black
        )

      ),
     focusedBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(30),
         borderSide: BorderSide(
             color: Colors.black,
             width: 0.4
         )

     ),
    ),

    scaffoldBackgroundColor: AppColors.lightBackground,
    elevatedButtonTheme: ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(

        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    fontFamily: "Satoshi",
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
     hintStyle: TextStyle(
       color: Color(0xffa7a7a7),
       fontWeight: FontWeight.w500
     ),
      contentPadding: const EdgeInsets.all(30),
      border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              color: Colors.white,
            width: 0.4
          )

      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              color: Colors.white,
              width: 0.4
          )

      ),

    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(

        foregroundColor: Colors.white,
        backgroundColor: AppColors.primary,
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
  );
}
