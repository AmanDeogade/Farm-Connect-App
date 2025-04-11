import 'package:farmconnect/customer_side/models/subcategory.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubCategoryProvider extends StateNotifier<List<Subcategory>> {
  SubCategoryProvider() : super([]);
  //set the list of categories
  void setSubCategories(List<Subcategory> categories) {
    state = categories;
  }
}

final subcategoryProvider =
    StateNotifierProvider<SubCategoryProvider, List<Subcategory>>((ref) {
      return SubCategoryProvider();
    });
