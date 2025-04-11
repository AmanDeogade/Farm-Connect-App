import 'package:farmconnect/customer_side/models/farmer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmerDetailsProvider extends StateNotifier<List<Farmer>> {
  FarmerDetailsProvider() : super([]);

  // Set the list of farmers
  void setFarmers(List<Farmer> farmers) {
    state = farmers;
  }

  // You can also add other methods to interact with the farmer list (e.g., add a farmer, remove a farmer, etc.)
}

final farmerDetailsProvider =
    StateNotifierProvider<FarmerDetailsProvider, List<Farmer>>((ref) {
      return FarmerDetailsProvider();
    });
