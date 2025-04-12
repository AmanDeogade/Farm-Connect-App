import 'dart:convert';
import 'package:farmconnect/customer_side/models/order.dart';
import 'package:farmconnect/customer_side/services/manage_http_response.dart';
import 'package:farmconnect/global_variable.dart';
import 'package:http/http.dart' as http;

class OrderController {
  uploadOrders({
    required String id,
    required String fullName,
    required String email,
    required String state,
    required String city,
    required String locality,
    required String productName,
    required int productPrice,
    required int quantity,
    required String category,
    required String image,
    required String buyerId,
    required String farmerId,
    required bool processing,
    required bool delivered,
    required context,
    required String paymentStatus,
    required String paymentIntentId,
    required String paymentMethod,
  }) async {
    try {
      final Order order = Order(
        id: id,
        fullName: fullName,
        email: email,
        state: state,
        city: city,
        locality: locality,
        productName: productName,
        productPrice: productPrice,
        quantity: quantity,
        category: category,
        image: image,
        buyerId: buyerId,
        farmerId: farmerId,
        processing: processing,
        delivered: delivered,
        paymentStatus: paymentStatus,
        paymentIntentId: paymentIntentId,
        paymentMethod: paymentMethod,
      );

      http.Response response = await http.post(
        Uri.parse("$uri/api/orders"),
        body: order.toJson(),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'You have placed an order');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> loadOrders({required String buyerId}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/orders/$buyerId'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Order> orders =
            data.map((order) => Order.fromJson(order)).toList();

        return orders;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception("failed to load Orders");
      }
    } catch (e) {
      throw Exception('error Loading Orders');
    }
  }

  Future<void> deleteOrder({required String id, required context}) async {
    try {
      http.Response response = await http.delete(
        Uri.parse("$uri/api/orders/$id"),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Order Deleted successfully');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<int> getDeliveredOrderCount({required String buyerId}) async {
    try {
      List<Order> orders = await loadOrders(buyerId: buyerId);
      int deliveredCount =
          orders
              .where((order) => order.delivered && order.buyerId == buyerId)
              .length;
      return deliveredCount;
    } catch (e) {
      throw Exception("Error counting Delivered Orders");
    }
  }
}
