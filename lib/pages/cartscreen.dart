import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constant.dart';
import 'package:ecommerce/pages/orderscreen.dart';
import 'package:ecommerce/widgets/listwidget.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const routeName = '/cartScreen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('cart').snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData && snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> product = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;
                    return ListWidget(
                      title: product['title'],
                      imageURL: product['imageURL'],
                      description: product['description'],
                      price: product['price'],
                      actualPrice: product['actualPrice'],
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(
                    'No products available!',
                    style: GoogleFonts.anekLatin(
                      textStyle: errorStyle,
                    ),
                  ),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(OrderScreen.routeName);
        },
        child: const Icon(Icons.arrow_forward_sharp),
      ),
    );
  }
}
