import 'package:farmconnect/customer_side/controllers/farmer_controller.dart';
import 'package:farmconnect/customer_side/provider/farmers_detals.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/widgets/farmer_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmerNearBy extends ConsumerStatefulWidget {
  const FarmerNearBy({super.key});

  @override
  ConsumerState<FarmerNearBy> createState() => _PopularProductWidgetState();
}

class _PopularProductWidgetState extends ConsumerState<FarmerNearBy> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    final farmerDetail = ref.read(farmerDetailsProvider);
    if (farmerDetail.isEmpty) {
      _fetchFarmers();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchFarmers() async {
    final FarmerController farmercontroller = FarmerController();
    try {
      final farmers = await farmercontroller.loadFarmer();
      ref.read(farmerDetailsProvider.notifier).setFarmers(farmers);
    } catch (e) {
      print("$e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final farmers = ref.watch(farmerDetailsProvider);
    return SizedBox(
      height: 230,
      child:
          isLoading
              ? const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              )
              : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: farmers.length,
                itemBuilder: (context, index) {
                  final farmer = farmers[index];
                  return FarmerDetails(farmer: farmer);
                  //FarmerDetails(product: product);
                },
              ),
    );
  }
}
