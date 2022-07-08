import 'package:ecommerce/constant.dart';
import 'package:ecommerce/pages/productscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridWidget extends StatefulWidget {
  final String title;
  final String imageURL;
  final String description;
  final String price;
  final String actualPrice;

  const GridWidget(
      {super.key,
      required this.title,
      required this.imageURL,
      required this.description,
      required this.price,
      required this.actualPrice});

  @override
  State<GridWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(ProductSreen.routeName, arguments: {
            'title': widget.title,
            'imageURL': widget.imageURL,
            'description': widget.description,
            'price': widget.price,
            'actualPrice': widget.actualPrice
          });
        },
        child: Container(
          height: 400,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                widget.imageURL,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 8,
              ),
              Flexible(
                child: Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.anekLatin(
                    textStyle: gridTitleStyle,
                  ),
                ),
              ),
              Text(
                widget.price,
                style: GoogleFonts.anekLatin(
                  textStyle: gridPriceStyle,
                ),
              ),
              Text(
                widget.actualPrice,
                style: GoogleFonts.anekLatin(
                  textStyle: gridActualPriceStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
