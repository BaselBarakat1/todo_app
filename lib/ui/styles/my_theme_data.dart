import 'package:flutter/material.dart';

const Color lightPrimaryColor = Color(0xff5D9CEC);
const Color darkPrimaryColor = Color(0xff5D9CEC);
const Color lightScaffoldBackgroundColor = Color(0xffDFECDB);
const Color darkScaffoldBackgroundColor = Color(0xff060E1E);
const Color greenColor = Color(0xff61E757);
const Color redColor = Color(0xffEC4B4B);
const Color greyColor = Color(0xffC8C9CB);
const Color darkAppbarTitleColor = Color(0xff060E1E);
const darkBottomNavigationBarColor = Color(0xff141922);



class MyThemeData{
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: lightPrimaryColor,
      toolbarHeight: 185,
      titleTextStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),

    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      selectedItemColor: lightPrimaryColor,
      unselectedItemColor: greyColor,
        selectedIconTheme: IconThemeData(
            size: 37,
        ),
        selectedLabelStyle: TextStyle()
    ),
    scaffoldBackgroundColor: lightScaffoldBackgroundColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(360)
        ),
              backgroundColor: lightPrimaryColor,
        iconSize: 35,
      ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.white
    )
  );
  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: darkPrimaryColor,
      toolbarHeight: 185,
      titleTextStyle: TextStyle(color: darkAppbarTitleColor ,fontWeight: FontWeight.bold,fontSize: 22),

    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor:Colors.transparent,
      selectedItemColor: darkPrimaryColor,
      unselectedItemColor: greyColor,
    ),
    scaffoldBackgroundColor: darkScaffoldBackgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(360),
      ),
      backgroundColor: darkPrimaryColor,
        iconSize: 35,
    ),
      bottomAppBarTheme: BottomAppBarTheme(
      color: darkBottomNavigationBarColor,
  )
  );
}