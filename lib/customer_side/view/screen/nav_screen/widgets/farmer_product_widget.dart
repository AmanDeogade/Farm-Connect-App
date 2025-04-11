import 'package:farmconnect/customer_side/controllers/product_controller.dart';
import 'package:farmconnect/customer_side/models/farmer.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/widgets/product_items_widget.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/widgets/reusable_widget.dart';
import 'package:flutter/material.dart';

class FarmerProductWidget extends StatefulWidget {
  final Farmer farmer;
  const FarmerProductWidget({super.key, required this.farmer});

  @override
  State<FarmerProductWidget> createState() => _FarmerProductWidgetState();
}

class _FarmerProductWidgetState extends State<FarmerProductWidget> {
  bool isLoading = true;
  List<dynamic> products =
      []; // Replace 'dynamic' with your actual Product model if available

  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    final ProductController farmerProductController = ProductController();
    try {
      final fetchedProducts = await farmerProductController.loadFarmerProducts(
        widget.farmer.id,
      );
      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching products: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:
          isLoading
              ? const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              )
              : products.isEmpty
              ? const Center(child: Text('No products found'))
              : SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductItemsWidget(product: product);
                  },
                ),
              ),
    );
  }
}
