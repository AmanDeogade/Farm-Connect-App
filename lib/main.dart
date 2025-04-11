import 'package:farmconnect/Customer_Side/view/screen/authentication_screen/login_screen.dart';
import 'package:farmconnect/farmer_side/main_farmer_screen.dart';
import 'package:farmconnect/farmer_side/provider/farmer_user_provider.dart';
import 'package:farmconnect/farmer_side/view/screen/authentication/login_screen.dart';
import 'package:farmconnect/farmer_side/view/screen/upload_lap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:farmconnect/Customer_Side/view/screen/authentication_screen/registration_screen.dart';
import 'package:farmconnect/customer_side/provider/user_provider.dart';
import 'package:farmconnect/customer_side/view/screen/main_screen.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  //Run the flutter app in providerscope for managing state
  runApp(ProviderScope(child: const MyApp()));
}

class ClassSelectionScreen extends StatelessWidget {
  const ClassSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset('assets/images/logo_home.png'),
              ),
              Text(
                "Login as",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.person, color: Colors.white),
                label: Text(
                  "Consumer",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 21, 141, 27),
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.agriculture, color: Colors.white),
                label: Text(
                  "Farmer",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 21, 141, 27),
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FarmerLoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  //Method to check the token and set the user data if available
  Future<void> _checkTokenAndSetUser(WidgetRef ref) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    // Retrieve auth token and user JSON
    String? token = preferences.getString('auth_token');
    String? userJson = preferences.getString('user');
    String? farmerJson = preferences.getString('farmer');

    // Debug logs to check stored values
    print("Stored Token: $token");
    print("Stored User JSON: $userJson");
    print("Stored Farmer JSON: $farmerJson");

    if (userJson != null) {
      try {
        ref.read(userProvider.notifier).setUser(userJson);
      } catch (e) {
        print("Error setting user from JSON: $e");
      }
    } else {
      ref.read(userProvider.notifier).signOut();
    }
    if (farmerJson != null) {
      try {
        ref.read(farmerUserProvider.notifier).setFarmer(farmerJson);
      } catch (e) {
        print("Error setting user from JSON: $e");
      }
    } else {
      ref.read(farmerUserProvider.notifier).signOut();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return Center(
      child: SizedBox(
        width: 400,
        height: 730,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FarmConnect',
          theme: ThemeData(
            scaffoldBackgroundColor:
                Colors.white, // 👈 sets white background everywhere

            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: FutureBuilder(
            future: _checkTokenAndSetUser(ref),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final user = ref.watch(userProvider);
              final farmerUser = ref.watch(farmerUserProvider);

              print("Farmer Login Hai ${farmerUser}");

              // return FarmerLoginScreen();
              if (user != null) {
                return MainScreen();
              } else if (farmerUser != null && farmerUser.fullName.isNotEmpty) {
                return MainFarmerScreen();
              } else {
                return const ClassSelectionScreen();
              }
              // return user == null
              //     ? farmerUser!.fullName == ""
              //         ? ClassSelectionScreen()
              //         : FarmerLoginScreen()
              //     : MainScreen();
            },
          ),
        ),
      ),
    );
  }
}

//Root widget of the application a consumer widget to consume state change
