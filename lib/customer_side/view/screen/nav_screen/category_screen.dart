import 'package:farmconnect/customer_side/controllers/category_controller.dart';
import 'package:farmconnect/customer_side/controllers/sub_category_controller.dart';
import 'package:farmconnect/customer_side/models/category.dart';
import 'package:farmconnect/customer_side/provider/category_provider.dart';
import 'package:farmconnect/customer_side/provider/subcategory_provider.dart';
import 'package:farmconnect/customer_side/view/screen/details/sub_category_screen.dart';
import 'package:farmconnect/customer_side/view/screen/details/widgets/two_inner_header_widget.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/widgets/subcategory_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();

    //load categories initially

    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final categories = await CategoryController().loadCategories();
    ref.read(categoryProvider.notifier).setCategories(categories);

    //set the default selected category (e.g) "fashion",
    for (var category in categories) {
      if (category.name == "Fruits") {
        setState(() {
          _selectedCategory = category;
        });

        //load subcategories  for the default category

        _fetchSubcategories(category.name);
      }
    }
  }

  Future<void> _fetchSubcategories(String categoryName) async {
    final subcategories = await SubCategoryController()
        .getSubCategoriesByCategoryName(categoryName);
    ref.read(subcategoryProvider.notifier).setSubCategories(subcategories);
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    final subcategories = ref.watch(subcategoryProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 20),
        child: TwoInnerHeaderWigets(),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //left side - Display categories
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade200,
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return ListTile(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                      _fetchSubcategories(category.name);
                    },
                    title: Text(
                      category.name,
                      style: GoogleFonts.quicksand(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color:
                            _selectedCategory == category
                                ? Colors.blue
                                : Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          //Right side - Display selected category details
          Expanded(
            flex: 5,
            child:
                _selectedCategory != null
                    ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _selectedCategory!.name,
                              style: GoogleFonts.quicksand(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.7,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    _selectedCategory!.banner,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          subcategories.isNotEmpty
                              ? GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: subcategories.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 8,
                                      childAspectRatio: 2 / 3,
                                    ),
                                itemBuilder: (context, index) {
                                  final subcategory = subcategories[index];

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            //SubcategoryScreen
                                            return SubcategoryProductScreen(
                                              subcategory: subcategory,
                                              // subcategory: subcategory,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: SubcategoryTileWidget(
                                      image: subcategory.images,
                                      title: subcategory.subCategoryName,
                                      subcategory: subcategory,
                                    ),
                                  );
                                },
                              )
                              : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'No Farm products found',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.7,
                                    ),
                                  ),
                                ),
                              ),
                        ],
                      ),
                    )
                    : Container(),
          ),
        ],
      ),
    );
  }
}
