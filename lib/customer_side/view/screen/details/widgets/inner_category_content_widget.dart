import 'package:farmconnect/customer_side/controllers/product_controller.dart';
import 'package:farmconnect/customer_side/controllers/sub_category_controller.dart';
import 'package:farmconnect/customer_side/models/category.dart';
import 'package:farmconnect/customer_side/models/product.dart';
import 'package:farmconnect/customer_side/models/subcategory.dart';
import 'package:farmconnect/customer_side/view/screen/details/sub_category_screen.dart';
import 'package:farmconnect/customer_side/view/screen/details/widgets/inner_banner_wigets.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/widgets/product_items_widget.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/widgets/reusable_widget.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/widgets/subcategory_tile_widget.dart';
import 'package:farmconnect/customer_side/view/screen/details/widgets/inner_header_wigets copy.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InnerCategoryContentWidget extends StatefulWidget {
  final Category category;

  const InnerCategoryContentWidget({super.key, required this.category});
  @override
  State<InnerCategoryContentWidget> createState() =>
      _InnerCategoryContentWidgetState();
}

class _InnerCategoryContentWidgetState
    extends State<InnerCategoryContentWidget> {
  late Future<List<Subcategory>> _subcategories;
  late Future<List<Product>> futureProducts;
  final SubCategoryController _subCategoryController = SubCategoryController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subcategories = _subCategoryController.getSubCategoriesByCategoryName(
      widget.category.name,
    );
    futureProducts = ProductController().loadProductByCategory(
      widget.category.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.20,
        ),
        child: InnerHeaderWigets(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InnerBannerWigets(image: widget.category.banner),
            Center(
              child: Text(
                'Shop by Category',
                style: GoogleFonts.getFont(
                  'Lato',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FutureBuilder(
              future: _subcategories, // Explicitly specify the type here
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No data available"));
                } else {
                  final subcategories = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: List.generate(
                        ((subcategories.length) / 7).ceil(),
                        (setIndex) {
                          //for each row calculate starting and ending indices
                          final start = setIndex * 7;
                          final end = (setIndex + 1) * 7;

                          //Create a padding widget to add spacing around the row
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              //create a row of the sub category type
                              children:
                                  subcategories
                                      .sublist(
                                        start,
                                        end > subcategories.length
                                            ? subcategories.length
                                            : end,
                                      )
                                      .map(
                                        (e) => GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  //SubcategoryScreen
                                                  return SubcategoryProductScreen(
                                                    subcategory: e,
                                                    // subcategory: subcategory,
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          child: SubcategoryTileWidget(
                                            subcategory: e,
                                            image: e.images,
                                            title: e.subCategoryName,
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
            ReusableWidget(title: 'Popular Products', subtitle: 'View all'),
            FutureBuilder(
              future: futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No Product under this category available"),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  final products = snapshot.data!;
                  return SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductItemsWidget(product: product);
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
