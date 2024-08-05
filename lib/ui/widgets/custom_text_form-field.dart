import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);
class customTextFormField extends StatelessWidget {

String labelText ;
Validator? validator;
TextEditingController? controller;
customTextFormField({required this.labelText,this.validator,this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller ,
        validator: validator,
        cursorColor: Color(0xff5D9CEC),
        decoration: InputDecoration(
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
