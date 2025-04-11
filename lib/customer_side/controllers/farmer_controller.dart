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
      print("Raw response body: ${response.body}");

      if (response.statusCode == 200) {
        // Decode the JSON response
        List<dynamic> decoded = json.decode(response.body);
        print("Decoded JSON: $decoded");

        // Check if the decoded response is a List
        if (decoded is List) {
          print("Decoded response is a List.");

          List<Farmer> farmers =
              decoded
                  .map((item) => Farmer.fromJson(item as Map<String, dynamic>))
                  .toList();

          return farmers;
        } else {
          print("Expected a List, but got: $decoded");
          throw Exception('Expected a list of farmers');
        }
      } else if (response.statusCode == 404) {
        // Return an empty list if no farmers are found
        print("No farmers found (404 error)");
        return [];
      } else {
        print("Failed to load farmers. Status code: ${response.statusCode}");
        throw Exception('Failed to load farmers');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error loading farmers: $e');
    }
  }
}
