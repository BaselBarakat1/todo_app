import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/database/model/user.dart' as MyUser;

import '../database/user_dao.dart';

class MyAuthProvider extends ChangeNotifier{
  MyUser.User? databaseUser;
  User? firebaseAuthUser;

register(String email,String password, String fullName, String userName) async {
  var credintial = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password);
  await UserDao.addUser(MyUser.User(
    id: credintial.user?.uid,
    fullName: fullName,
    userName: userName ,
    email: email,
  ));
}

login(String email, String password) async {
  var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
  );
 var user = await UserDao.getUser(credential.user!.uid);
  databaseUser = user;
  firebaseAuthUser = credential.user;
}
}