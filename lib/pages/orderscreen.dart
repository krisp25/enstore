// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce/constant.dart';
import 'package:ecommerce/pages/cartscreen.dart';
import 'package:ecommerce/pages/homescreen.dart';
import 'package:ecommerce/pages/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  static const routeName = '/orderScreen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Enstore',
          style: GoogleFonts.anekLatin(
            textStyle: appBarStyle,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
          IconButton(
            onPressed: () {
              logout();
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: prefer_const_constructors
              Icon(
                Icons.check_circle_outline_outlined,
                color: Colors.teal,
                size: 60,
              ),
              Text(
                'Thankyou!',
                style: GoogleFonts.anekLatin(
                  textStyle: thankyouStyle
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Your Order has been placed successfully',
                style: GoogleFonts.anekLatin(
                  textStyle: orderPlacementStyle
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.teal),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Continue Shopping',
                  style: GoogleFonts.anekLatin(textStyle: productButtonStyle),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}