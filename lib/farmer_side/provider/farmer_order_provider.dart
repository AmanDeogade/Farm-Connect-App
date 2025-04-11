import 'package:farmconnect/customer_side/models/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmerOrderProvider extends StateNotifier<List<Order>> {
  FarmerOrderProvider() : super([]);

  //set the list of Orders
  void setFarmerOrders(List<Order> farmerOrders) {
    state = farmerOrders;
  }

  void updateOrderStatus(String orderId, {bool? processing, bool? delivered}) {
    state = [
      for (final order in state)
        if (order.id == orderId)
          Order(
            id: order.id,
            fullName: order.fullName,
            email: order.email,
            state: order.state,
            city: order.city,
            locality: order.locality,
            productName: order.productName,
            productPrice: order.productPrice,
            quantity: order.quantity,
            category: order.category,
            image: order.image,
            buyerId: order.buyerId,
            //use the new processing and delivered values
            processing: processing ?? order.processing,
            delivered: delivered ?? order.delivered,
            paymentStatus: order.paymentStatus,
            paymentIntentId: order.paymentIntentId,
            paymentMethod: order.paymentMethod,
            farmerId: order.farmerId,
          )
        else
          order,
    ];
  }
}

final farmerOrderProvider =
    StateNotifierProvider<FarmerOrderProvider, List<Order>>((ref) {
      return FarmerOrderProvider();
    });
