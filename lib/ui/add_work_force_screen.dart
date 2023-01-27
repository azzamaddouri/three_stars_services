// ignore_for_file: prefer_final_fields, avoid_print, avoid_unnecessary_containers, prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/bottom_nav_pages/settings.dart';
import 'package:three_stars_services/ui/settings-work-forces.dart';
import 'package:three_stars_services/widgets/myTextField.dart';

class AddWorkForce extends StatefulWidget {
  AddWorkForce({Key? key}) : super(key: key);

  @override
  State<AddWorkForce> createState() => _AddWorkForceState();
}

class _AddWorkForceState extends State<AddWorkForce> {
  TextEditingController _workforceController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  addWorkForceToDB() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("work-forces-data");
    _collectionRef.doc().set({
      "WorkForce-name": _workforceController.text,
      "Price": _priceController.text
    }).then((value) {
      final snackBar1 = SnackBar(
        content: Text("work force added successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => SettingsWorkForces()));
    }).catchError((error) => print("something is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          SizedBox(
              height: 150.h,
              child: Padding(
                padding: EdgeInsets.only(left: 15.w, right: 25),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Add work force",
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: AppColors.deep_orange,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 190),
                          height: 7,
                          color: AppColors.deep_orange.withOpacity(0.2)),
                    ]),
              )),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child:
                myTextField("Name", TextInputType.text, _workforceController),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: myTextField("Price", TextInputType.number, _priceController),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                addWorkForceToDB();
              },
              child: Text("Save")),
        ])));
  }
}
