import 'dart:convert';
import 'package:farmconnect/customer_side/models/product.dart';
import 'package:farmconnect/customer_side/services/manage_http_response.dart';
import 'package:farmconnect/global_variable.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class FarmerProductController {
  Future<void> uploadProduct({
    required String productName,
    required int quantity,
    required String quantityUnit,
    required int productPrice,
    required String description,
    required String category,
    required String farmerId,
    required String fullName,
    required String subCategory,
    required List<XFile>? pickedImage,
    required context,
  }) async {
    if (pickedImage != null) {
      final cloudinary = CloudinaryPublic("dni5pw0wh", "farmconn");
      List<String> images = [];

      for (var i = 0; i < pickedImage.length; i++) {
        CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(pickedImage[i].path, folder: productName),
        );

        images.add(cloudinaryResponse.secureUrl);
      }
      if (category.isNotEmpty && subCategory.isNotEmpty) {
        final Product product = Product(
          id: '',
          productName: productName,
          productPrice: productPrice,
          quantity: quantity,
          quantityUnit: quantityUnit,
          description: description,
          category: category,
          farmerId: farmerId,
          fullName: fullName,
          subCategory: subCategory,
          images: images,
          popular: true,
          recommend: false,
        );
        print(product.farmerId);
        print(product.fullName);
        //showSnackBar(context, product.toJson().toString());
        http.Response response = await http.post(
          Uri.parse('$uri/api/add-product'),
          body: jsonEncode(product.toJson()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
        print(response.body);

        // showSnackBar(context, response.body);

        manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product added successfully.');
          },
        );
      } else {
        showSnackBar(context, 'Select category and subcategory.');
      }
    } else {
      showSnackBar(context, 'Select at least one image.');
    }
  }

  Future<List<Product>> loadFarmerProducts(String FarmerId) async {
    try {
      // Send an HTTP GET request to fetch products by subcategory
      http.Response response = await http.get(
        Uri.parse('$uri/api/product/vendor/$FarmerId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("Body ${response.body}");

      if (response.statusCode == 200) {
        // Decode the response as a Map
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Extract the list of products
        List<dynamic> data = jsonResponse['products'];

        // Map the list to Product objects
        List<Product> products =
            data
                .map((item) => Product.fromJson(item as Map<String, dynamic>))
                .toList();

        return products;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print(e);
      throw Exception('Error loading products: $e');
    }
  }
}
