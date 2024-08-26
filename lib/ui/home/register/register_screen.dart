import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth_provider/auth_provider.dart';
import 'package:todo_app/database/model/user.dart' as MyUser;
import 'package:todo_app/database/user_dao.dart';
import 'package:todo_app/firebase_error_codes/firebase_error_codes.dart';
import 'package:todo_app/ui/home/login/login_screen.dart';
import 'package:todo_app/ui/widgets/custom_text_form-field.dart';
import 'package:todo_app/utils/dialog_utils.dart';
import 'package:todo_app/utils/email_format.dart';
import 'package:todo_app/utils/password_format.dart';

class registerScreen extends StatefulWidget {
static const String routeName = 'register_screen';

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
TextEditingController fullNameController = TextEditingController();

TextEditingController userNameController = TextEditingController();

TextEditingController emailController = TextEditingController();

TextEditingController passwordController = TextEditingController();

TextEditingController passwordConfirmationController = TextEditingController();

bool obsecureText= true;

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
          title: Text('Create Account'),
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
                customTextFormField(labelText: 'Full Name',
                  controller: fullNameController ,
                  validator: (input) {
                    if(input == null || input.isEmpty){
                      return 'Please Enter Full Name';
                    }
                    return null;
                  },
                ),
                customTextFormField(labelText: 'User Name',
                  controller: userNameController,
                  validator: (input) {
                    if(input == null || input.isEmpty){
                      return ' Please Enter User Name';
                    }
                    return null;
                  },
                ),
                customTextFormField(labelText: 'Email',
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
                maxLines: 1,
                controller: passwordController,
                  obsecureText: obsecureText,
                suffixIcon: IconButton(onPressed: () {
                  if(obsecureText == true){
                    obsecureText = false;
                  }else{
                    obsecureText =true;
                  }
                  setState(() {

                  });
                }, icon: Icon(Icons.remove_red_eye_outlined)),
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
                customTextFormField(labelText: 'Password Confirmation',
                maxLines: 1,
                obsecureText: obsecureText,
                suffixIcon: IconButton(onPressed: () {
                  if(obsecureText == true){
                    obsecureText = false;
                  }else{
                    obsecureText =true;
                  }
                  setState(() {

                  });
                }, icon: Icon(Icons.remove_red_eye_outlined)),
                controller: passwordConfirmationController,
                validator: (input) {
                  if(input == null || input.isEmpty){
                    return ' Please Enter Password Confirmation';
                  }
                  if(input.length < 6){
                    return 'Pasword must be at least 6 characters';
                  }
                  if(input != passwordController.text){
                    return 'Password Not Match';
                  }
                  return null;
                },
                ),
                ElevatedButton(onPressed: () {
                  createAccount();
                },
                  child: Text('Create Account',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15)),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

void createAccount() async {
    var authProvider = Provider.of<MyAuthProvider>(context,listen: false);
  if(formKey.currentState?.validate() == false){
    return;
  }
  try{
    DialogUtils.showLoadingDialog(context, 'Loading...');
    authProvider.register(emailController.text, passwordController.text, fullNameController.text, userNameController.text);
    DialogUtils.hideDialog(context);
    DialogUtils.showMessage(context, 'Account Created Successfully',icon: Icon(Icons.check_circle,color: Colors.green ),postiveActionTitle: 'Ok',posAction: () {
      Navigator.pushReplacementNamed(context, loginScreen.routeName);
    },);
  } on FirebaseAuthException catch (e) {
    if (e.code == FirebaseErrorCodes.weakPassword) {
      DialogUtils.showMessage(context, 'The password provided is too weak.',postiveActionTitle: 'Ok');
     // print('The password provided is too weak.');
    } else if (e.code == FirebaseErrorCodes.emailAlreadyInUse) {
      DialogUtils.showMessage(context, 'The account already exists for that email.',postiveActionTitle: 'Ok');
      //print('The account already exists for that email.');
    }
  } catch (e) {
    DialogUtils.showMessage(context, 'Something went wrong.',postiveActionTitle: 'Ok');
  }
}
}
