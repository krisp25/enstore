// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constant.dart';
import 'package:ecommerce/pages/cartscreen.dart';
import 'package:ecommerce/pages/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductSreen extends StatefulWidget {
  const ProductSreen({super.key});

  static const routeName = '/productScreen';

  @override
  State<ProductSreen> createState() => _ProductSreenState();
}

class _ProductSreenState extends State<ProductSreen> {
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
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    final title = routeArgs['title'];
    final imageURL = routeArgs['imageURL'];
    final description = routeArgs['description'];
    final price = routeArgs['price'];
    final actualPrice = routeArgs['actualPrice'];

    void addProductToCart() async {
      Map<String, dynamic> productData = {
        'title': title,
        'imageURL': imageURL,
        'description': description,
        'price': price,
        'actualPrice': actualPrice
      };
      await FirebaseFirestore.instance.collection('cart').add(productData);
      log('Product added successfully');
    }

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
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Image.network(imageURL!),
            const SizedBox(
              height: 18,
            ),
            Text(
              title!,
              style: GoogleFonts.anekLatin(textStyle: productTitleStyle),
            ),
            Text(
              price!,
              style: GoogleFonts.anekLatin(textStyle: productPriceStyle),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              actualPrice!,
              style: GoogleFonts.anekLatin(textStyle: gridActualPriceStyle),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                addProductToCart();
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Add to Cart',
                  style: GoogleFonts.anekLatin(textStyle: productButtonStyle),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Description',
              style: GoogleFonts.anekLatin(
                  textStyle: productDescriptionTitleStyle),
            ),
            Text(
              description!,
              style: GoogleFonts.anekLatin(textStyle: productDescriptionStyle),
            ),
          ],
        ),
      ),
    );
  }
}
