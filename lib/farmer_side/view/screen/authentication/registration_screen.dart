import 'package:farmconnect/farmer_side/controllers/farmer_auth_controller.dart';
import 'package:farmconnect/farmer_side/main_farmer_screen.dart';
import 'package:farmconnect/farmer_side/view/screen/upload_lap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmerRegistrationScreen extends StatefulWidget {
  const FarmerRegistrationScreen({super.key});

  @override
  State<FarmerRegistrationScreen> createState() =>
      _FarmerRegistrationScreenState();
}

class _FarmerRegistrationScreenState extends State<FarmerRegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FarmerAuthController _vendorAuthController = FarmerAuthController();

  late String email;
  //late because value will be assigned later
  late String fullName;

  late String password;
  late String city;
  late String state;
  late String area;
  late String agromethod;
  late String description;

  bool _isLoading = false;

  registerUser() async {
    setState(() {
      _isLoading = true;
    });
    await _vendorAuthController
        .signUpFarmer(
          context: context,
          email: email,
          fullName: fullName,
          password: password,
          state: '',
          city: '',
          area: '',
          agromethod: '',
          description: '',
        )
        .whenComplete(() {
          // _formKey.currentState!.reset();
          setState(() {
            _isLoading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create Your Account",
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      letterSpacing: 0.2,
                    ),
                  ),
                  Text(
                    'To Explore the world of Farm',
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      letterSpacing: 0.2,
                    ),
                  ),
                  Image.asset(
                    'assets/images/homenew.png',
                    width: 200,
                    height: 200,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Email",
                      style: GoogleFonts.getFont(
                        'Nunito Sans',
                        fontSize: 23,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      labelText: "Enter the Email",
                      labelStyle: GoogleFonts.getFont("Nunito Sans"),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/email.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Full Name",
                      style: GoogleFonts.getFont(
                        'Nunito Sans',
                        fontSize: 23,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      fullName = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      labelText: "Enter your full name",
                      labelStyle: GoogleFonts.getFont("Nunito Sans"),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/email.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Password",
                      style: GoogleFonts.getFont(
                        'Nunito Sans',
                        fontSize: 23,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      labelText: "Enter the Password",
                      labelStyle: GoogleFonts.getFont("Nunito Sans"),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/email.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      suffixIcon: Icon(Icons.visibility),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.bottomLeft,
                  //   child: Text(
                  //     "State",
                  //     style: GoogleFonts.getFont(
                  //       'Nunito Sans',
                  //       fontSize: 23,
                  //       letterSpacing: 0.2,
                  //     ),
                  //   ),
                  // ),
                  // TextFormField(
                  //   onChanged: (value) {
                  //     state = value;
                  //   },
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter some text';
                  //     }
                  //     return null;
                  //   },
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     fillColor: Colors.white,
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(9),
                  //     ),
                  //     focusedBorder: InputBorder.none,
                  //     enabledBorder: InputBorder.none,
                  //     labelText: "Enter the state",
                  //     labelStyle: GoogleFonts.getFont("Nunito Sans"),
                  //     prefixIcon: Padding(
                  //       padding: const EdgeInsets.all(10.0),
                  //       child: Image.asset(
                  //         'assets/icons/email.png',
                  //         width: 20,
                  //         height: 20,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Align(
                  //   alignment: Alignment.bottomLeft,
                  //   child: Text(
                  //     "City",
                  //     style: GoogleFonts.getFont(
                  //       'Nunito Sans',
                  //       fontSize: 23,
                  //       letterSpacing: 0.2,
                  //     ),
                  //   ),
                  // ),
                  // TextFormField(
                  //   onChanged: (value) {
                  //     city = value;
                  //   },
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter some text';
                  //     }
                  //     return null;
                  //   },
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     fillColor: Colors.white,
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(9),
                  //     ),
                  //     focusedBorder: InputBorder.none,
                  //     enabledBorder: InputBorder.none,
                  //     labelText: "Enter the state",
                  //     labelStyle: GoogleFonts.getFont("Nunito Sans"),
                  //     prefixIcon: Padding(
                  //       padding: const EdgeInsets.all(10.0),
                  //       child: Image.asset(
                  //         'assets/icons/email.png',
                  //         width: 20,
                  //         height: 20,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Align(
                  //   alignment: Alignment.bottomLeft,
                  //   child: Text(
                  //     "Total Farm Area (in acre)",
                  //     style: GoogleFonts.getFont(
                  //       'Nunito Sans',
                  //       fontSize: 23,
                  //       letterSpacing: 0.2,
                  //     ),
                  //   ),
                  // ),
                  // TextFormField(
                  //   onChanged: (value) {
                  //     area = value;
                  //   },
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter some text';
                  //     }
                  //     return null;
                  //   },
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     fillColor: Colors.white,
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(9),
                  //     ),
                  //     focusedBorder: InputBorder.none,
                  //     enabledBorder: InputBorder.none,
                  //     labelText: "Enter the state",
                  //     labelStyle: GoogleFonts.getFont("Nunito Sans"),
                  //     prefixIcon: Padding(
                  //       padding: const EdgeInsets.all(10.0),
                  //       child: Image.asset(
                  //         'assets/icons/email.png',
                  //         width: 20,
                  //         height: 20,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Align(
                  //   alignment: Alignment.bottomLeft,
                  //   child: Text(
                  //     "About Yourself",
                  //     style: GoogleFonts.getFont(
                  //       'Nunito Sans',
                  //       fontSize: 23,
                  //       letterSpacing: 0.2,
                  //     ),
                  //   ),
                  // ),
                  // TextFormField(
                  //   onChanged: (value) {
                  //     description = value;
                  //   },
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter some text';
                  //     }
                  //     return null;
                  //   },
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     fillColor: Colors.white,
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(9),
                  //     ),
                  //     focusedBorder: InputBorder.none,
                  //     enabledBorder: InputBorder.none,
                  //     labelText: "Enter the state",
                  //     labelStyle: GoogleFonts.getFont("Nunito Sans"),
                  //     prefixIcon: Padding(
                  //       padding: const EdgeInsets.all(10.0),
                  //       child: Image.asset(
                  //         'assets/icons/email.png',
                  //         width: 20,
                  //         height: 20,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        registerUser();
                        print(email);
                        print(fullName);
                        print(password);
                      } else {
                        print('failed');
                      }
                    },
                    child: Container(
                      width: 319,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromARGB(255, 53, 18, 231),
                            const Color.fromARGB(255, 90, 70, 189),
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 278,
                            top: 19,
                            child: Opacity(
                              opacity: 0.5,
                              child: Container(
                                width: 60,
                                height: 60,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 12,
                                    color: Colors.blue,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 260,
                            top: 29,
                            child: Opacity(
                              opacity: 0.5,
                              child: Container(
                                width: 10,
                                height: 10,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 3),
                                  color: Colors.deepPurpleAccent,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 311,
                            top: 36,
                            child: Opacity(
                              opacity: 0.3,
                              child: Container(
                                width: 5,
                                height: 5,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 281,
                            top: -10,
                            child: Opacity(
                              opacity: 0.3,
                              child: Container(
                                width: 20,
                                height: 20,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child:
                                _isLoading
                                    ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    : Text(
                                      'Sign Up',
                                      style: GoogleFonts.getFont(
                                        'Lato',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Alraedy have an Account?',
                        style: GoogleFonts.getFont(
                          'Roboto',
                          letterSpacing: 1,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainFarmerScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.getFont(
                            'Roboto',
                            letterSpacing: 1,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
