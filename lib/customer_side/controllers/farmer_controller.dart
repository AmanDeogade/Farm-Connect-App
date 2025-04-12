import 'dart:convert';
import 'package:farmconnect/customer_side/models/farmer.dart';
import 'package:farmconnect/global_variable.dart';
import 'package:http/http.dart' as http;

class FarmerController {
  Future<List<Farmer>> loadFarmer() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/farmer'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> decoded = json.decode(response.body);
        if (decoded is List) {
          List<Farmer> farmers =
              decoded
                  .map((item) => Farmer.fromJson(item as Map<String, dynamic>))
                  .toList();

          return farmers;
        } else {
          throw Exception('Expected a list of farmers');
        }
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to load farmers');
      }
    } catch (e) {
      throw Exception('Error loading farmers: $e');
    }
  }
}
