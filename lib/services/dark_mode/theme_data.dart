import 'dart:ui';
import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      //primarySwatch: Colors.white,
      primaryColor: isDarkTheme ? Colors.blue : Colors.lightGreen,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: isDarkTheme ? TextStyle(color: Colors.white) : TextStyle(color: Colors.black),
        fillColor: isDarkTheme ? Colors.grey[900] : Colors.amberAccent,
        labelStyle: isDarkTheme ? TextStyle(color: Colors.white) : TextStyle(color: Colors.black),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: isDarkTheme ? const BorderSide(color: Colors.blue, width: 3.0) : const BorderSide(color: Colors.red, width: 3.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: isDarkTheme ? const BorderSide(color: Colors.lightGreen, width: 3.0) : const BorderSide(color: Colors.lightBlue, width: 3.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: isDarkTheme ? const BorderSide(color: Colors.blue, width: 3.0) : const BorderSide(color: Colors.lightGreen, width: 3.0),
        ),
        prefixStyle: isDarkTheme ? TextStyle(color: Colors.white) : TextStyle(color: Colors.black),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: isDarkTheme ? Colors.lightGreen : Colors.amber,
        unselectedItemColor: Colors.white,
      ),
      dataTableTheme: DataTableThemeData(
        headingRowColor: isDarkTheme ? MaterialStateColor.resolveWith((states) => Color.fromRGBO(31, 31, 31, 1.0)) : MaterialStateColor.resolveWith((states) => Colors.amberAccent),
      ),
      splashColor: isDarkTheme ? MaterialStateColor.resolveWith((states) => Color.fromRGBO(45, 45, 45, 1.0)) : Colors.white,
      primaryColorDark: isDarkTheme ? Colors.blueGrey : Color(0xFFD6D6D6),
      secondaryHeaderColor: isDarkTheme ? Colors.blue : Colors.green,
      backgroundColor: isDarkTheme ? Color.fromRGBO(31, 31, 31, 1.0) : Colors.white, //Background
      indicatorColor: isDarkTheme ? Colors.blueAccent : Colors.amberAccent,
      buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
      hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xFF8C7622),
      errorColor: isDarkTheme ? Colors.white : Colors.black,
      highlightColor: isDarkTheme ? Color(0xff372901) : Colors.purple,
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Colors.purple,
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? Color.fromRGBO(31, 31, 31, 1.0) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
    );
  }
}
