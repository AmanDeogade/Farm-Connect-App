import 'package:farmconnect/customer_side/models/order.dart';
import 'package:farmconnect/customer_side/view/screen/details/order_detail_screen.dart';
import 'package:farmconnect/farmer_side/controllers/farmer_order_controller.dart';
import 'package:farmconnect/farmer_side/provider/farmer_order_provider.dart';
import 'package:farmconnect/farmer_side/provider/farmer_user_provider.dart';
import 'package:farmconnect/farmer_side/view/screen/nav_screen/farmer_order_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmerDisplayOrderScreen extends ConsumerStatefulWidget {
  const FarmerDisplayOrderScreen({super.key});

  @override
  ConsumerState<FarmerDisplayOrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<FarmerDisplayOrderScreen> {
  @override
  void initState() {
    print("Click");
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    final farmerUser = ref.read(farmerUserProvider);
    //final user = ref.watch(userProvider);
    print("User: $farmerUser"); // Check if the user is fetched correctly
    print("User ID: ${farmerUser?.id}");

    if (farmerUser == null) {
      print("User not available yet. Waiting...");
      return; // Exit early if user is null
    }

    if (farmerUser != null) {
      final FarmerOrderController farmerOrderController =
          FarmerOrderController();
      try {
        print("Fetching orders");
        final orders = await farmerOrderController.loadFarmerOrders(
          farmerId: farmerUser.id,
        );
        print(
          "Orders fetched: $orders",
        ); // Ensure the orders are being fetched correctly
        ref.read(farmerOrderProvider.notifier).setFarmerOrders(orders);
      } catch (e) {
        print('Error fetching orders: $e');
      }
    }
  }

  Future<void> _deleteOrder(String orderId) async {
    final FarmerOrderController farmerOrderController = FarmerOrderController();
    try {
      await farmerOrderController.deleteOrder(id: orderId, context: context);
      _fetchOrders(); //Refresh the list after deletion
    } catch (e) {
      print("error deleting orer : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final farmerOrders = ref.watch(farmerOrderProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.20,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 118,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(color: Colors.green),
          child: Stack(
            children: [
              Positioned(
                left: 322,
                top: 52,
                child: Stack(
                  children: [
                    Image.asset('assets/icons/not.png', width: 25, height: 25),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade800,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            farmerOrders.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Positioned(
              //   left: 10,
              //   top: 51,
              //   child: IconButton(
              //     icon: const Icon(Icons.arrow_back, color: Colors.white),
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //   ),
              // ),
              Positioned(
                left: 91,
                top: 51,
                child: Text(
                  'My Orders',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body:
          farmerOrders.isEmpty
              ? const Center(child: Text('No Order Found'))
              : ListView.builder(
                itemCount: farmerOrders.length,
                itemBuilder: (context, index) {
                  final Order order = farmerOrders[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 25,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return FarmerOrderDetailScreen(
                                farmerOrder: order,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: 335,
                        height: 153,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: SizedBox(
                          width: double.infinity,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 336,
                                  height: 154,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color(0xFFEFF0F2),
                                    ),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        left: 13,
                                        top: 9,
                                        child: Container(
                                          width: 78,
                                          height: 78,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFBCC5FF),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                left: 10,
                                                top: 5,
                                                child: Image.network(
                                                  order.image,
                                                  width: 58,
                                                  height: 67,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 101,
                                        top: 14,
                                        child: SizedBox(
                                          width: 216,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Text(
                                                          order.productName,
                                                          style:
                                                              GoogleFonts.montserrat(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16,
                                                              ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Align(
                                                        alignment:
                                                            Alignment
                                                                .centerLeft,
                                                        child: Text(
                                                          order.category,
                                                          style:
                                                              GoogleFonts.montserrat(
                                                                color:
                                                                    const Color(
                                                                      0xFF7F808C,
                                                                    ),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 12,
                                                              ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        "\$${order.productPrice.toStringAsFixed(2)}",
                                                        style:
                                                            GoogleFonts.montserrat(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  const Color(
                                                                    0xFF0B0C1E,
                                                                  ),
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 13,
                                        top: 113,
                                        child: Container(
                                          width: 100,
                                          height: 25,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            color:
                                                order.delivered == true
                                                    ? const Color(0xFF3C55EF)
                                                    : order.processing == true
                                                    ? Colors.purple
                                                    : Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                left: 9,
                                                top: 2,
                                                child: Text(
                                                  order.delivered == true
                                                      ? "Delivered"
                                                      : order.processing == true
                                                      ? "Processing"
                                                      : "Cancelled",
                                                  style: GoogleFonts.montserrat(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.3,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      order.delivered == true
                                          ? Positioned(
                                            top: 115,
                                            left: 298,
                                            child: InkWell(
                                              onTap: () {
                                                _deleteOrder(order.id);
                                              },
                                              child: Image.asset(
                                                'assets/icons/delete.png',
                                                width: 20,
                                                height: 20,
                                              ),
                                            ),
                                          )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
