// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = '/registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void createAccount() async {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      log("Please enter all details");
    } else if (password != confirmPassword) {
      log('Password does not match!');
    } else {
      try {
        UserCredential userCredentials =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        Map<String, dynamic> user = {
          'name': username,
          'email': email
        };

        await FirebaseFirestore.instance.collection('users').add(user);
        
        if(userCredentials.user != null) {
          Navigator.of(context).pop();
        }
      } on FirebaseAuthException catch (exception) {
        log(exception.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enstore',
              style: GoogleFonts.anekLatin(
                textStyle: appNameStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  hintStyle: hintTextStyle,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.anekLatin(
                  textStyle: formStyle,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email ID',
                  hintStyle: hintTextStyle,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.anekLatin(
                  textStyle: formStyle,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: hintTextStyle,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.anekLatin(
                  textStyle: formStyle,
                ),
                obscureText: true,
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  hintStyle: hintTextStyle,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.anekLatin(
                  textStyle: formStyle,
                ),
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  createAccount();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Register',
                    style: GoogleFonts.anekLatin(
                      textStyle: productButtonStyle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
