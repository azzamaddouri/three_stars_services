// ignore_for_file: prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/claim_details_screen.dart';
import 'package:three_stars_services/ui/claim_form.dart';
import 'package:three_stars_services/ui/filter_screen.dart';
import 'package:three_stars_services/ui/search_screen.dart';
import 'package:three_stars_services/widgets/customButton.dart';

class Claims extends StatefulWidget {
  Claims({Key? key}) : super(key: key);

  @override
  State<Claims> createState() => _ClaimsState();
}

class _ClaimsState extends State<Claims> {
  List _claims = [];
  bool floatbuttonvisible = true;
  var _firestoreInstance = FirebaseFirestore.instance;
  fetchProducts() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("claims-form-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _claims.add({
          "Client": qn.docs[i]["Client"],
          "Product": qn.docs[i]["Product"],
          "CreatedAt": qn.docs[i]["CreatedAt"].toDate(),
          "Status": qn.docs[i]["Status"],
          "Reason": qn.docs[i]["Reason"],
          "Id": qn.docs[i]["Id"],
          "Diagnosis": qn.docs[i]["Diagnosis"],
          "Quote": qn.docs[i]["Quote"],
          "Interventions": qn.docs[i]["Interventions"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: Column(children: [
          Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Row(children: [
                Expanded(
                    child: SizedBox(
                        height: 60.h,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                //<-- SEE HERE
                                color: Colors.black.withOpacity(0.25),
                                offset: Offset(0, 2),
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Search claim here",
                              hintStyle: TextStyle(fontSize: 15.sp),
                              suffixIcon: Icon(
                                Icons.search,
                                color: AppColors.deep_orange,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Colors.white24)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (_) => SearchScreen())),
                          ),
                        ))),
                //Menu
                Padding(padding: EdgeInsets.only(left: 10)),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => FilterScreen()));
                    },
                    child: Container(
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
                          Icons.menu_rounded,
                          color: AppColors.deep_orange,
                        ),
                      ),
                    )),
              ])),
          SizedBox(
            height: 5.h,
          ),
          Expanded(
              child: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.forward) {
                if (!floatbuttonvisible) {
                  setState(() {
                    floatbuttonvisible = true;
                  });
                }
              } else {
                if (notification.direction == ScrollDirection.reverse) {
                  if (floatbuttonvisible) {
                    setState(() {
                      floatbuttonvisible = false;
                    });
                  }
                }
              }
              return true;
            },
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _claims.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ClaimDetails(_claims[index]))),
                    child: Card(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 16),
                      elevation: 3,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${_claims[index]["Id"]}",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 136, 34),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.today,
                                  color: Color.fromARGB(255, 255, 136, 34)
                                      .withOpacity(0.5),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3),
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
                                Text("${_claims[index]["CreatedAt"]}"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_history_rounded,
                                  color: Color.fromARGB(255, 255, 136, 34)
                                      .withOpacity(0.5),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3),
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
                                    Text("${_claims[index]["Client"][1]}"),
                                    Padding(
                                      padding: EdgeInsets.only(left: 2),
                                    ),
                                    Text("${_claims[index]["Client"][2]}"),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on, //location_history_rounded,
                                  color: Color.fromARGB(255, 255, 136, 34)
                                      .withOpacity(0.5),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3),
                                ),
                                Text(
                                  "Location : ",
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
                                    Text("${_claims[index]["Client"][7]} , "),
                                    Padding(
                                      padding: EdgeInsets.only(left: 2),
                                    ),
                                    Text("${_claims[index]["Client"][6]}"),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.view_in_ar_rounded,
                                  color: Color.fromARGB(255, 255, 136, 34)
                                      .withOpacity(0.5),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3),
                                ),
                                Text(
                                  "Product model : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 136, 34),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3),
                                ),
                                Text("${_claims[index]["Product"][2]}"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.sticky_note_2_rounded,
                                  color: Color.fromARGB(255, 255, 136, 34)
                                      .withOpacity(0.5),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3),
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
                                Text("${_claims[index]["Product"][3]}"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.verified_rounded,
                                  color: Color.fromARGB(255, 255, 136, 34)
                                      .withOpacity(0.5),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3),
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
                                Text("${_claims[index]["Status"]}"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.speaker_notes_rounded,
                                  color: Color.fromARGB(255, 255, 136, 34)
                                      .withOpacity(0.5),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 3),
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
                                Text("${_claims[index]["Reason"]}"),
                              ],
                            ),
                          ),
                          Text(""),
                        ],
                      ),
                    ),
                  );
                }),
          ))
        ]))),
        floatingActionButton: floatbuttonvisible
            ? FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ClaimForm()));
                },
                child: Icon(
                  Icons.add,
                  color: AppColors.deep_orange,
                ),
              )
            : null);
  }
}
