import 'dart:convert';
import 'package:farmconnect/customer_side/models/banner.dart';
import 'package:farmconnect/global_variable.dart';
import 'package:http/http.dart' as http;

class BannerController {
  Future<List<BannerModel>> loadBanner() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();

        return banners;
      } else {
        throw Exception('Failed to load banner');
      }
    } catch (e) {
      print(e);
      throw Exception('error loading banner');
    }
  }
}
