import 'package:farmconnect/customer_side/controllers/auth_controller.dart';
import 'package:farmconnect/customer_side/provider/user_provider.dart';
import 'package:farmconnect/farmer_side/controllers/farmer_auth_controller.dart';
import 'package:farmconnect/farmer_side/provider/farmer_user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmerShippingAddressScreen extends ConsumerStatefulWidget {
  const FarmerShippingAddressScreen({super.key});

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState
    extends ConsumerState<FarmerShippingAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FarmerAuthController _authController = FarmerAuthController();
  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _localityController;

  @override
  void initState() {
    super.initState();
    //Read the current user data from the provider
    final farmerUser = ref.read(farmerUserProvider);

    //Initialize the controllers with the current data if available
    // if user data  is not available , initialize with an empty String
    _stateController = TextEditingController(text: farmerUser?.state ?? "");
    _cityController = TextEditingController(text: farmerUser?.city ?? "");
    _localityController = TextEditingController(
      text: farmerUser?.locality ?? "",
    );
  }

  //Show Loading Dialog
  _showLoadingDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 20),
                Text(
                  'Updating...',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final farmerUser = ref.read(farmerUserProvider);
    final udpdateFarmerUser = ref.read(farmerUserProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.96),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        elevation: 0,
        title: Text(
          'Delivery',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            letterSpacing: 1.7,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'where will your order\n be shipped',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    letterSpacing: 1.7,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(
                  controller: _stateController,

                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter state";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(labelText: 'State'),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _cityController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter city";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(labelText: 'City'),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _localityController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter Locality";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(labelText: 'Locality'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              _showLoadingDialog();
              //'Valid');
              //_stateController.text);

              await _authController
                  .updateFarmerLocation(
                    context: context,
                    id: farmerUser!.id,
                    state: _stateController.text,
                    city: _cityController.text,
                    locality: _localityController.text,
                    ref: ref,
                  )
                  .whenComplete(() {
                    udpdateFarmerUser.recreateFarmerState(
                      state: _stateController.text,
                      city: _cityController.text,
                      locality: _localityController.text,
                    );
                    Navigator.pop(context);

                    ///this will close the Dialog
                    Navigator.pop(
                      context,
                    ); // this will close the shipping screen meaning it will take us back to the formal which is the checkout
                  });
            } else {
              //'Not valid');
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF3854EE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Save ',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
