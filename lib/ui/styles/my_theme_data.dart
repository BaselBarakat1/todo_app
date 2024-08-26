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
    primaryColor: lightPrimaryColor,
    secondaryHeaderColor: Colors.white,
    dividerColor: Colors.black,
    textTheme: TextTheme(
      bodySmall: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff363636)),
      titleLarge: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: lightPrimaryColor),
     titleMedium: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black),
      bodyMedium: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: lightPrimaryColor)
    ),
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
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        backgroundColor:lightPrimaryColor,
        textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15)
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.white
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: lightPrimaryColor,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: darkPrimaryColor,
    secondaryHeaderColor: Color(0xff141922),
    dividerColor: Colors.white,
    textTheme: TextTheme(
        bodySmall: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.white),
        titleLarge: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: darkPrimaryColor),
      titleMedium: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),
        bodyMedium: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: darkPrimaryColor)
    ),
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
          backgroundColor: darkPrimaryColor,
          textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15)
        ),
      ),
      bottomAppBarTheme: BottomAppBarTheme(
      color: darkBottomNavigationBarColor,
  ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Color(0xff141922),
      ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
        color: darkPrimaryColor
    ),
  );
}