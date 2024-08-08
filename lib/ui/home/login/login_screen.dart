import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_error_codes/firebase_error_codes.dart';
import 'package:todo_app/ui/home/home_screen.dart';
import 'package:todo_app/ui/widgets/custom_text_form-field.dart';
import 'package:todo_app/utils/dialog_utils.dart';
import 'package:todo_app/utils/email_format.dart';
import 'package:todo_app/utils/password_format.dart';

class loginScreen extends StatefulWidget {
static const String routeName = 'login_screen';

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
TextEditingController emailController = TextEditingController();

TextEditingController passwordController = TextEditingController();

var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image:
            AssetImage('assets/images/background.png'),
          fit: BoxFit.fill
        ),
        color: Colors.white
      ),
      child: Scaffold(
       backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 100,
          title: Text('Log In'),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customTextFormField(labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  controller: emailController,
                  validator: (input) {
                    if(input == null || input.isEmpty){
                      return ' Please Enter Email';
                    }
                    if( !isEmailFormatter(input)){
                      return 'Please Enter a Valid Email Address';
                    }
                    return null;
                  },
                ),
                customTextFormField(labelText: 'Password',
                prefixIcon: Icon(Icons.password),
                controller: passwordController,
                validator: (input) {
                  if(input == null || input.isEmpty){
                    return ' Please Enter Password';
                  }
                  if(input.length < 6){
                    return 'Pasword must be at least 6 characters';
                  }
                  return null;
                },
                ),
                ElevatedButton(onPressed: () {
                  login();
                },
                  child: Text('Log in',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                    backgroundColor: Color(0xff5D9CEC),
                  ),

                )
              ],
            ),
          ),
        ),
      ),
    );
  }

void login() async {
  if (formKey.currentState?.validate() == false) {
    return;
  }
  try {
    DialogUtils.showLoadingDialog(context, 'Loading...');
    var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
    );
    DialogUtils.hideDialog(context);
    DialogUtils.showMessage(context, 'Logged In Successfully',
      icon: Icon(Icons.check_circle, color: Colors.green,),
      postiveActionTitle: 'OK',
      posAction: () {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      },);
  } on FirebaseAuthException catch (e) {
    DialogUtils.hideDialog(context);
    if (e.code == FirebaseErrorCodes.userNotFound || e.code == FirebaseErrorCodes.wrongPassword) {
      DialogUtils.showMessage(context, 'Wrong Email or Password',postiveActionTitle: 'Ok');
    }
  }
}
}
