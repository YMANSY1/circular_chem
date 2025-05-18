import 'package:circular_chem_app/features/marketplace/screens/cart_screen.dart';
import 'package:circular_chem_app/features/marketplace/screens/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/auth/screens/profile_screen.dart';
import '../features/marketplace/screens/marketplace_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Manage the selected index
  int _selectedIndex = 0;

  // Use an observable for dynamic app bar title
  final titleText = 'Welcome to CircularChem!'.obs;

  @override
  Widget build(BuildContext context) {
    // Define the pages based on the selected index
    final List<Widget> _pages = <Widget>[
      MarketplacePage(),
      OrdersPage(),
      ProfileScreen(),
      CartScreen(),
    ];

    // Handle bottom navigation item taps
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
        switch (index) {
          case 0:
            titleText.value = 'Welcome to CircularChem!';
            break;
          case 1:
            titleText.value = 'Your Orders';
            break;
          case 2:
            titleText.value = 'Profile';
            break;
          case 3:
            titleText.value = 'Your Cart';
            break;
          default:
            titleText.value = 'Welcome to CircularChem!';
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Obx(() => Text(titleText.value)),
      ),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // Customize color
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped, // Switch pages
      ),
    );
  }
}
