import 'dart:convert';
import 'package:farmconnect/customer_side/services/manage_http_response.dart';
import 'package:farmconnect/farmer_side/main_farmer_screen.dart';
import 'package:farmconnect/farmer_side/models/farmer_user.dart';
import 'package:farmconnect/farmer_side/provider/farmer_user_provider.dart';
import 'package:farmconnect/farmer_side/view/screen/upload_lap.dart';
import 'package:farmconnect/global_variable.dart';
import 'package:farmconnect/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final providerContainer = ProviderContainer();

class FarmerAuthController {
  Future<void> signUpFarmer({
    required String fullName,
    required String email,
    required String password,
    required String state,
    required String city,
    required String area,
    required String agromethod,
    required String description,
    required context,
  }) async {
    try {
      FarmerUser farmer = FarmerUser(
        id: '',
        fullName: fullName,
        email: email,
        state: state,
        city: city,
        locality: '',
        password: password,
        area: area,
        agromethod: agromethod,
        description: description,
        profileImage: '',
        role: '',
      );

      print(fullName);
      print(email);
      print(password);

      String farmerJson = farmer.toJson();
      print(
        'Sending sign-up request with the following data: $farmerJson',
      ); // Debugging the request

      // Send the sign-up request
      http.Response response = await http.post(
        Uri.parse("$uri/api/farmer/signup"),
        body: farmerJson, // JSON-encoded body
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      print(
        'Response Status Code: ${response.statusCode}',
      ); // Debugging response status
      print('Response Body: ${response.body}'); // Debugging response body

      if (response.statusCode == 200) {
        // Check if the response is successful
        manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Vendor Account Created');
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainFarmerScreen()),
              (route) => false,
            );
          },
        );
      } else if (response.statusCode == 400) {
        // If the response status code is not 200 (OK), log the error message.
        print('Vendor with this email already exists: ${response.body}');
        showSnackBar(context, 'Farmer with this email already exists');
      } else {
        // If the response status code is not 200 (OK), log the error message.
        print('Failed to create farmer account. Response: ${response.body}');
        showSnackBar(
          context,
          'Failed to create Farmer account. Please try again.',
        );
      }
    } catch (e) {
      // Catch any unexpected errors (network issues, JSON issues, etc.)
      print('Error during sign up: $e');
      showSnackBar(context, 'Error during sign up: $e');
    }
  }

  Future<void> signInFarmer({
    required String email,
    required String password,
    required context,
  }) async {
    print(email);
    print(password);
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/farmer/signin"),
        body: jsonEncode({
          "email": email,
          "password": password,
        }), // Encode JSON correctly
        headers: {"Content-Type": 'application/json; charset=UTF-8'},
      );
      print(response.body);

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          //Extract the authentication token from the response body
          String token = jsonDecode(response.body)['token'];
          //Store the authentication token in shared preferences
          await preferences.setString('auth_token', token);
          //Encode the user data received from the backend as json

          final vendorJson = jsonEncode(jsonDecode(response.body)['farmer']);

          //update the application state with the user data using riverpod
          providerContainer
              .read(farmerUserProvider.notifier)
              .setFarmer(vendorJson);

          await preferences.setString('farmer', vendorJson);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainFarmerScreen()),
            (route) => false,
          );
          showSnackBar(context, 'Farmer Signed In');
        },
      );
    } catch (e) {
      print(e);
      showSnackBar(context, 'Error: $e');
    }
  }

  Future<void> signOut({required context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      //clear the token and user from shared preference
      // await preferences.remove(
      //   'auth_token',
      // ); //clear auth token(); //clear all data from shared preferences
      await preferences.remove('farmer');
      //clear  user state
      providerContainer
          .read(farmerUserProvider.notifier)
          .signOut(); //sign out user
      //navigate user back to login screen

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => ClassSelectionScreen()),
        (route) => false,
      ); //navigate to login screen
      showSnackBar(context, 'Signout Successfully');
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<void> updateFarmerLocation({
    required BuildContext context,
    required String id,
    required String state,
    required String city,
    required String locality,
    required WidgetRef ref,
  }) async {
    try {
      //Make an HTTP PUT request to update user's state, city and locality
      final http.Response response = await http.put(
        Uri.parse('$uri/api/farmer/$id'),
        //set the header for the request to specify   that the content  is Json
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
          //Decode the updated user data from the response body
          //this converts the json String response into Dart Map
          final updatedUser = jsonDecode(response.body);
          //Access Shared preference for local data storage
          //shared preferences allow us to store data persisitently on the the device
          SharedPreferences preferences = await SharedPreferences.getInstance();
          //Encode the update user data as json String
          //this prepares the data for storage in shared preference
          final userJson = jsonEncode(updatedUser);

          //update the application state with the updated user data  using Riverpod
          //this ensures the app reflects the most recent user data
          //ref.read(userProvider.notifier).setUser(userJson);
          ref
              .read(farmerUserProvider.notifier)
              .recreateFarmerState(
                state: state,
                city: city,
                locality: locality,
              );

          //store the updated user data in shared preference  for future user
          //this allows the app to retrive the user data  even after the app restarts
          await preferences.setString('user', userJson);
        },
      );
    } catch (e) {
      //catch any error that occure during the proccess
      //show an error message to the user if the update fails
      showSnackBar(context, 'Error updating location');
    }
  }

  // Future<void> deleteAccount({
  //   required BuildContext context,
  //   required String id,
  //   required WidgetRef ref, // Access to the Riverpod Provider
  // }) async {
  //   try {
  //     //Get the authentication token from  shared preferences  for authorization
  //     SharedPreferences preferences = await SharedPreferences.getInstance();

  //     // String? token = preferences.getString('auth_token');

  //     // if (token == null) {
  //     //   showSnackBar(context, 'You need  to log in to perform  this action');
  //     //   return;
  //     // }

  //     //Send DELETE REQUEST TO THE BACKEND API

  //     http.Response response = await http.delete(
  //       Uri.parse("$uri/api/user/delete-account/$id"),
  //       headers: <String, String>{
  //         "Content-Type": 'application/json; charset=UTF-8',
  //         // 'x-auth-token': token,
  //       },
  //     );

  //     manageHttpResponse(
  //       response: response,
  //       context: context,
  //       onSuccess: () async {
  //         //handle successfull deletion , navigate the  user  back to the login screen

  //         //clear user data from sharedPreferences
  //         // await preferences.remove('auth_token');

  //         // await preferences.remove('user');

  //         //clear the user data from the provider  state
  //         ref.read(vendorProvider.notifier).signOut();

  //         //Redirect to the login screen after succesful deletion

  //         showSnackBar(context, 'Account deleted successfully');

  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) {
  //               return const LoginScreen(); // Pass email to OTP screen
  //             },
  //           ),
  //           (route) => false,
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, "Error deleting account $e");
  //   }
  // }
}
