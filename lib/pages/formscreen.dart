// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constant.dart';
import 'package:ecommerce/models/productmodel.dart';
import 'package:ecommerce/pages/cartscreen.dart';
import 'package:ecommerce/pages/loginscreen.dart';
import 'package:ecommerce/provider/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  static const routeName = '/formScreen';

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController imageURLContrpller = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController actualPriceController = TextEditingController();

  void addProduct() async {
    String title = titleController.text.trim();
    String imageURL = imageURLContrpller.text.trim();
    String description = descriptionController.text.trim();
    String price = priceController.text.trim();
    String actualPrice = actualPriceController.text.trim();

    Provider.of<ProductProvider>(context).addProduct(ProductModel(
      title: title,
      imageURL: imageURL,
      description: description,
      price: price,
      actualPrice: actualPrice,
    ));

    if (title.isNotEmpty ||
        imageURL.isNotEmpty ||
        description.isNotEmpty ||
        price.isNotEmpty ||
        actualPrice.isNotEmpty) {
      Map<String, dynamic> productData = {
        'title': title,
        'imageURL': imageURL,
        'description': description,
        'price': price,
        'actualPrice': actualPrice
      };
      await FirebaseFirestore.instance.collection('products').add(productData);
      log('Product added successfully');
    }
  }

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
        padding: const EdgeInsets.all(10),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Title',
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
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: imageURLContrpller,
                      decoration: InputDecoration(
                          hintText: 'Image URL',
                          hintStyle: hintTextStyle,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.teal, width: 2),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                          border: InputBorder.none),
                      style: GoogleFonts.anekLatin(
                        textStyle: formStyle,
                      ),
                      keyboardType: TextInputType.text,
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Description',
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
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                          hintText: 'Price',
                          hintStyle: hintTextStyle,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.teal, width: 2),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                          border: InputBorder.none),
                      style: GoogleFonts.anekLatin(
                        textStyle: formStyle,
                      ),
                      keyboardType: TextInputType.text,
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: actualPriceController,
                      decoration: InputDecoration(
                          hintText: 'Actual Price',
                          hintStyle: hintTextStyle,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.teal, width: 2),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                          border: InputBorder.none),
                      style: GoogleFonts.anekLatin(
                        textStyle: formStyle,
                      ),
                      keyboardType: TextInputType.text,
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        addProduct();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          'Add',
                          style: GoogleFonts.anekLatin(
                              textStyle: productButtonStyle),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
