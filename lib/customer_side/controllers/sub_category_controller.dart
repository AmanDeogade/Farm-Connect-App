import 'dart:convert';
import 'package:farmconnect/customer_side/models/subcategory.dart';
import 'package:farmconnect/global_variable.dart';
import 'package:http/http.dart' as http;

class SubCategoryController {
  Future<List<Subcategory>> getSubCategoriesByCategoryName(
    String categoryName,
  ) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/category/$categoryName/subcategories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return data
              .map((subcategory) => Subcategory.fromJson(subcategory))
              .toList();
        } else {
          return [];
        }
      } else if (response.statusCode == 404) {
        return [];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
