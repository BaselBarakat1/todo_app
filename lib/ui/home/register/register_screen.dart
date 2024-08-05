import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_error_codes/firebase_error_codes.dart';
import 'package:todo_app/ui/widgets/custom_text_form-field.dart';
import 'package:todo_app/utils/email_format.dart';
import 'package:todo_app/utils/password_format.dart';

class registerScreen extends StatelessWidget {
static const String routeName = 'register_screen';
TextEditingController fullNameController = TextEditingController();
TextEditingController userNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController passwordConfirmationController = TextEditingController();
var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void createAccount() async {
     if(formKey.currentState?.validate() == false){
       return;
     }
     try{
     var credintial = await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: emailController.text,
         password: passwordController.text);
     print(credintial.user?.uid);
     } on FirebaseAuthException catch (e) {
       if (e.code == FirebaseErrorCodes.weakPassword) {
         print('The password provided is too weak.');
       } else if (e.code == FirebaseErrorCodes.emailAlreadyInUse) {
         print('The account already exists for that email.');
       }
     } catch (e) {
       print(e);
     }
    }
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
                customTextFormField(labelText: 'Password Confirmation',
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
}
