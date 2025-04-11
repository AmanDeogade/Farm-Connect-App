import 'package:farmconnect/customer_side/models/farmer.dart';
import 'package:farmconnect/farmer_side/models/farmer_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//StateNotifier: StateNotifier is a class provided by Riverpod package that helps in
//managing the state, it is also designed to notify listeners about the state changes
class FarmerVendorProvider extends StateNotifier<FarmerUser?> {
  FarmerVendorProvider.FarmerUserProvider()
    : super(
        FarmerUser(
          id: '',
          fullName: '',
          email: '',
          state: '',
          city: '',
          locality: '',
          password: '',
          area: '',
          agromethod: '',
          description: '',
          profileImage: '',
          role: '',
        ),
      );

  //Getter Method to extract value from an object
  FarmerUser? get vendor => state;

  //Method to set vendor user from json
  //purpose : update the user state based on json String representation of the vendor object

  void setFarmer(String vendorJson) {
    state = FarmerUser.fromJson(vendorJson);
  }

  //method to clear the vendor user state
  void signOut() {
    state = null;
  }

  void recreateFarmerState({
    required String state,
    required String city,
    required String locality,
  }) {
    if (this.state != null) {
      this.state = FarmerUser(
        id: this.state!.id,
        fullName: this.state!.fullName,
        email: this.state!.email,
        state: state,
        city: city,
        locality: locality,
        password: this.state!.password,
        agromethod: '',
        description: '',
        profileImage: '',
        area: '',
        role: '',
      );
    }
  }
}

//make the data accessible within the application
final farmerUserProvider =
    StateNotifierProvider<FarmerVendorProvider, FarmerUser?>((ref) {
      return FarmerVendorProvider.FarmerUserProvider();
    });
