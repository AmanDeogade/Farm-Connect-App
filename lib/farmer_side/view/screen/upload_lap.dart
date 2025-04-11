import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:farmconnect/customer_side/controllers/category_controller.dart';
import 'package:farmconnect/customer_side/controllers/product_controller.dart';
import 'package:farmconnect/customer_side/controllers/sub_category_controller.dart';
import 'package:farmconnect/customer_side/models/category.dart';
import 'package:farmconnect/customer_side/models/subcategory.dart';
import 'package:farmconnect/farmer_side/controllers/farmer_product_controller.dart';
import 'package:farmconnect/farmer_side/provider/farmer_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';

class UploadScreenLap extends ConsumerStatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends ConsumerState<UploadScreenLap> {
  late Future<List<Category>> futureCategory;
  Future<List<Subcategory>>? futureSubcategory;
  late String categoryName;
  Subcategory? selectedSubcategory;
  bool isLoading = false;

  getSubCategoryByCategory(String value) {
    setState(() {
      futureSubcategory = SubCategoryController()
          .getSubCategoriesByCategoryName(value);
    });
    // selectedCategory = null;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Category? selectedCategory;
  @override
  initState() {
    super.initState();
    futureCategory = CategoryController().loadCategories();
  }

  final ImagePicker _picker = ImagePicker();
  List<XFile> selectedImages = [];
  CameraController? _controller;
  final FarmerProductController productController = FarmerProductController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityUnit = TextEditingController();

  chooseImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      print('No image selected');
    } else {
      setState(() {
        selectedImages.add(XFile(pickedFile.path));
      });
    }
  }

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (selectedImages.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select at least one image.")),
        );
        return;
      }

      // Process the data (e.g., upload)
      final farmerName = ref.read(farmerUserProvider)!.fullName;
      final farmerId = ref.read(farmerUserProvider)!.id;
      // print(
      //   nameController.text +
      //       quantityController.text +
      //       descriptionController.text +
      //       farmerName +
      //       farmerId +
      //       priceController.text +
      //       quantityController.text +
      //       descriptionController.text +
      //       selectedCategory!.name +
      //       quantityUnit.text,
      // );

      setState(() {
        isLoading = true;
      });
      await productController
          .uploadProduct(
            productName: nameController.text,
            quantity: int.parse(quantityController.text),
            productPrice: int.parse(priceController.text),
            description: descriptionController.text,
            category: selectedCategory!.name,
            farmerId: farmerId,
            fullName: farmerName,
            subCategory: selectedSubcategory!.subCategoryName,
            pickedImage: selectedImages,
            context: context,
            quantityUnit: quantityUnit.text,
          )
          .whenComplete(() {
            setState(() {
              isLoading = false;
            });
            selectedCategory = null;
            selectedSubcategory = null;
            nameController.clear();
            priceController.clear();
            quantityController.clear();
            descriptionController.clear();
            quantityUnit.clear();
            selectedImages = [];
          });
    }
  }

  Widget _buildImageGallery() {
    if (selectedImages.isEmpty) {
      return SizedBox();
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: selectedImages.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return FutureBuilder<Uint8List>(
          future: selectedImages[index].readAsBytes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Icon(Icons.error));
            } else {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(snapshot.data!, fit: BoxFit.cover),
              );
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select or Take Image")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: chooseImage,
                      child: Text("Pick from Gallery"),
                    ),
                  ],
                ),
                // Display the images in a grid
                Container(
                  height:
                      selectedImages.isEmpty
                          ? 0
                          : (selectedImages.length > 3
                              ? 240
                              : 120), // Give height to the GridView to ensure scrollability
                  child: _buildImageGallery(),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Info Form
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Product Name',
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? 'Please enter product name'
                                    : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: priceController,
                        decoration: const InputDecoration(
                          labelText: 'Product Price',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? 'Please enter product price'
                                    : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: quantityController,
                        decoration: const InputDecoration(
                          labelText: 'Product Quantity',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? 'Please enter product quantity'
                                    : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: quantityUnit,
                        decoration: const InputDecoration(
                          labelText: 'in Kg or Gram',
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? 'Please enter product quantity'
                                    : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: descriptionController,
                        maxLines: 3,
                        maxLength: 500,
                        decoration: const InputDecoration(
                          labelText: 'Product Description',
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? 'Please enter product description'
                                    : null,
                      ),
                      SizedBox(
                        width: 200,
                        child: FutureBuilder<List<Category>>(
                          future: futureCategory,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Category> categories = snapshot.data!;
                              return DropdownButton<Category>(
                                value: selectedCategory,
                                hint: Text('Select Category'),
                                items:
                                    snapshot.data!.map((Category category) {
                                      return DropdownMenuItem(
                                        value: category,
                                        child: Text(category.name),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCategory = value;
                                  });
                                  getSubCategoryByCategory(
                                    selectedCategory!.name,
                                  );
                                  print(selectedCategory!.name);
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: FutureBuilder<List<Subcategory>>(
                          future: futureSubcategory,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Subcategory> subcategories = snapshot.data!;
                              return DropdownButton<Subcategory>(
                                value: selectedSubcategory,
                                hint: Text('Select Sub Category'),
                                items:
                                    snapshot.data!.map((
                                      Subcategory subcategory,
                                    ) {
                                      return DropdownMenuItem(
                                        value: subcategory,
                                        child: Text(
                                          subcategory.subCategoryName,
                                        ),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedSubcategory = value;
                                  });
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text("No Subcategory"),
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: submitForm,
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.blue.shade900,
                            ),
                            child: Center(
                              child:
                                  isLoading
                                      ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                      : Text(
                                        'Upload Product',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.7,
                                        ),
                                      ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
