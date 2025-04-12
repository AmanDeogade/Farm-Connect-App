import 'package:farmconnect/farmer_side/controllers/farmer_order_controller.dart';
import 'package:farmconnect/farmer_side/provider/farmer_order_provider.dart';
import 'package:farmconnect/farmer_side/provider/farmer_user_provider.dart';
import 'package:farmconnect/farmer_side/provider/total_earning_provider.dart';
import 'package:farmconnect/farmer_side/provider/total_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class EarningScreen extends ConsumerStatefulWidget {
  const EarningScreen({super.key});

  @override
  ConsumerState<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends ConsumerState<EarningScreen> {
  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    final farmerUser = ref.read(farmerUserProvider);

    if (farmerUser == null) {
      return; // Exit early if user is null
    }

    if (farmerUser != null) {
      final FarmerOrderController farmerOrderController =
          FarmerOrderController();
      try {
        final farmerOrders = await farmerOrderController.loadFarmerOrders(
          farmerId: farmerUser.id,
        );
        ref.read(farmerOrderProvider.notifier).setFarmerOrders(farmerOrders);
        ref.read(totalEarningProvider.notifier).calculateEarning(farmerOrders);
        ref.read(totalProductCount.notifier).countProduct(farmerOrders);
      } catch (e) {
        //'Error fetching orders: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _fetchOrders;
    var firstchar = "F";
    var fullName = "Farmer";
    final vendor = ref.watch(farmerUserProvider);
    final totalEarning = ref.watch(totalEarningProvider);
    final totalProduct = ref.watch(totalProductCount);
    if (vendor != null) {
      firstchar = vendor.fullName[0];
      fullName = vendor.fullName;
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.purple,
              child: Text(
                firstchar,
                //vendor!.fullName[0].toUpperCase(),
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 250, //for lengthy name
              child: Text(
                //"Welcome! ${fullName}",
                "Welcome! ${fullName}",
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Total Earning",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              totalEarning == null
                  ? CircularProgressIndicator(color: Colors.green)
                  : Text(
                    "Rs. ${totalEarning.toStringAsFixed(2)}",
                    style: GoogleFonts.montserrat(
                      fontSize: 36,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

              Text(
                "Total Orders Delivered",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              totalProduct == null
                  ? CircularProgressIndicator(color: Colors.green)
                  : Text(
                    "$totalProduct",
                    style: GoogleFonts.montserrat(
                      fontSize: 36,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
