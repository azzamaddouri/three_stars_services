import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:three_stars_services/ui/claim_form.dart';
import 'package:three_stars_services/widgets/fetchProducts.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ClaimForm() //fetchData("users-favourite-items"),
          ),
    );
  }
}
