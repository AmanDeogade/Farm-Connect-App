import 'package:farmconnect/customer_side/models/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TotalProductProvider extends StateNotifier<int> {
  //constructor that initialize the state with 0.0(starting total earning)
  TotalProductProvider() : super(0);

  //method to update the total earning based on delivered status

  void countProduct(List<Order> orders) {
    //initialize a local variable to accumulate the total earning
    int totalProduct = 0;

    for (Order order in orders) {
      if (order.delivered) {
        totalProduct++;
      }
    }
    state = totalProduct;
  }
}

final totalProductCount = StateNotifierProvider<TotalProductProvider, int>((
  ref,
) {
  return TotalProductProvider();
});
