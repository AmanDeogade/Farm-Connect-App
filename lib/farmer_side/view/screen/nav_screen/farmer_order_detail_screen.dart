import 'package:farmconnect/customer_side/models/order.dart';
import 'package:farmconnect/farmer_side/controllers/farmer_order_controller.dart';
import 'package:farmconnect/farmer_side/provider/farmer_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmerOrderDetailScreen extends ConsumerStatefulWidget {
  final Order farmerOrder;

  const FarmerOrderDetailScreen({super.key, required this.farmerOrder});

  @override
  ConsumerState<FarmerOrderDetailScreen> createState() =>
      _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<FarmerOrderDetailScreen> {
  final TextEditingController _reviewController = TextEditingController();

  double rating = 0.0;
  FarmerOrderController orderController = FarmerOrderController();

  //final ProductReviewController _productReviewController =
  // ProductReviewController();

  @override
  Widget build(BuildContext context) {
    final farmerOrder = ref.watch(farmerOrderProvider);
    final updatedOrder = farmerOrder.firstWhere(
      (o) => o.id == widget.farmerOrder.id,
      orElse: () => widget.farmerOrder,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.farmerOrder.productName,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
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
                        border: Border.all(color: const Color(0xFFEFF0F2)),
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
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    left: 10,
                                    top: 5,
                                    child: Image.network(
                                      widget.farmerOrder.image,
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
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              widget.farmerOrder.productName,
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              widget.farmerOrder.category,
                                              style: GoogleFonts.montserrat(
                                                color: const Color(0xFF7F808C),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            "\$${widget.farmerOrder.productPrice.toStringAsFixed(2)}",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF0B0C1E),
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
                                    updatedOrder.delivered == true
                                        ? const Color(0xFF3C55EF)
                                        : updatedOrder.processing == true
                                        ? Colors.purple
                                        : Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    left: 9,
                                    top: 2,
                                    child: Text(
                                      updatedOrder.delivered == true
                                          ? "Delivered"
                                          : updatedOrder.processing == true
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
                          Positioned(
                            top: 115,
                            left: 298,
                            child: InkWell(
                              onTap: () {},
                              child: Image.asset(
                                'assets/icons/delete.png',
                                width: 20,
                                height: 20,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              width: 336,
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFEFF0F2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery Address',
                          style: GoogleFonts.montserrat(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.7,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${widget.farmerOrder.state} ${widget.farmerOrder.city} ${widget.farmerOrder.locality}",
                          style: GoogleFonts.lato(
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "To : ${widget.farmerOrder.fullName}",
                          style: GoogleFonts.roboto(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Order Id: ${widget.farmerOrder.id}",
                          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed:
                            updatedOrder.delivered == true ||
                                    updatedOrder.processing == false
                                ? null
                                : () async {
                                  await orderController
                                      .updateDeliveryStatus(
                                        id: widget.farmerOrder.id,
                                        context: context,
                                      )
                                      .whenComplete(() {
                                        ref
                                            .read(farmerOrderProvider.notifier)
                                            .updateOrderStatus(
                                              widget.farmerOrder.id,
                                              delivered: true,
                                            );
                                      });
                                },
                        child: Text(
                          updatedOrder.delivered == true
                              ? 'Delivered'
                              : 'Mark as Delivered?',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed:
                            updatedOrder.delivered == true ||
                                    updatedOrder.processing == true
                                ? null
                                : () async {
                                  await orderController
                                      .cancelOrder(
                                        id: widget.farmerOrder.id,
                                        context: context,
                                      )
                                      .whenComplete(() {
                                        ref
                                            .read(farmerOrderProvider.notifier)
                                            .updateOrderStatus(
                                              widget.farmerOrder.id,
                                              processing: false,
                                            );
                                      });
                                },
                        child: Text(
                          updatedOrder.delivered == true ? '' : 'Cancel',
                          style: GoogleFonts.montserrat(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
