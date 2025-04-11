import 'dart:convert';
import 'package:farmconnect/customer_side/models/order.dart';
import 'package:farmconnect/customer_side/services/manage_http_response.dart';
import 'package:farmconnect/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      print("Hello");
      http.Response response = await http.get(
        Uri.parse('$uri/api/orders/$buyerId'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        print(data);
        List<Order> orders =
            data.map((order) => Order.fromJson(order)).toList();
        print("Orders: $orders");
        print(orders);

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

  //delete order by ID
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

  Future<Map<String, dynamic>> createPaymentIntent({
    required int amount,
    required String currency,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("auth_token");

      http.Response response = await http.post(
        Uri.parse('$uri/api/payment-intent'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
        body: jsonEncode({'amount': amount, 'currency': currency}),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to create payment  intent ${response.body}");
      }
    } catch (e) {
      throw Exception("Error Create  Payment Intent: $e");
    }
  }

  //retrive payment intent to know if the payment was successfull or not

  Future<Map<String, dynamic>> getPaymentIntentStatus({
    required BuildContext context,
    required String paymentIntentId,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('auth_token');

      http.Response response = await http.get(
        Uri.parse('$uri/api/payment-intent/$paymentIntentId'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to get payment  intent ${response.body}");
      }
    } catch (e) {
      throw Exception("Failed to get payment  intent $e");
    }
  }

  Future<Map<String, dynamic>> createStripeCustomer({
    required String fullName,
    required String email,
    required BuildContext context,
  }) async {
    try {
      // Retrieve the token from SharedPreferences
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('auth_token');

      // Prepare the API request
      http.Response response = await http.post(
        Uri.parse('$uri/api/stripe/customers'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
        body: jsonEncode({'fullName': fullName, 'email': email}),
      );

      // Handle the response
      if (response.statusCode == 201) {
        // Parse and return the customer data
        return jsonDecode(response.body);
      } else {
        // Throw an error if the response is not successful
        throw Exception("Failed to create customer: ${response.body}");
      }
    } catch (e) {
      showSnackBar(context, "Error creating Stripe customer: $e");
      throw Exception("Error creating Stripe customer: $e");
    }
  }
}
