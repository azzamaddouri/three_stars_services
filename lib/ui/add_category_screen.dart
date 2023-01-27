// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/bottom_nav_pages/settings.dart';
import 'package:three_stars_services/widgets/myTextField.dart';

class AddCategory extends StatefulWidget {
  AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController _categoryController = TextEditingController();
  List _categories = [];
  List docIds = [];
  addCategoryToDB() async {
    _categories.clear();
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("brands-data");
    QuerySnapshot qn = await collectionRef.get();
    List<QueryDocumentSnapshot> ld = qn.docs;
    setState(() {
      for (int i = 0; i < ld.length; i++) {
        docIds.add(ld[i].id);
        _categories = ld[i]["Categories"];
      }
      _categories
          .add({"Category-name": _categoryController.text, "Models": []});
    });

    for (var i = 0; i < docIds.length; i++) {
      final doc = FirebaseFirestore.instance
          .collection("brands-data")
          .doc(docIds[i])
          .update({"Categories": _categories}).then((value) {
        final snackBar1 = SnackBar(
          content: Text("Category added successfully"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar1);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => SettingsScreen()));
      }).catchError((error) => print("something is wrong. $error"));
    }
  }

  Future addBreakdownTypeToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("breakdowns-data");
    return _collectionRef
        .doc()
        .set({"Category-Name": _categoryController.text, "Breakdown-types": []})
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (_) => SettingsScreen())))
        .catchError((error) => print("something is wrong. $error"));
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
                padding: EdgeInsets.only(left: 15.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Add category",
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
            child: myTextField("Name", TextInputType.text, _categoryController),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                addCategoryToDB();
                addBreakdownTypeToDB();
              },
              child: Text("Save")),
        ])));
  }
}
