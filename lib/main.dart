import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/pages/cartscreen.dart';
import 'package:ecommerce/pages/formscreen.dart';
import 'package:ecommerce/pages/loginscreen.dart';
import 'package:ecommerce/pages/orderscreen.dart';
import 'package:ecommerce/pages/productscreen.dart';
import 'package:ecommerce/pages/homescreen.dart';
import 'package:ecommerce/pages/registerscreen.dart';
import 'package:ecommerce/provider/cart.dart';
import 'package:ecommerce/provider/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CartProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ProductProvider(),
        )
      ],
      child: MaterialApp(
        title: 'E-Commerce App',
        theme: ThemeData(
            primarySwatch: Colors.teal,
            scaffoldBackgroundColor: Colors.blueGrey.shade200),
        initialRoute: (FirebaseAuth.instance.currentUser != null) ? HomeScreen.routeName : LoginScreen.routeName,
        routes: {
          HomeScreen.routeName: ((context) => const HomeScreen()),
          ProductSreen.routeName: ((context) => const ProductSreen()),
          AddProductForm.routeName: ((context) => const AddProductForm()),
          LoginScreen.routeName: ((context) => const LoginScreen()),
          RegisterScreen.routeName: ((context) => const RegisterScreen()),
          CartScreen.routeName: ((context) => const CartScreen()),
          OrderScreen.routeName: ((context) => const OrderScreen())
        },
      ),
    );
  }
}
