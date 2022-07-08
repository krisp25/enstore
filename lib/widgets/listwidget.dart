import 'package:ecommerce/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListWidget extends StatefulWidget {
  final String title;
  final String imageURL;
  final String description;
  final String price;
  final String actualPrice;

  const ListWidget(
      {super.key,
      required this.title,
      required this.imageURL,
      required this.description,
      required this.price,
      required this.actualPrice});

  @override
  State<ListWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          widget.imageURL,
        ),
        title: Text(
          widget.title,
          style: GoogleFonts.anekLatin(textStyle: listTitleStyle),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          widget.price,
          style: GoogleFonts.anekLatin(textStyle: listPriceStyle),
        ),
        trailing: const Icon(
          Icons.delete,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
