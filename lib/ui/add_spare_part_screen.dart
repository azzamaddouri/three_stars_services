// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/bottom_nav_pages/settings.dart';
import 'package:three_stars_services/ui/settings-spare-parts.dart';
import 'package:three_stars_services/widgets/myTextField.dart';

class AddSparePart extends StatefulWidget {
  AddSparePart({Key? key}) : super(key: key);

  @override
  State<AddSparePart> createState() => _AddSparePartState();
}

class _AddSparePartState extends State<AddSparePart> {
  TextEditingController _breakdowntypeController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _sparepartController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  List _categories = [];
  List categories = [];
  List _breakdownsTypes = [];
  List breakdownsTypes = [];
  fetchCategories() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    _categories.clear();
    QuerySnapshot qn =
        await _firestoreInstance.collection("breakdowns-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _categories.add(qn.docs[i]["Category-Name"]);
      }
    });
  }

  List<String> Categories() {
    categories.clear();
    _categories.forEach((element) {
      categories.add(element);
    });
    List<String> categoriesList = categories.cast<String>();
    return categoriesList;
  }

  fetchBreakdownsTypes() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    _breakdownsTypes.clear();
    QuerySnapshot qn =
        await _firestoreInstance.collection("breakdowns-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        for (var j = 0; j < qn.docs[i]["Breakdown-types"].length; j++) {
          if (qn.docs[i]["Category-Name"] == _categoryController.text) {
            _breakdownsTypes
                .add(qn.docs[i]["Breakdown-types"][j]["Breakdown-type-name"]);
          }
        }
      }
    });
  }

  List<String> BreakdownsTypes() {
    breakdownsTypes.clear();
    _breakdownsTypes.forEach((element) {
      breakdownsTypes.add(element);
    });
    List<String> breakdownsTypesList = breakdownsTypes.cast<String>();
    return breakdownsTypesList;
  }

  addSparePartToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("spare-parts-data");
    _collectionRef.doc().set({
      "SparePart-name": _sparepartController.text,
      "Category-name": _categoryController.text,
      "Breakdown-type-name": _breakdowntypeController.text,
      "Price": _priceController.text
    }).then((value) {
      final snackBar1 = SnackBar(
        content: Text("Spare part added successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => SettingsSapreParts()));
    }).catchError((error) => print("something is wrong. $error"));
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
    Categories();
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
              height: 90.h,
              child: Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Add spare part",
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: AppColors.deep_orange,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 220),
                          height: 7,
                          color: AppColors.deep_orange.withOpacity(0.2)),
                    ]),
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: TextField(
              controller: _categoryController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "choose category",
                prefixIcon: DropdownButton<String>(
                  items: Categories().toSet().toList().map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                      onTap: () {
                        setState(() {
                          _categoryController.text = value;
                        });
                      },
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: TextField(
              controller: _breakdowntypeController,
              readOnly: true,
              onTap: () {
                fetchBreakdownsTypes();
              },
              decoration: InputDecoration(
                hintText: "choose breakdown type",
                prefixIcon: DropdownButton<String>(
                  items: BreakdownsTypes().toSet().toList().map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                      onTap: () {
                        setState(() {
                          _breakdowntypeController.text = value;
                        });
                      },
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child:
                myTextField("Name", TextInputType.text, _sparepartController),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: myTextField("Price", TextInputType.number, _priceController),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                addSparePartToDB();
              },
              child: Text("Save")),
        ])));
  }
}
