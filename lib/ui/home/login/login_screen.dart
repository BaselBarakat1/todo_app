import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth_provider/auth_provider.dart';
import 'package:todo_app/database/user_dao.dart';
import 'package:todo_app/firebase_error_codes/firebase_error_codes.dart';
import 'package:todo_app/ui/home/home_screen.dart';
import 'package:todo_app/ui/home/register/register_screen.dart';
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

bool obsecureText = true;

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
                suffixIcon: IconButton(onPressed: () {
                  if(obsecureText == true){
                    obsecureText = false;
                  }else{
                    obsecureText =true;
                  }
                  setState(() {

                  });
                }, icon: Icon(Icons.remove_red_eye_outlined)),
                prefixIcon: Icon(Icons.password),
                  maxLines: 1,
                  obsecureText:obsecureText,
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


                ),
                TextButton(onPressed: () {
                  Navigator.pushNamed(context, registerScreen.routeName);
                }, child: Text("Don't have Account ?",style: TextStyle(color: Color(0xff5D9CEC),fontWeight: FontWeight.w600,),))
              ],
            ),
          ),
        ),
      ),
    );
  }

void login() async {
    var authProvider = Provider.of<MyAuthProvider>(context,listen: false);
  if (formKey.currentState?.validate() == false) {
    return;
  }
  try {
    DialogUtils.showLoadingDialog(context, 'Loading...');
    await authProvider.login(emailController.text, passwordController.text);
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
