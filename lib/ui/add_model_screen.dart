// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:three_stars_services/const/AppColors.dart';
import 'package:three_stars_services/ui/bottom_nav_pages/settings.dart';
import 'package:three_stars_services/widgets/myTextField.dart';

class AddModel extends StatefulWidget {
  AddModel({Key? key}) : super(key: key);

  @override
  State<AddModel> createState() => _AddModelState();
}

class _AddModelState extends State<AddModel> {
  TextEditingController _brandController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  List _brands = [];
  List _categories = [];
  List _models = [];
  List brands = [];
  List categories = [];
  fetchBrands() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection("brands-data").get();
    setState(() {
      _brands.clear();
      for (int i = 0; i < qn.docs.length; i++) {
        _brands.add(
          qn.docs[i]["Brand-name"],
        );
      }
    });
  }

  List<String> Brands() {
    brands.clear();
    _brands.forEach(
      (element) {
        brands.add(element);
      },
    );

    List<String> brandsList = brands.cast<String>();
    return brandsList;
  }

  fetchCategories() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    _categories.clear();
    QuerySnapshot qn = await _firestoreInstance.collection("brands-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        for (var j = 0; j < qn.docs[i]["Categories"].length; j++) {
          _categories.add(qn.docs[i]["Categories"][j]["Category-name"]);
        }
      }
    });
  }

//2
  List<String> Categories() {
    categories.clear();
    _categories.forEach((element) {
      categories.add(element);
    });
    List<String> categoriesList = categories.cast<String>();
    return categoriesList;
  }

  List docIds = [];
  List _categories1 = [];
  String docId = "";

//Model
  addModelToDB() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    _models.clear();
    QuerySnapshot qn = await _firestoreInstance.collection("brands-data").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (qn.docs[i]["Brand-name"] == _brandController.text) {
          for (var j = 0; j < qn.docs[i]["Categories"].length; j++) {
            if (qn.docs[i]["Categories"][j]["Category-name"] ==
                _categoryController.text) {
              docId = qn.docs[i].id;
              _categories1 = qn.docs[i]["Categories"];
              _models = qn.docs[i]["Categories"][j]["Models"];
            }
          }
        }
      }
      _models.add(_modelController.text);
      for (var i = 0; i < _categories1.length; i++) {
        if (_categories1[i]["Category-name"] == _categoryController.text) {
          _categories1[i]["Models"] = _models;
        }
      }
    });
    final doc =
        FirebaseFirestore.instance.collection("brands-data").doc(docId).update({
      "Categories": _categories1,
    }).then((value) {
      final snackBar1 = SnackBar(
        content: Text("Model added successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => SettingsScreen()));
    }).catchError((error) => print("something is wrong. $error"));
  }

  @override
  void initState() {
    super.initState();
    fetchBrands();
    Brands();
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
              height: 120.h,
              width: ScreenUtil().screenWidth,
              child: Padding(
                padding: EdgeInsets.only(left: 15.w, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Add model",
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
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: TextField(
              controller: _brandController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "choose brand",
                prefixIcon: DropdownButton<String>(
                  items: Brands().toSet().toList().map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                      onTap: () {
                        setState(() {
                          _brandController.text = value;
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
                      child: Text(value),
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
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: myTextField("Name", TextInputType.text, _modelController),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                addModelToDB();
              },
              child: Text("Save")),
        ])));
  }
}
