import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/ui/home/home_screen.dart';

class splashScreen extends StatefulWidget {
  static const String routeName = 'splash_screen';

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDFECDB),
      body: Container(
        alignment: Alignment.center,
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
