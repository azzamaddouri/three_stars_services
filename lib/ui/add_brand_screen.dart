// ignore_for_file: prefer_const_constructors, prefer_final_fields, no_leading_underscores_for_local_identifiers, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/bottom_nav_pages/settings.dart';
import 'package:three_stars_services/widgets/myTextField.dart';

class AddBrand extends StatefulWidget {
  AddBrand({Key? key}) : super(key: key);

  @override
  State<AddBrand> createState() => _AddBrandState();
}

class _AddBrandState extends State<AddBrand> {
  TextEditingController _brandController = TextEditingController();

  Future addBrandToDB() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("brands-data");
    return _collectionRef.doc().set(
        {"Brand-name": _brandController.text, "Categories": []}).then((value) {
      final snackBar1 = SnackBar(
        content: Text("Brand added successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => SettingsScreen()));
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
              width: ScreenUtil().screenWidth,
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
                        "Add brand",
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: AppColors.deep_orange,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 240),
                          height: 7,
                          color: AppColors.deep_orange.withOpacity(0.2)),
                    ]),
              )),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: myTextField("Name", TextInputType.text, _brandController),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                addBrandToDB();
              },
              child: Text("Save")),
        ])));
  }
}
