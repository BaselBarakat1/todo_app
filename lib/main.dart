import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/ui/home/home_screen.dart';
import 'package:todo_app/ui/home/login/login_screen.dart';
import 'package:todo_app/ui/home/register/register_screen.dart';
import 'package:todo_app/ui/splash/splash_screen.dart';
import 'package:todo_app/ui/styles/my_theme_data.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApplication());
}

class MyApplication extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        loginScreen.routeName : (context) => loginScreen(),
        splashScreen.routeName : (context) => splashScreen(),
      HomeScreen.routeName : (context) => HomeScreen(),
        registerScreen.routeName : (context) => registerScreen(),

      },
      initialRoute: loginScreen.routeName,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: ThemeMode.light,
    );
  }

}