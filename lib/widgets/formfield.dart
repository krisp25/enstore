import 'package:ecommerce/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormFieldWidget extends StatelessWidget {
  final String hint;

  const FormFieldWidget({
    required this.hint,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: hintTextStyle,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 2),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
        border: InputBorder.none
      ),
      style: GoogleFonts.anekLatin(
        textStyle: formStyle,
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if(value == null || value.isEmpty) {
          return 'Please enter a value';
        }
      },
    );
  }
}