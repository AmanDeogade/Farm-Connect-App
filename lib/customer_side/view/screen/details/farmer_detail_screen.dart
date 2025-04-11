import 'package:farmconnect/customer_side/models/farmer.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/widgets/farmer_product_widget.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/widgets/popular_product_widget.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmerDetailScreen extends ConsumerStatefulWidget {
  final Farmer farmer;
  const FarmerDetailScreen({super.key, required this.farmer});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<FarmerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // final cartProviderData = ref.read(cartProvider.notifier);
    // final cartData = ref.watch(cartProvider);
    // final isInCart = cartData.containsKey(widget.product.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Farmer Detail',
          style: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 400,
                height: 274,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Color(0xFF9CA8FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: SizedBox(
                  height: 300,
                  child: PageView.builder(
                    itemCount: widget.farmer.profileImage.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Image.network(
                        widget.farmer.profileImage,
                        height: 170,
                        width: 290,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.farmer.fullName,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "${widget.farmer.city}, ${widget.farmer.state}",
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.lato(
                        fontSize: 17,
                        letterSpacing: 1.7,
                        color: Color(0xFF363330),
                      ),
                      children: [
                        TextSpan(
                          text: 'Total Area for Farming: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${widget.farmer.area}'),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.lato(
                        fontSize: 17,
                        letterSpacing: 1.7,
                        color: Color(0xFF363330),
                      ),
                      children: [
                        TextSpan(
                          text: 'Agriculture Method: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${widget.farmer.agromethod}'),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.lato(
                        fontSize: 17,
                        letterSpacing: 1.7,
                        color: Color(0xFF363330),
                      ),
                      children: [
                        TextSpan(
                          text: 'Farmer Information: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${widget.farmer.description}'),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ReusableWidget(
                    title: '${widget.farmer.fullName}\'s Products',
                    subtitle: '',
                  ),
                  FarmerProductWidget(farmer: widget.farmer),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
