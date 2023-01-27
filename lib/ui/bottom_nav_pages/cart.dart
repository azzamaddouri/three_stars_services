import 'package:flutter/material.dart';

import 'package:three_stars_services/ui/bottom_nav_pages/settings.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SettingsScreen() //fetchData("users-cart-items"),
          ),
    );
  }
}
