import 'package:farmconnect/customer_side/controllers/product_controller.dart';
import 'package:farmconnect/customer_side/models/subcategory.dart';
import 'package:farmconnect/customer_side/provider/subcategory_product_provider.dart';
import 'package:farmconnect/customer_side/provider/subcategory_provider.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/widgets/product_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubcategoryProductScreen extends ConsumerStatefulWidget {
  final Subcategory subcategory;

  const SubcategoryProductScreen({super.key, required this.subcategory});

  @override
  ConsumerState<SubcategoryProductScreen> createState() =>
      _SubcategoryProductScreenState();
}

class _SubcategoryProductScreenState
    extends ConsumerState<SubcategoryProductScreen> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    final products = ref.read(subcategoryProvider);
    //products.length);
    if (!products.isEmpty) {
      _fetchProduct();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchProduct() async {
    final ProductController productController = ProductController();
    try {
      //widget.subcategory.subCategoryName);
      final products = await productController.loadProductsBySubcategory(
        widget.subcategory.subCategoryName,
      );
      //"Aman3");
      //"Product are ${products}");
      ref.read(subcategoryProductProvider.notifier).setProducts(products);
    } catch (e) {
      //"$e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final subproducts = ref.watch(subcategoryProductProvider);
    final screenWidth = 470; //MediaQuery.of(context).size.width;

    //set the number of colume in grid base on the screen width
    //if the screen with is less than 600 pixels(e.g.. a phone), use columns
    //if the screen is 600 pixels ore more (e.g .. a table ),use 4 column
    final crossAxisCount = screenWidth < 600 ? 2 : 4;

    //set the aspect ratio(width-to-heigth ratio) of each grid item base on the screen width

    //for smaller screen(<600 pixels) use a ration of 3.4(taller items)

    //for larger screen(>=600 pixels), use a ratio of 4.5(more square-shaped items)

    final childAspectRatio = screenWidth < 600 ? 3 / 4 : 4 / 5;
    return Scaffold(
      appBar: AppBar(title: Text(widget.subcategory.subCategoryName)),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: subproducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final product = subproducts[index];
                    return ProductItemsWidget(product: product);
                  },
                ),
              ),
    );
  }
}
