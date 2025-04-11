import 'dart:convert';

import 'package:farmconnect/customer_side/models/product.dart';
import 'package:farmconnect/global_variable.dart';
import 'package:http/http.dart' as http;

class ProductController {
  Future<List<Product>> loadPopularProducts() async {
    try {
      //send an http get request to fetch categories
      http.Response response = await http.get(
        Uri.parse('$uri/api/popular-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        List<dynamic> data =
            jsonResponse["product"]; // ✅ Extract "product" list
        print("data");
        print(data);

        List<Product> products =
            data
                .map((item) => Product.fromJson(item as Map<String, dynamic>))
                .toList();
        print("Products Are");
        print(products);

        return products;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to load popular products');
      }
    } catch (e) {
      print(e);
      throw Exception('error loading popular product : $e');
    }
  }

  Future<List<Product>> loadProductByCategory(String Category) async {
    try {
      //send an http get request to fetch categories
      http.Response response = await http.get(
        Uri.parse('$uri/api/products-by-category/$Category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        //suggests that you are trying to treat a map (Map<String, dynamic>) as a list (List<dynamic>).
        /* 
        Your ProductController class is trying to parse the API response as a List<dynamic>
        using jsonDecode(response.body), but it's likely that the API is returning an object 
        (Map<String, dynamic>) instead of a list (List<dynamic>).
        */
        Map<String, dynamic> jsonResponse = jsonDecode(
          response.body,
        ); // ✅ Decode as Map
        List<dynamic> data =
            jsonResponse["product"]; // ✅ Extract "product" list

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
      throw Exception('error loading products : $e');
    }
  }

  Future<List<Product>> loadProductsBySubcategory(String SubCategory) async {
    try {
      // Send an HTTP GET request to fetch products by subcategory
      http.Response response = await http.get(
        Uri.parse('$uri/api/products-by-subcategory/$SubCategory'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("Body ${response.body}");

      if (response.statusCode == 200) {
        // Directly parse the response body as a List<dynamic> since the response is a list
        List<dynamic> data = jsonDecode(response.body);

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

  //Search products by name or description

  Future<List<Product>> searchProducts(String query) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/search-products?query=$query'),
        headers: <String, String>{
          'Content-Type': 'application/json; chartset=UTF-8 ',
        },
      );
      print('subcategory product response..${response.body}');
      if (response.statusCode == 200) {
        // Directly parse the response body as a List<dynamic> since the response is a list
        List<dynamic> data = jsonDecode(response.body);

        // Map the list to Product objects
        List<Product> searchProducts =
            data
                .map((item) => Product.fromJson(item as Map<String, dynamic>))
                .toList();

        return searchProducts;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        //if status code is not 200 , throw an execption   indicating failure to load the popular products
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
