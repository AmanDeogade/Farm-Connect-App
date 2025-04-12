import 'package:farmconnect/farmer_side/controllers/farmer_auth_controller.dart';
import 'package:farmconnect/farmer_side/provider/farmer_user_provider.dart';
import 'package:farmconnect/farmer_side/view/screen/nav_screen/farmer_shipping.dart';
import 'package:farmconnect/farmer_side/view/screen/two_farmer_display_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmerAccountScreen extends ConsumerStatefulWidget {
  const FarmerAccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<FarmerAccountScreen> {
  final FarmerAuthController _farmerAuthController = FarmerAuthController();

  //show signout dialog
  void showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Are you sure',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Text(
            'Do you really want to logout ?',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.montserrat(fontSize: 16, color: Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                _farmerAuthController.signOut(context: context);
              },
              child: Text(
                "Logout",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //fetch the delivered order count when the widget  build

    //watch the deliveredOrderCountProvider to reactively rebuild when state changes
    final user = ref.read(farmerUserProvider);
    //final favoriteCount = ref.read(favoriteProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 380,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    alignment: Alignment.center,
                    color: Colors.green,
                    // child: Image.network(
                    //   "https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/FBrbGWQJqIbpA5ZHEpajYAEh1V93%2Fuploads%2Fimages%2F78dbff80_1dfe_1db2_8fe9_13f5839e17c1_bg2.png?alt=media",
                    width: MediaQuery.of(context).size.width,
                    height: 351,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  Positioned(
                    top: 30,
                    right: 30,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Image.asset('assets/icons/not.png', width: 20),
                    ),
                  ),
                  Stack(
                    children: [
                      const Align(
                        alignment: Alignment(0, -0.53),
                        child: CircleAvatar(
                          radius: 65,
                          backgroundImage: NetworkImage(
                            "https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png",
                          ),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0.23, -0.61),
                        child: InkWell(
                          onTap: () {},
                          child: Image.asset(
                            'assets/icons/edit.png',
                            width: 19,
                            height: 19,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: const Alignment(0, 0.09),
                    child:
                        user != null
                            ? Text(
                              user.fullName,
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                            : Text(
                              'User',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                  ),
                  Align(
                    alignment: const Alignment(0.05, 0.27),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const FarmerShippingAddressScreen();
                            },
                          ),
                        );
                      },
                      child:
                          user != null
                              ? Text(
                                user.state,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                              : Text(
                                'States',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const TwoFarmerDisplayOrderScreen();
                    },
                  ),
                );
              },
              leading: Image.asset('assets/icons/orders.png'),
              title: Text(
                'Track your order',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const TwoFarmerDisplayOrderScreen();
                    },
                  ),
                );
              },
              leading: Image.asset('assets/icons/history.png'),
              title: Text(
                'History',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () {
                showSignOutDialog(context);
              },
              leading: Image.asset('assets/icons/logout.png'),
              title: Text(
                'Logout',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () {
                //async {
                // await _farmerAuthController.deleteAccount(
                //   context: context,
                //   id: user.id,
                //   ref: ref,
                // );
              },
              leading: Image.asset('assets/icons/help.png'),
              title: Text(
                'Delete Account',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
