import 'package:farmconnect/customer_side/view/screen/nav_screen/widgets/category_item_widget.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/widgets/farmers_nearby.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/widgets/header_widget.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/widgets/popular_product_widget.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/widgets/reusable_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.20,
        ),
        child: const HeaderWidgets(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //HeaderWidgets(),
            // BannerWidget(),
            ReusableWidget(title: 'Categories', subtitle: 'View All'),
            CategoryItemWidget(),
            ReusableWidget(title: 'Our Farmers', subtitle: 'View All'),
            FarmerNearBy(),
            ReusableWidget(title: 'Popular Products', subtitle: 'View All'),
            PopularProductWidget(),
          ],
        ),
      ),
    );
  }
}
