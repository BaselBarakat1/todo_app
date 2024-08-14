import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);
class customTextFormField extends StatelessWidget {
Icon? prefixIcon;
Widget? suffixIcon;
String labelText ;
bool obsecureText ;
Validator? validator;
TextEditingController? controller;
customTextFormField({required this.labelText,this.validator,this.controller,this.prefixIcon,this.obsecureText = false,this.suffixIcon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        obscureText: obsecureText,
        controller: controller ,
        validator: validator,
        cursorColor: Color(0xff5D9CEC),
        decoration: InputDecoration(
          suffixIcon: suffixIcon ,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Color(0xff5D9CEC),width: 2),
          ),
          label: Text(labelText),
          floatingLabelStyle: TextStyle(color: Color(0xff5D9CEC))

        ),
      ),
    );
  }
}
