import 'package:farmconnect/customer_side/view/screen/nav_screen/account_screen.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/cart_screen.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/home_screen.dart';
import 'package:farmconnect/customer_side/view/screen/nav_screen/category_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    // FavouriteScreen(),
    CategoryScreen(),
    //StoresScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _pageIndex,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/home.png", width: 25),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category, size: 25),
            label: "Categories",
          ),
          // BottomNavigationBarItem(
          //   icon: Image.asset("assets/icons/mart.png", width: 25),
          //   label: "Stores",
          // ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/cart.png", width: 25),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/user.png", width: 25),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
