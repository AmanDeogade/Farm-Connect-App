import 'package:farmconnect/customer_side/models/product.dart';
import 'package:farmconnect/customer_side/view/screen/details/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductItemsWidget extends StatelessWidget {
  final Product product;

  const ProductItemsWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductDetailScreen(product: product);
            },
          ),
        );
      },
      child: Container(
        width: 170,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.grey.shade200,
              ),
              child: Stack(
                children: [
                  Image.network(
                    product.images[0],
                    height: 170,
                    width: 170,
                    fit: BoxFit.cover,
                  ),
                  // Positioned(
                  //   top: 15,
                  //   right: 2,
                  //   child: Image.asset(
                  //     'assets/icons/love.png',
                  //     width: 25,
                  //     height: 25,
                  //   ),
                  // ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/icons/cart.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${product.productName} (${product.subCategory})",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: GoogleFonts.roboto(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 2),
            Text(
              "Farmer: ${product.fullName.split(' ')[1]}",
              style: GoogleFonts.quicksand(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7F7F7F),
              ),
            ),
            Text(
              'Rs ${product.productPrice.toStringAsFixed(2)}/${product.quantityUnit}',
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
