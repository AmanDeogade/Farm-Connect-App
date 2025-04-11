import 'dart:convert'; // Add this import
import 'package:farmconnect/customer_side/models/category.dart';
import 'package:farmconnect/global_variable.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  Future<List<Category>> loadCategories() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/categories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Category> categories =
            data.map((category) => Category.fromJson(category)).toList();
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print(e);
      throw Exception('error loading categories');
    }
  }
}
