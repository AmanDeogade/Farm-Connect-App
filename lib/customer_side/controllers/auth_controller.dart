import 'dart:convert';
import 'package:farmconnect/Customer_Side/view/screen/authentication_screen/login_screen.dart';
import 'package:farmconnect/customer_side/models/user.dart';
import 'package:farmconnect/customer_side/provider/delivery_order_count_provider.dart';
import 'package:farmconnect/customer_side/provider/user_provider.dart';
import 'package:farmconnect/customer_side/services/manage_http_response.dart';
import 'package:farmconnect/customer_side/view/screen/main_screen.dart';
import 'package:farmconnect/global_variable.dart';
import 'package:farmconnect/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AuthController {
  Future<void> signUPUsers({
    required BuildContext context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        password: password,
        token: '',
      );

      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
          showSnackBar(context, 'Account has been Created for you');
        },
      );
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<void> signInUsers({
    required BuildContext context,
    required String email,
    required String password,
    required WidgetRef ref,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();

          String token = jsonDecode(response.body)['token'];

          await preferences.setString('auth_token', token);
          final userJson = jsonEncode(jsonDecode(response.body)['user']);

          ref.read(userProvider.notifier).setUser(userJson);

          await preferences.setString('user', userJson);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => MainScreen()),
            (route) => false,
          );
          showSnackBar(context, 'Logged In');
        },
      );
    } catch (e) {
      print("Error : $e");
    }
  }

  ///SignOut
  Future<void> signOut({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('auth_token');
      await preferences.remove('user');
      ref.read(userProvider.notifier).signOut();
      ref.read(deliveredOrderCountProvider.notifier).resetCount();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => ClassSelectionScreen()),
        (route) => false,
      );
      showSnackBar(context, 'Signout Successfully');
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<void> updateUserLocation({
    required BuildContext context,
    required String id,
    required String state,
    required String city,
    required String locality,
    required WidgetRef ref,
  }) async {
    try {
      final http.Response response = await http.put(
        Uri.parse('$uri/api/user/$id'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
        //Encode the update data(state, city and locality) AS  Json object
        body: jsonEncode({'state': state, 'city': city, 'locality': locality}),
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          final updatedUser = jsonDecode(response.body);
          SharedPreferences preferences = await SharedPreferences.getInstance();
          final userJson = jsonEncode(updatedUser);
          ref
              .read(userProvider.notifier)
              .recreateUserState(state: state, city: city, locality: locality);
          await preferences.setString('user', userJson);
        },
      );
    } catch (e) {
      showSnackBar(context, 'Error updating location');
    }
  }

  Future<void> deleteAccount({
    required BuildContext context,
    required String id,
    required WidgetRef ref,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      http.Response response = await http.delete(
        Uri.parse("$uri/api/user/delete-account/$id"),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          ref.read(userProvider.notifier).signOut();
          showSnackBar(context, 'Account deleted successfully');

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LoginScreen(); // Pass email to OTP screen
              },
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, "Error deleting account $e");
    }
  }
}
