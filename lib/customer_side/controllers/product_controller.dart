import 'dart:convert';
import 'package:farmconnect/customer_side/models/product.dart';
import 'package:farmconnect/global_variable.dart';
import 'package:http/http.dart' as http;

class ProductController {
  Future<List<Product>> loadPopularProducts() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/popular-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse["product"];

        List<Product> products =
            data
                .map((item) => Product.fromJson(item as Map<String, dynamic>))
                .toList();

        return products;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to load popular products');
      }
    } catch (e) {
      throw Exception('error loading popular product : $e');
    }
  }

  Future<List<Product>> loadProductByCategory(String Category) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products-by-category/$Category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse["product"];

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
      //e);
      throw Exception('error loading products : $e');
    }
  }

  Future<List<Product>> loadProductsBySubcategory(String SubCategory) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products-by-subcategory/$SubCategory'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
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
      throw Exception('Error loading products: $e');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/search-products?query=$query'),
        headers: <String, String>{
          'Content-Type': 'application/json; chartset=UTF-8 ',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<Product> searchProducts =
            data
                .map((item) => Product.fromJson(item as Map<String, dynamic>))
                .toList();

        return searchProducts;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to load searched products');
      }
    } catch (e) {
      throw Exception('Error Loading searched Products : $e');
    }
  }

  Future<List<Product>> loadFarmerProducts(String farmerId) async {
    try {
      // Send an HTTP GET request to fetch products by subcategory
      http.Response response = await http.get(
        Uri.parse('$uri/api/product/farmer/$farmerId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['products'];

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
      //e);
      throw Exception('Error loading products: $e');
    }
  }
}
