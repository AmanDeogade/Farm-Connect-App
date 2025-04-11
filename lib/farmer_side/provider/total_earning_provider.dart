import 'package:farmconnect/customer_side/models/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TotalEarningProvider extends StateNotifier<double> {
  //constructor that initialize the state with 0.0(starting total earning)
  TotalEarningProvider() : super(0.0);

  //method to update the total earning based on delivered status

  void calculateEarning(List<Order> orders) {
    //initialize a local variable to accumulate the total earning
    double earnings = 0.0;

    for (Order order in orders) {
      if (order.delivered) {
        earnings += order.productPrice * order.quantity;
      }
    }
    state = earnings;
  }
}

final totalEarningProvider =
    StateNotifierProvider<TotalEarningProvider, double>((ref) {
      return TotalEarningProvider();
    });
