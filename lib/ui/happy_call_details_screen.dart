// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields, prefer_typing_uninitialized_variables, avoid_function_literals_in_foreach_calls, prefer_const_constructors, avoid_print, non_constant_identifier_names, must_be_immutable, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/bottom_nav_controller.dart';
import 'package:three_stars_services/ui/bottom_nav_pages/happy-calls.dart';

class HappyCallDetails extends StatefulWidget {
  var _claim;

  HappyCallDetails(this._claim, {Key? key}) : super(key: key);

  @override
  State<HappyCallDetails> createState() => _HappyCallDetailsState();
}

class _HappyCallDetailsState extends State<HappyCallDetails> {
  TextEditingController _breakdowntypeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _breakdownController = TextEditingController();
  TextEditingController _sparepartController = TextEditingController();

  TextEditingController _productstateController = TextEditingController();
  double ratingproduct = 0;
  double ratingservices = 0;
  double ratingbehavior = 0;
  double ratingus = 0;
  int _groupValue = -1;

  TextEditingController _ratingpunctualityController = TextEditingController();
  TextEditingController _suggestionsController = TextEditingController();

  List _happycall = [];

  bool visible = false;
  bool visible1 = false;
  bool visible2 = true;
  fetchHappyCall() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    _happycall.clear();
    QuerySnapshot qn =
        await _firestoreInstance.collection("happy-calls-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (qn.docs[i].id == widget._claim["Id"]) {
          _happycall.add({
            "Behavior-review": qn.docs[i]["Behavior-review"],
            "Product-review": qn.docs[i]["Product-review"],
            "Service-review": qn.docs[i]["Service-review"],
            "Rating": qn.docs[i]["Rating"],
            "Punctuality": qn.docs[i]["Punctuality"],
            "Suggestions": qn.docs[i]["Suggestions"]
          });
        }
      }
    });
    return qn.docs;
  }

  Future addHappyCallToDB() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("happy-calls-data");
    return _collectionRef.doc(widget._claim["Id"]).set({
      "Behavior-review": ratingbehavior,
      "Product-review": ratingproduct,
      "Service-review": ratingservices,
      "Rating": ratingus,
      "Punctuality": _ratingpunctualityController.text,
      "Suggestions": _suggestionsController.text
    }).then((value) {
      final snackBar1 = SnackBar(
        content: Text("Happy call done successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
      Navigator.push(context, MaterialPageRoute(builder: (_) => HappyCalls()));
    }).catchError((error) => print("something is wrong. $error"));
  }

  @override
  void initState() {
    fetchHappyCall();
    super.initState();
  }

//Starts from here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  color: AppColors.deep_orange,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
            child: Column(children: [
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      visible = true;
                      visible1 = false;
                      visible2 = false;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            //<-- SEE HERE
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(0, 2),
                            blurRadius: 5.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    height: 60.h,
                    width: 65.h,
                    child: const Center(
                      child: Icon(
                        Icons.home_outlined,
                        color: AppColors.deep_orange,
                      ),
                    ),
                  )),
              //2
              GestureDetector(
                  onTap: () {
                    setState(() {
                      visible1 = true;
                      visible = false;

                      visible2 = false;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 103, right: 80),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            //<-- SEE HERE
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(0, 2),
                            blurRadius: 5.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    height: 60.h,
                    width: 65.h,
                    child: const Center(
                      child: Icon(
                        Icons.add_reaction_outlined,
                        color: AppColors.deep_orange,
                      ),
                    ),
                  )),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      visible = false;
                      visible1 = false;
                      visible2 = true;
                    });
                    //Navigator.push(context,
                    //MaterialPageRoute(builder: (_) => FilterScreen()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 5),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            //<-- SEE HERE
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(0, 2),
                            blurRadius: 5.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    height: 60.h,
                    width: 65.h,
                    child: const Center(
                      child: Icon(
                        Icons.rate_review_outlined,
                        color: AppColors.deep_orange,
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
              visible: visible,
              child: Column(
                children: [
                  SizedBox(
                      height: 65.h,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Claim details",
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  color: AppColors.deep_orange,
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(right: 240),
                                  height: 7,
                                  color:
                                      AppColors.deep_orange.withOpacity(0.2)),
                            ]),
                      )),
                  Card(
                    margin: EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    elevation: 3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget._claim['Id'],
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 136, 34),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.today,
                                color: Color.fromARGB(255, 255, 136, 34)
                                    .withOpacity(0.5),
                              ),
                            ),
                            Text(
                              "Claiming date : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 136, 34),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 3),
                            ),
                            Text(
                              widget._claim['CreatedAt'].toString(),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text("Customer details",
                                              style: TextStyle(
                                                color: AppColors.deep_orange,
                                              )),
                                          content: Container(
                                              height: 380,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .quick_contacts_mail_rounded,
                                                        color: Color.fromARGB(
                                                                255,
                                                                255,
                                                                136,
                                                                34)
                                                            .withOpacity(0.5),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3),
                                                      ),
                                                      Text(
                                                        "Email address",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              136,
                                                              34),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(widget._claim['Client']
                                                      [5]),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .featured_play_list_rounded,
                                                        color: Color.fromARGB(
                                                                255,
                                                                255,
                                                                136,
                                                                34)
                                                            .withOpacity(0.5),
                                                        size: 24,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3),
                                                      ),
                                                      Text(
                                                        "ID card",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              136,
                                                              34),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 110),
                                                    child: Text(widget
                                                        ._claim['Client'][0]),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .account_box_rounded,
                                                        color: Color.fromARGB(
                                                                255,
                                                                255,
                                                                136,
                                                                34)
                                                            .withOpacity(0.5),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3),
                                                      ),
                                                      Text(
                                                        "Full name",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              136,
                                                              34),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 24),
                                                        child: Text(
                                                            widget._claim[
                                                                'Client'][1]),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 2),
                                                      ),
                                                      Text(widget
                                                          ._claim['Client'][2]),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .quick_contacts_dialer_rounded,
                                                        color: Color.fromARGB(
                                                                255,
                                                                255,
                                                                136,
                                                                34)
                                                            .withOpacity(0.5),
                                                        size: 24,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3),
                                                      ),
                                                      Text(
                                                        "First phone number",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              136,
                                                              34),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 110),
                                                    child: Text(widget
                                                        ._claim['Client'][3]),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .quick_contacts_dialer_rounded,
                                                        color: Color.fromARGB(
                                                                255,
                                                                255,
                                                                136,
                                                                34)
                                                            .withOpacity(0.5),
                                                        size: 24,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3),
                                                      ),
                                                      Text(
                                                        "Second phone number",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              136,
                                                              34),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 110),
                                                    child: Text(widget
                                                        ._claim['Client'][4]),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .location_on_rounded,
                                                        color: Color.fromARGB(
                                                                255,
                                                                255,
                                                                136,
                                                                34)
                                                            .withOpacity(0.5),
                                                        size: 24,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3),
                                                      ),
                                                      Text(
                                                        "Province",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              136,
                                                              34),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 130),
                                                    child: Text(widget
                                                        ._claim['Client'][6]),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .person_pin_circle_rounded,
                                                        color: Color.fromARGB(
                                                                255,
                                                                255,
                                                                136,
                                                                34)
                                                            .withOpacity(0.5),
                                                        size: 24,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3),
                                                      ),
                                                      Text(
                                                        "Address",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              136,
                                                              34),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 90),
                                                    child: Text(widget
                                                        ._claim['Client'][7]),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.today_rounded,
                                                        color: Color.fromARGB(
                                                                255,
                                                                255,
                                                                136,
                                                                34)
                                                            .withOpacity(0.5),
                                                        size: 24,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 3),
                                                      ),
                                                      Text(
                                                        "Availability",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              136,
                                                              34),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 90),
                                                    child: Text(widget
                                                        ._claim['Client'][8]),
                                                  ),
                                                ],
                                              )),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("Close"))
                                          ],
                                        ));
                              },
                              icon: Icon(
                                Icons.location_history_rounded,
                                color: Color.fromARGB(255, 255, 136, 34)
                                    .withOpacity(0.5),
                              ),
                            ),
                            Text(
                              "Customer : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 136, 34),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 3),
                            ),
                            Row(
                              children: [
                                Text(widget._claim['Client'][1]),
                                Padding(
                                  padding: EdgeInsets.only(left: 2),
                                ),
                                Text(widget._claim['Client'][2]),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text("Product details",
                                              style: TextStyle(
                                                color: AppColors.deep_orange,
                                              )),
                                          content: Container(
                                              height: 380,
                                              child: Column(children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.style_rounded,
                                                      color: Color.fromARGB(
                                                              255, 255, 136, 34)
                                                          .withOpacity(0.5),
                                                      size: 24,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3),
                                                    ),
                                                    Text(
                                                      "Brand",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 255, 136, 34),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 160),
                                                  child: Text(widget
                                                      ._claim['Product'][0]),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .shopping_cart_rounded,
                                                      color: Color.fromARGB(
                                                              255, 255, 136, 34)
                                                          .withOpacity(0.5),
                                                      size: 24,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3),
                                                    ),
                                                    Text(
                                                      "Category",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 255, 136, 34),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 150),
                                                  child: Text(widget
                                                      ._claim['Product'][1]),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.view_in_ar_rounded,
                                                      color: Color.fromARGB(
                                                              255, 255, 136, 34)
                                                          .withOpacity(0.5),
                                                      size: 24,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3),
                                                    ),
                                                    Text(
                                                      "Model",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 255, 136, 34),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 100),
                                                  child: Text(widget
                                                      ._claim['Product'][2]),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .sticky_note_2_rounded,
                                                      color: Color.fromARGB(
                                                              255, 255, 136, 34)
                                                          .withOpacity(0.5),
                                                      size: 24,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3),
                                                    ),
                                                    Text(
                                                      "Warranty",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 255, 136, 34),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 160),
                                                  child: Text(widget
                                                      ._claim['Product'][3]),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.pin,
                                                      color: Color.fromARGB(
                                                              255, 255, 136, 34)
                                                          .withOpacity(0.5),
                                                      size: 24,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3),
                                                    ),
                                                    Text(
                                                      "Serial number",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 255, 136, 34),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 100),
                                                  child: Text(widget
                                                      ._claim['Product'][4]),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .store_mall_directory_rounded,
                                                      color: Color.fromARGB(
                                                              255, 255, 136, 34)
                                                          .withOpacity(0.5),
                                                      size: 24,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3),
                                                    ),
                                                    Text(
                                                      "Retailer",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 255, 136, 34),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 160),
                                                  child: Text(widget
                                                      ._claim['Product'][5]),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.today_rounded,
                                                      color: Color.fromARGB(
                                                              255, 255, 136, 34)
                                                          .withOpacity(0.5),
                                                      size: 24,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3),
                                                    ),
                                                    Text(
                                                      "Purchase date",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 255, 136, 34),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 100),
                                                    child: Text(widget
                                                        ._claim['Product'][6])),
                                              ])),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Close")),
                                          ],
                                        ));
                              },
                              icon: Icon(
                                Icons.view_in_ar_rounded,
                                color: Color.fromARGB(255, 255, 136, 34)
                                    .withOpacity(0.5),
                              ),
                            ),
                            Text(
                              "Product : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 136, 34),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 3),
                            ),
                            Text(widget._claim['Product'][2]),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.sticky_note_2_rounded,
                                color: Color.fromARGB(255, 255, 136, 34)
                                    .withOpacity(0.5),
                              ),
                            ),
                            Text(
                              "Warranty : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 136, 34),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 3),
                            ),
                            Text(widget._claim["Product"][3]),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.verified_rounded,
                                color: Color.fromARGB(255, 255, 136, 34)
                                    .withOpacity(0.5),
                              ),
                            ),
                            Text(
                              "Status : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 136, 34),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 3),
                            ),
                            Text(widget._claim['Status']),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.speaker_notes_rounded,
                                color: Color.fromARGB(255, 255, 136, 34)
                                    .withOpacity(0.5),
                              ),
                            ),
                            Text(
                              "Reason: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 136, 34),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 3),
                            ),
                            Text(widget._claim["Reason"]),
                          ],
                        ),
                        Text(""),
                      ],
                    ),
                  ),
                ],
              )),
          Visibility(
              visible: visible1,
              child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 50.h,
                            child: Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Make a happy call",
                                      style: TextStyle(
                                        fontSize: 22.sp,
                                        color: AppColors.deep_orange,
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(right: 170),
                                        height: 7,
                                        color: AppColors.deep_orange
                                            .withOpacity(0.2)),
                                  ]),
                            )),
                        Text(
                          "Product review",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.deep_orange,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'What do you think of our product ?',
                        ),
                        RatingBar.builder(
                            itemBuilder: ((context, _) => Icon(
                                  Icons.star,
                                  color: AppColors.deep_orange,
                                )),
                            itemSize: 30,
                            updateOnDrag: true,
                            unratedColor: const Color(0xffb1c4dd),
                            glowColor: AppColors.deep_orange,
                            onRatingUpdate: (ratingproduct) => setState(() {
                                  this.ratingproduct = ratingproduct;
                                })),
                        Text(
                          "Service review",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.deep_orange,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('What do you think of our services ?'),
                        RatingBar.builder(
                            itemBuilder: ((context, _) => Icon(
                                  Icons.star,
                                  color: AppColors.deep_orange,
                                )),
                            itemSize: 30,
                            updateOnDrag: true,
                            unratedColor: const Color(0xffb1c4dd),
                            glowColor: AppColors.deep_orange,
                            onRatingUpdate: (ratingservices) => setState(() {
                                  this.ratingservices = ratingservices;
                                })),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Was the installer/technician on time ?',
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: RadioListTile(
                                          value: 0,
                                          groupValue: _groupValue,
                                          title: Text("Yes"),
                                          onChanged: (newValue) {
                                            setState(() {
                                              _groupValue = 0;
                                              _ratingpunctualityController
                                                  .text = "Yes";
                                              print(
                                                  _ratingpunctualityController);
                                            });
                                          },
                                          activeColor: AppColors.deep_blue,
                                          selected: false,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: RadioListTile(
                                          value: 1,
                                          groupValue: _groupValue,
                                          title: Text("No"),
                                          onChanged: (newValue) {
                                            setState(() {
                                              _groupValue = 1;
                                              _ratingpunctualityController
                                                  .text = "No";
                                              print(
                                                  _ratingpunctualityController);
                                            });
                                          },
                                          activeColor: AppColors.deep_blue,
                                          selected: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Text('What do you think of his behavior ?'),
                            RatingBar.builder(
                                itemBuilder: ((context, _) => Icon(
                                      Icons.star,
                                      color: AppColors.deep_orange,
                                    )),
                                itemSize: 30,
                                updateOnDrag: true,
                                unratedColor: const Color(0xffb1c4dd),
                                glowColor: AppColors.deep_orange,
                                onRatingUpdate: (ratingbehavior) =>
                                    setState(() {
                                      this.ratingbehavior = ratingbehavior;
                                    })),
                            Text(
                              "Help us !",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: AppColors.deep_orange,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Do you have any suggestions that we can add to our service ?"),
                            TextFormField(
                              controller: _suggestionsController,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 2,
                              decoration:
                                  InputDecoration(labelText: "Suggestions"),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Rate us !",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: AppColors.deep_orange,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('What rating can you give us out of 5 ?'),
                            RatingBar.builder(
                                itemBuilder: ((context, _) => Icon(
                                      Icons.star,
                                      color: AppColors.deep_orange,
                                    )),
                                itemSize: 30,
                                updateOnDrag: true,
                                allowHalfRating: true,
                                unratedColor: const Color(0xffb1c4dd),
                                glowColor: AppColors.deep_orange,
                                onRatingUpdate: (ratingus) => setState(() {
                                      this.ratingus = ratingus;
                                    })),
                            SizedBox(
                              height: 5,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.deep_orange,
                                  minimumSize: const Size.fromHeight(50), // NEW
                                ),
                                onPressed: () {
                                  addHappyCallToDB();
                                },
                                child: Text("Save")),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        )
                      ]))),
          Visibility(
              visible: visible2,
              child: Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _happycall.length,
                      itemBuilder: (_, index) {
                        return Card(
                            margin:
                                EdgeInsets.only(left: 15, right: 15, top: 16),
                            elevation: 3,
                            child: Column(children: [
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Row(
                                  children: [
                                    Icon(Icons.view_in_ar_rounded,
                                        color: Color(0xffb1c4dd)),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    Text(
                                      "Product rating : ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.deep_orange,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    RatingBar.builder(
                                        ignoreGestures: true,
                                        initialRating: _happycall[index]
                                            ["Product-review"],
                                        itemBuilder: ((context, _) => Icon(
                                              Icons.star,
                                              color: AppColors.deep_orange,
                                            )),
                                        itemSize: 30,
                                        updateOnDrag: false,
                                        allowHalfRating: true,
                                        unratedColor: const Color(0xffb1c4dd),
                                        glowColor: AppColors.deep_orange,
                                        onRatingUpdate: (ratingus) =>
                                            setState(() {})),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.home_repair_service_rounded,
                                      color: Color(0xffb1c4dd),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    Text(
                                      "Service rating : ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.deep_orange,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    RatingBar.builder(
                                        ignoreGestures: true,
                                        initialRating: _happycall[index]
                                            ["Service-review"],
                                        itemBuilder: ((context, _) => Icon(
                                              Icons.star,
                                              color: AppColors.deep_orange,
                                            )),
                                        itemSize: 30,
                                        updateOnDrag: false,
                                        allowHalfRating: true,
                                        unratedColor: const Color(0xffb1c4dd),
                                        glowColor: AppColors.deep_orange,
                                        onRatingUpdate: (ratingus) =>
                                            setState(() {})),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.alarm_on_rounded,
                                      color: Color(0xffb1c4dd),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    Text(
                                      "Installer/Technician punctuality : ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.deep_orange,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    Text(
                                      "${_happycall[index]["Punctuality"]}",
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.engineering_rounded,
                                      color: Color(0xffb1c4dd),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    Text(
                                      "Behavior rating ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.deep_orange,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    RatingBar.builder(
                                        ignoreGestures: true,
                                        initialRating: _happycall[index]
                                            ["Behavior-review"],
                                        itemBuilder: ((context, _) => Icon(
                                              Icons.star,
                                              color: AppColors.deep_orange,
                                            )),
                                        itemSize: 30,
                                        updateOnDrag: false,
                                        allowHalfRating: true,
                                        unratedColor: const Color(0xffb1c4dd),
                                        glowColor: AppColors.deep_orange,
                                        onRatingUpdate: (ratingus) =>
                                            setState(() {})),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.settings_suggest_rounded,
                                      color: Color(0xffb1c4dd),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    Text(
                                      "Suggestions : ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.deep_orange,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    Text(
                                      _happycall[index]["Suggestions"],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.rate_review_rounded,
                                      color: Color(0xffb1c4dd),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    Text(
                                      "Rating out of 5",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.deep_orange,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                    ),
                                    RatingBar.builder(
                                        ignoreGestures: true,
                                        initialRating: _happycall[index]
                                            ["Rating"],
                                        itemBuilder: ((context, _) => Icon(
                                              Icons.star,
                                              color: AppColors.deep_orange,
                                            )),
                                        itemSize: 30,
                                        updateOnDrag: false,
                                        allowHalfRating: true,
                                        unratedColor: const Color(0xffb1c4dd),
                                        glowColor: AppColors.deep_orange,
                                        onRatingUpdate: (ratingus) =>
                                            setState(() {})),
                                  ],
                                ),
                              ),
                              Text("")
                            ]));
                      })))
        ])));
  }
}
