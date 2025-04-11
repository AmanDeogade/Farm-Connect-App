import 'package:farmconnect/farmer_side/view/screen/earning_screen.dart';
import 'package:farmconnect/farmer_side/view/screen/farmer_account_screen.dart';
import 'package:farmconnect/farmer_side/view/screen/farmer_display_orders_screen.dart';
import 'package:farmconnect/farmer_side/view/screen/upload_lap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainFarmerScreen extends StatefulWidget {
  const MainFarmerScreen({Key? key}) : super(key: key);

  @override
  State<MainFarmerScreen> createState() => _MainFarmerScreenState();
}

class _MainFarmerScreenState extends State<MainFarmerScreen> {
  int _pageIndex = 0;
  final List<Widget> _pages = [
    EarningScreen(),
    UploadScreenLap(),
    FarmerDisplayOrderScreen(),
    FarmerAccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(CupertinoIcons.money_dollar),
            label: "Earnings",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.upload_circle),
            label: "Upload",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
