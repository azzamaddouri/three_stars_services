// ignore_for_file: prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/filter_screen.dart';
import 'package:three_stars_services/ui/intervention_details_screen.dart';
import 'package:three_stars_services/ui/search_screen.dart';

class Interventions extends StatefulWidget {
  Interventions({Key? key}) : super(key: key);

  @override
  State<Interventions> createState() => _InterventionsState();
}

class _InterventionsState extends State<Interventions> {
  List _claims = [];
  bool floatbuttonvisible = true;
  var _firestoreInstance = FirebaseFirestore.instance;
  fetchProducts() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("claims-form-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (qn.docs[i]["Interventions"].isNotEmpty) {
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
            "Intervention": qn.docs[i]["Interventions"]
                [qn.docs[i]["Interventions"].length - 1],
          });
        }
      }
    });
    print(_claims);
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
                            hintText: "Search intervention here",
                            hintStyle: TextStyle(fontSize: 15.sp),
                            suffixIcon: Icon(
                              Icons.search,
                              color: AppColors.deep_orange,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.white24)),
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
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _claims.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => InterventionDetails(_claims[index]))),
                  child: Card(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 16),
                    elevation: 3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _claims[index]["Intervention"]["id"].toString(),
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
                                Icons.pin_rounded,
                                color: Color.fromARGB(255, 255, 136, 34)
                                    .withOpacity(0.5),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 3),
                              ),
                              Text(
                                "Claim : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 136, 34),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 3),
                              ),
                              Text("${_claims[index]["Id"]}"),
                            ],
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
                                "Intervention date : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 136, 34),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 3),
                              ),
                              Text(
                                  "${_claims[index]["Intervention"]["CreatedAt"].toDate()}"),
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
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons
                                    .engineering_rounded, //location_history_rounded,
                                color: Color.fromARGB(255, 255, 136, 34)
                                    .withOpacity(0.5),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 3),
                              ),
                              Text(
                                "Technician : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 136, 34),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 3),
                              ),
                              Text(_claims[index]["Intervention"]
                                  ["Technician-name"]),
                            ],
                          ),
                        ),
                        Text(""),
                      ],
                    ),
                  ),
                );
              }),
        )
      ]))),
    );
  }
}
